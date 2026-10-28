package com.guchen.agent.admin;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 单会话时间线还原 + 模型切换。
 *
 * 时间线要解决的问题：「这次对话为什么慢 / 卡在哪」。
 * agent_trace 里每次对话只落一条 agent.run（含总耗时），
 * agent_tool_call 里落每次工具调用。把两者按 trace_id + 时间合并成一条时间线，
 * 才能看出「总耗时 6.6 秒里，几轮 LLM 各花了多少、哪个工具最慢」。
 */
@Slf4j
@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminSessionController {

    private final JdbcTemplate jdbc;
    private final com.guchen.agent.llm.LlmConfigService llmConfig;

    /**
     * 会话时间线：给定 sessionId，还原该会话内的全部 span 与工具调用。
     */
    @GetMapping("/session-timeline")
    public Map<String, Object> sessionTimeline(@RequestParam String sessionId) {
        List<Map<String, Object>> spans = jdbc.queryForList(
                "SELECT id, trace_id, session_id, span_name, intent, "
                        + "prompt_tokens, completion_tokens, cost_yuan, latency_ms, created_at "
                        + "FROM agent_trace WHERE session_id = ? ORDER BY id", sessionId);

        List<Map<String, Object>> tools = jdbc.queryForList(
                "SELECT t.id, t.trace_id, t.tool_name, t.response_code, t.latency_ms, "
                        + "t.idempotent_key, t.created_at, t.request_body "
                        + "FROM agent_tool_call t JOIN agent_trace a ON a.trace_id = t.trace_id "
                        + "WHERE a.session_id = ? ORDER BY t.id", sessionId);

        if (spans.isEmpty() && tools.isEmpty()) {
            return Map.of("error", "会话不存在或没有记录: " + sessionId, "sessionId", sessionId);
        }

        // 合并成统一时间线：按时间排序，工具调用挂在对应 span 之后
        List<Map<String, Object>> timeline = new ArrayList<>();
        for (Map<String, Object> s : spans) {
            Map<String, Object> node = new LinkedHashMap<>();
            node.put("type", "span");
            node.put("at", s.get("created_at"));
            node.put("spanName", s.get("span_name"));
            node.put("traceId", s.get("trace_id"));
            node.put("intent", s.get("intent"));
            node.put("latencyMs", s.get("latency_ms"));
            node.put("promptTokens", s.get("prompt_tokens"));
            node.put("completionTokens", s.get("completion_tokens"));
            node.put("costYuan", s.get("cost_yuan"));
            timeline.add(node);
        }
        for (Map<String, Object> t : tools) {
            Map<String, Object> node = new LinkedHashMap<>();
            node.put("type", "tool");
            node.put("at", t.get("created_at"));
            node.put("toolName", t.get("tool_name"));
            node.put("traceId", t.get("trace_id"));
            node.put("responseCode", t.get("response_code"));
            node.put("latencyMs", t.get("latency_ms"));
            node.put("idempotentKey", t.get("idempotent_key"));
            node.put("args", t.get("request_body"));
            timeline.add(node);
        }
        // 按时间升序；同一时刻 span 排在 tool 前（span 是外层容器）
        timeline.sort((a, b) -> {
            String ta = String.valueOf(a.get("at"));
            String tb = String.valueOf(b.get("at"));
            int c = ta.compareTo(tb);
            if (c != 0) return c;
            return "span".equals(a.get("type")) ? -1 : 1;
        });

        // 汇总：便于一眼看出瓶颈
        int totalLatency = spans.stream()
                .mapToInt(s -> toInt(s.get("latency_ms"))).sum();
        int toolLatency = tools.stream()
                .mapToInt(t -> toInt(t.get("latency_ms"))).sum();
        double totalCost = spans.stream()
                .mapToDouble(s -> toDouble(s.get("cost_yuan"))).sum();
        int promptTokens = spans.stream()
                .mapToInt(s -> toInt(s.get("prompt_tokens"))).sum();
        int completionTokens = spans.stream()
                .mapToInt(s -> toInt(s.get("completion_tokens"))).sum();

        Map<String, Object> summary = new LinkedHashMap<>();
        summary.put("spanCount", spans.size());
        summary.put("toolCount", tools.size());
        summary.put("totalLatencyMs", totalLatency);
        summary.put("toolLatencyMs", toolLatency);
        // 工具耗时占比：判断「时间花在工具上还是花在模型上」
        summary.put("toolLatencyPct", totalLatency == 0 ? 0
                : Math.round(toolLatency * 1000.0 / totalLatency) / 10.0);
        summary.put("totalCost", Math.round(totalCost * 1_000_000) / 1_000_000.0);
        summary.put("promptTokens", promptTokens);
        summary.put("completionTokens", completionTokens);

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("sessionId", sessionId);
        out.put("summary", summary);
        out.put("timeline", timeline);
        return out;
    }

    /**
     * 最近的会话列表（按最后活动时间倒序），供页面选择一个会话进入时间线。
     *
     * 用 session_id 分组取 MAX(created_at)，同时带上该会话的总耗时与工具数，
     * 这样列表本身就能看出「哪个会话慢」。
     */
    @GetMapping("/sessions")
    public Map<String, Object> sessions(@RequestParam(defaultValue = "20") int limit) {
        int safe = Math.min(Math.max(limit, 1), 100);
        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT a.session_id, MAX(a.created_at) AS last_at, COUNT(*) AS span_count, "
                        + "SUM(a.latency_ms) AS total_ms, "
                        + "SUM(a.prompt_tokens + a.completion_tokens) AS tokens, "
                        + "SUM(a.cost_yuan) AS cost, "
                        + "(SELECT COUNT(*) FROM agent_tool_call t WHERE t.trace_id IN "
                        + "  (SELECT trace_id FROM agent_trace x WHERE x.session_id = a.session_id)) AS tool_count "
                        + "FROM agent_trace a WHERE a.session_id IS NOT NULL AND a.session_id <> '' "
                        + "GROUP BY a.session_id ORDER BY last_at DESC LIMIT " + safe);
        return Map.of("sessions", rows);
    }

    // ==================== 模型切换 ====================

    /** 当前模型配置 + 可选预设。 */
    @GetMapping("/agent/model")
    public Map<String, Object> modelConfig() {
        Map<String, Object> out = new LinkedHashMap<>(llmConfig.config());
        out.put("presets", llmConfig.presets());
        out.put("cacheTtlMs", llmConfig.cacheTtl());
        out.put("default", llmConfig.defaultModel());
        out.put("defaultBaseUrl", llmConfig.defaultBaseUrl());
        return out;
    }

    /**
     * 切换模型。
     *
     * 切换成功后写一条 agent_trace 作为审计痕迹（span_name=config.model_switch），
     * 这样「谁在什么时候把模型换成什么」在链路上能查到，
     * 出问题时不用翻应用日志。
     */
    @PostMapping("/agent/model")
    public Map<String, Object> switchModel(@RequestBody Map<String, Object> body) {
        String modelId = String.valueOf(body.getOrDefault("model", "")).trim();
        if (modelId.isEmpty()) return Map.of("ok", false, "error", "缺少 model 参数");

        String baseUrl = body.get("baseUrl") == null ? null : String.valueOf(body.get("baseUrl")).trim();
        String apiKey = body.get("apiKey") == null ? null : String.valueOf(body.get("apiKey")).trim();
        Map<String, Object> r = llmConfig.updateConfig(modelId,
                (baseUrl != null && !baseUrl.isBlank()) ? baseUrl : null,
                (apiKey != null && !apiKey.isBlank()) ? apiKey : null);
        if (Boolean.TRUE.equals(r.get("ok"))) {
            try {
                jdbc.update("INSERT INTO agent_trace "
                                + "(trace_id, session_id, span_name, intent, prompt_tokens, completion_tokens, "
                                + " cost_yuan, latency_ms, created_at) "
                                + "VALUES (?, 'admin', 'config.model_switch', ?, 0, 0, 0, 0, NOW())",
                        "cfg-" + System.currentTimeMillis(), "switch:" + modelId);
            } catch (Exception e) {
                log.warn("模型切换审计落库失败（不影响切换本身）: {}", e.getMessage());
            }
        }
        return r;
    }

    // ==================== 客服配置管理 ====================

    private static final String CS_KEY = "agent:config:support";
    private final org.springframework.data.redis.core.StringRedisTemplate redis;

    /** 读取客服配置（后台编辑表单回填用）。 */
    @GetMapping("/support-config")
    public Map<String, Object> getSupportConfig() {
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("hotline", "400-800-1234");
        out.put("workTime", "周一至周日 9:00-21:00");
        out.put("wechat", "mansitea-kefu");
        try {
            Map<Object, Object> raw = redis.opsForHash().entries(CS_KEY);
            for (String f : List.of("hotline", "workTime", "wechat")) {
                if (raw.get(f) != null) out.put(f, String.valueOf(raw.get(f)));
            }
            if (raw.get("faq_json") != null) {
                out.put("faq", new com.fasterxml.jackson.databind.ObjectMapper()
                        .readValue(String.valueOf(raw.get("faq_json")),
                                new com.fasterxml.jackson.core.type.TypeReference<List<Map<String, String>>>() {}));
            }
        } catch (Exception e) {
            // 用默认值
        }
        return out;
    }

    /** 保存客服配置。faq 为 [{q, a}] 数组。 */
    @PostMapping("/support-config")
    public Map<String, Object> saveSupportConfig(@RequestBody Map<String, Object> body) {
        try {
            if (body.get("hotline") != null) redis.opsForHash().put(CS_KEY, "hotline", String.valueOf(body.get("hotline")));
            if (body.get("workTime") != null) redis.opsForHash().put(CS_KEY, "workTime", String.valueOf(body.get("workTime")));
            if (body.get("wechat") != null) redis.opsForHash().put(CS_KEY, "wechat", String.valueOf(body.get("wechat")));
            if (body.get("faq") != null) {
                String json = new com.fasterxml.jackson.databind.ObjectMapper().writeValueAsString(body.get("faq"));
                redis.opsForHash().put(CS_KEY, "faq_json", json);
            }
            log.info("客服配置已更新");
            return Map.of("ok", true);
        } catch (Exception e) {
            return Map.of("ok", false, "error", e.getMessage());
        }
    }

    // ==================== 内部工具 ====================

    private int toInt(Object o) {
        if (o == null) return 0;
        if (o instanceof Number n) return n.intValue();
        return 0;
    }

    private double toDouble(Object o) {
        if (o == null) return 0;
        if (o instanceof Number n) return n.doubleValue();
        return 0;
    }
}
