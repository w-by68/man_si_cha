package com.guchen.agent.trace;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

/**
 * Agent 链路追踪与成本计量。
 *
 * 设计要点：**复用老项目 event_log 表的思路**（老项目 db_tear 里已有
 * event_name / executed_at / affected_rows 的定时任务审计表），
 * 这里把同一套「事件溯源」范式扩展成 Agent 专用：
 *   - agent_trace      ：一次对话一条，记录 token 与耗时
 *   - agent_tool_call  ：每次工具调用一条，写操作带幂等键
 *
 * 写库走 @Async，不能阻塞 SSE 主链路。
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AgentTraceService {

    private final JdbcTemplate jdbcTemplate;

    /**
     * 记录一次 span。intent 是意图路由的判定结果，写入后后台才能按意图做分布统计
     * （此前该列长期为空，导致「意图分布」这类分析完全失效）。
     */
    @Async
    public void recordTrace(String traceId, String sessionId, String spanName, String intent,
                            int promptTokens, int completionTokens, int latencyMs) {
        try {
            double cost = estimateCost(promptTokens, completionTokens);
            jdbcTemplate.update("""
                    INSERT INTO agent_trace
                      (trace_id, session_id, span_name, intent, prompt_tokens, completion_tokens, cost_yuan, latency_ms, created_at)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())
                    """, traceId, sessionId, spanName, intent, promptTokens, completionTokens, cost, latencyMs);
        } catch (Exception e) {
            log.warn("trace 落库失败（不影响主流程）: {}", e.getMessage());
        }
    }

    /**
     * 工具调用记录。
     *
     * 幂等设计：写操作的 idempotent_key = traceId + toolName，
     * 表上建 UNIQUE KEY，重复插入直接忽略 —— 这就是「Agent 重试导致重复下单」的防线。
     * 与老项目 exchange_coupon 存储过程里的 SELECT ... FOR UPDATE 是同一问题的两种解法：
     *   - 老项目：数据库行锁（悲观）
     *   - Agent 侧：唯一键去重（乐观 + 幂等键）
     * 面试时能把这个对比讲清楚，比背八股强得多。
     */
    @Async
    public void recordToolCall(String traceId, String toolName, String args,
                               int latencyMs, boolean writeOperation, int responseCode) {
        try {
            String idempotentKey = writeOperation
                    ? traceId + ":" + toolName
                    : null;

            // 【2026-10-23 修复】落库前脱敏。
            // 工具入参里经常带手机号（add_address、收货地址、用户资料），
            // 实测 377 条 agent_tool_call 中有 105 条 request_body 含完整 11 位手机号 ——
            // 这是明文 PII 持久化，属于合规红线。
            // 这里把 1[3-9]xxxxxxxxx 统一打码为 138****1234，只保留可追溯性，不保留原始号码。
            String safeArgs = maskPhone(args);

            jdbcTemplate.update("""
                    INSERT IGNORE INTO agent_tool_call
                      (trace_id, tool_name, request_body, latency_ms, idempotent_key,
                       response_code, created_at)
                    VALUES (?, ?, ?, ?, ?, ?, NOW())
                    """, traceId, toolName, safeArgs, latencyMs, idempotentKey, responseCode);
        } catch (Exception e) {
            log.warn("工具调用落库失败: {}", e.getMessage());
        }
    }

    /** 手机号脱敏：13812345678 → 138****5678。非手机号内容原样返回。 */
    private static String maskPhone(String text) {
        if (text == null || text.isEmpty()) return text;
        return text.replaceAll("(1[3-9]\\d)\\d{4}(\\d{4})", "$1****$2");
    }

    /**
     * 根据工具返回值推断状态码。
     *
     * 工具返回的是业务 JSON，没有 HTTP 状态码概念，所以这里定义一套约定：
     *   - 含 error 字段        → 500（工具执行失败）
     *   - 含 degraded:true     → 503（后端服务不可用，走了降级）
     *   - 含 auth_expired      → 401（鉴权失效）
     *   - 其余                  → 200
     * 这个判定只用于审计展示，不影响工具本身的返回内容。
     */
    public static int inferResponseCode(String toolOutput) {
        if (toolOutput == null || toolOutput.isBlank()) return 500;
        String s = toolOutput;
        if (s.contains("\"error\"")) return 500;
        if (s.contains("\"degraded\":true") || s.contains("\"degraded\" : true")) return 503;
        if (s.contains("auth_expired")) return 401;
        return 200;
    }

    /**
     * 成本估算。简历上写成本数字必须来自这里聚合的真实 token 数：
     *   SELECT SUM(cost_yuan), AVG(prompt_tokens+completion_tokens) FROM agent_trace;
     */
    private double estimateCost(int promptTokens, int completionTokens) {
        double in = promptTokens / 1_000_000.0 * 1.0;
        double out = completionTokens / 1_000_000.0 * 2.0;
        return Math.round((in + out) * 1_000_000) / 1_000_000.0;
    }
}
