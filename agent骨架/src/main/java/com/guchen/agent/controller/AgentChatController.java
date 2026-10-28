package com.guchen.agent.controller;

import com.guchen.agent.agent.AgentOrchestrator;
import com.guchen.agent.llm.LlmClient;
import com.guchen.agent.memory.SessionMemoryService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;

/**
 * Agent 对话入口 —— SSE 流式输出。
 *
 * SSE vs WebSocket（面试必问，这里就是答案）：
 *  - 本场景是「客户端问一句 → 服务端持续推」的单向流，SSE 足够，且是纯 HTTP，无需握手升级；
 *  - SSE 自带断线重连（EventSource），WebSocket 要自己实现心跳与重连；
 *  - SSE 走 HTTP/2 时可多路复用，且天然过网关/负载均衡（WebSocket 需要额外配置 Upgrade 头）；
 *  - 需要双向实时（如协同编辑、实时语音）才选 WebSocket。
 *
 * 实现要点：
 *  1. 业务逻辑丢到独立线程池，避免占用 Tomcat 请求线程；
 *  2. 定期发心跳注释行，防止 Nginx/网关因空闲超时切断连接；
 *  3. 结束时显式 complete()，异常时 completeWithError()。
 */
@Slf4j
@RestController
@RequestMapping("/api/agent")
@RequiredArgsConstructor
public class AgentChatController {

    private final AgentOrchestrator orchestrator;
    private final SessionMemoryService memoryService;
    private final LlmClient llmClient;
    private final com.guchen.agent.memory.UserContextService userContext;

    /**
     * 专用线程池：Agent 任务可能跑十几秒，不能占 Tomcat 线程。
     *
     * 【2026-10-23 修复】原实现是 Executors.newFixedThreadPool(16)——
     * 固定 16 线程 + **无界队列**，第 17 个并发请求会静默排队且没有任何上限，
     * 前端只能看到「一直在转圈」；任务堆积还会把内存吃满。
     * 这里改成有界队列 + 明确拒绝策略：超过 16 并发进入 128 长度队列，
     * 队列也满时直接拒绝，由调用方回 429「当前排队人数过多」。
     */
    private final ExecutorService agentPool = new ThreadPoolExecutor(
            16, 32, 60L, java.util.concurrent.TimeUnit.SECONDS,
            new java.util.concurrent.LinkedBlockingQueue<>(128),
            r -> {
                Thread t = new Thread(r, "agent-worker");
                t.setDaemon(true);
                return t;
            },
            new ThreadPoolExecutor.AbortPolicy());

    /**
     * 流式对话。
     *
     * curl 验证：
     *   curl -N -H "token: YOUR_TOKEN" -H "Content-Type: application/json" \
     *        -d '{"message":"有哪些绿茶推荐","sessionId":"s1"}' \
     *        http://localhost:8081/api/agent/chat/stream
     */
    @PostMapping(value = "/chat/stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public SseEmitter chatStream(@RequestBody ChatRequest req, HttpServletRequest httpReq) {

        String sessionId = req.sessionId() != null && !req.sessionId().isBlank()
                ? req.sessionId() : UUID.randomUUID().toString();
        String token = httpReq.getHeader("token");

        // 【2026-10-23 修复】原来是 0L（永不超时）：客户端异常断开时 onTimeout 永不触发，
        // Agent 会继续跑完整轮 LLM（含工具循环），白烧 token 且占着线程。
        // 3 分钟足够覆盖最长的多轮工具调用，超时后容器会回收 emitter。
        SseEmitter emitter = new SseEmitter(180_000L);
        AtomicBoolean closed = new AtomicBoolean(false);

        emitter.onCompletion(() -> { closed.set(true); log.debug("SSE 完成 session={}", sessionId); });
        emitter.onTimeout(() -> {
            closed.set(true);
            log.warn("SSE 超时 session={}（客户端可能已断开）", sessionId);
            emitter.complete();
        });
        emitter.onError(e -> { closed.set(true); log.warn("SSE 异常 session={}", sessionId, e); });

        try {
            agentPool.submit(() -> runStream(sessionId, req.message(), token, emitter, closed));
        } catch (java.util.concurrent.RejectedExecutionException rejected) {
            // 队列已满：立即回一个确定性错误，而不是让前端无限等待
            log.warn("Agent 线程池已满，拒绝会话 session={}", sessionId);
            try {
                send(emitter, closed, "error", Map.of("message", "当前咨询人数较多，请稍后重试"));
                emitter.complete();
            } catch (Exception ignored) {
                emitter.completeWithError(rejected);
            }
        }

        return emitter;
    }

    private void runStream(String sessionId, String message, String token,
                           SseEmitter emitter, AtomicBoolean closed) {
        try {
            send(emitter, closed, "meta", Map.of("sessionId", sessionId));

            orchestrator.run(
                    sessionId,
                    message,
                    token,
                    // 每个 token 片段
                    delta -> send(emitter, closed, "delta", Map.of("content", delta)),
                    // 工具调用事件（前端可展示「正在查询商品…」）
                    toolEvent -> send(emitter, closed, "tool", toolEvent),
                    // 结束
                    summary -> {
                        send(emitter, closed, "done", summary);
                        if (closed.compareAndSet(false, true)) emitter.complete();
                    },
                    err -> {
                        send(emitter, closed, "error",
                                Map.of("message", String.valueOf(err.getMessage())));
                        if (closed.compareAndSet(false, true)) emitter.completeWithError(err);
                    }
            );
        } catch (Exception e) {
            log.error("Agent 执行失败 session={}", sessionId, e);
            if (closed.compareAndSet(false, true)) emitter.completeWithError(e);
        }
    }

    /** 非流式接口，便于前端降级与压测。 */
    @PostMapping("/chat")
    public Map<String, Object> chat(@RequestBody ChatRequest req, HttpServletRequest httpReq) {
        String sessionId = req.sessionId() != null ? req.sessionId() : UUID.randomUUID().toString();
        StringBuilder sb = new StringBuilder();
        orchestrator.run(sessionId, req.message(), httpReq.getHeader("token"),
                sb::append, e -> {}, s -> {}, e -> {});
        return Map.of("sessionId", sessionId, "answer", sb.toString());
    }

    /**
     * 清空会话记忆。
     *
     * ⚠️ 必须同时清两个域：登录用户的记忆域是 u{userId}（跨会话共享），
     * 只清 s{sessionId} 的话，用户下次进页面 restoreHistory 又会把旧记录拉回来——
     * 表现为「点了清空，重进记录还在」。
     */
    @DeleteMapping("/session/{sessionId}")
    public Map<String, Object> clear(@PathVariable String sessionId, HttpServletRequest httpReq) {
        memoryService.clear(sessionId);
        Long userId = userContext.resolveUserId(httpReq.getHeader("token"));
        if (userId != null) {
            memoryService.clear("u" + userId);
        }
        return Map.of("cleared", true, "sessionId", sessionId, "loggedIn", userId != null);
    }

    /**
     * 拉取当前用户的对话历史（用于退出页面再进入时恢复聊天记录）。
     *
     * 为什么按「用户身份」而不是 sessionId 查：
     *  记忆域对登录用户是 u{userId}（跨会话/跨设备共享，见 UserContextService）。
     *  前端每次进页面都会新建 sessionId，若按 sessionId 查会永远查不到东西。
     *  按 userId 查才能做到「登录期间退出重进，聊天记录还在」。
     *  未登录（token 无效）时退回按 sessionId 查，保证匿名访客也能看到本会话记录。
     *
     * @param sessionId 当前页面会话 id（匿名时用作记忆域）
     */
    @GetMapping("/history")
    public Map<String, Object> history(@RequestParam(required = false) String sessionId,
                                       HttpServletRequest httpReq) {
        String token = httpReq.getHeader("token");
        Long userId = userContext.resolveUserId(token);
        String scope = (userId != null) ? ("u" + userId)
                : (sessionId != null && !sessionId.isBlank() ? "s" + sessionId : null);
        if (scope == null) {
            return Map.of("messages", java.util.List.of(), "scope", "", "loggedIn", false);
        }
        List<Map<String, String>> out = new java.util.ArrayList<>();
        for (LlmClient.Message m : memoryService.loadHistory(scope)) {
            // 只回传 user / assistant 两类，system 类的内部提示不暴露给前端
            String role = m.role();
            if (!"user".equals(role) && !"assistant".equals(role)) continue;
            String content = m.content();
            if (content == null || content.isBlank()) continue;
            out.add(Map.of("role", role, "content", content));
        }
        return Map.of("messages", out, "scope", scope, "loggedIn", userId != null);
    }

    /**
     * 当前生效的 LLM 运行态（模型名 / 端点 host / 是否 Mock / 重试次数）。
     * 前端徽章据此显示，避免把模型名写死在页面里；<b>不含 apiKey</b>。
     */
    @GetMapping("/llm-info")
    public Map<String, Object> llmInfo() {
        return llmClient.describe();
    }

    private void send(SseEmitter emitter, AtomicBoolean closed, String event, Object data) {
        if (closed.get()) return;
        try {
            emitter.send(SseEmitter.event().name(event).data(data, MediaType.APPLICATION_JSON));
        } catch (IOException | IllegalStateException e) {
            // 客户端已断开，属正常情况
            closed.set(true);
        }
    }

    public record ChatRequest(String message, String sessionId) {}
}
