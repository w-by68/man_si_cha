package com.guchen.agent.admin;

import com.guchen.agent.agent.AgentOrchestrator;
import com.guchen.agent.rag.KnowledgeAdminController;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 运营后台聚合查询。
 *
 * 为什么不复用现有接口：
 *   /knowledge/ingest、/eval/recall、/eval/runs 都是**面向执行的原始接口**，
 *   返回的是运行结果本身。后台需要的是「跨表聚合的业务视图」——
 *   比如「今天的调用量、意图分布、RAG 各路线命中率对比、成本趋势」，
 *   这些都要 join agent_trace / agent_tool_call / eval_run 后现算。
 *   所以单独放一层，不动原有接口语义，老调用方（评测脚本、chat.html）零影响。
 *
 * 分页统一用 limit/offset，数据量在演示场景下（万级）足够，
 * 不引入 PageHelper 之类的分页组件。
 */
@Slf4j
@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminController {

    private final JdbcTemplate jdbcTemplate;
    private final KnowledgeAdminController knowledgeAdminController;
    private final AgentOrchestrator orchestrator;

    /**
     * 首页概览：四个指标卡 + 近 7 日趋势 + 意图分布 + 工具调用 TopN。
     *
     * 一次请求返回全部首页数据，避免前端开 6 个并发请求打满连接池。
     */
    @GetMapping("/overview")
    public Map<String, Object> overview() {
        Map<String, Object> out = new LinkedHashMap<>();

        // ---- 指标卡：总量 ----
        Map<String, Object> cards = new LinkedHashMap<>();
        cards.put("chunks", count("SELECT COUNT(*) FROM kb_chunk"));
        cards.put("documents", count("SELECT COUNT(*) FROM kb_document"));
        cards.put("traces", count("SELECT COUNT(*) FROM agent_trace"));
        cards.put("toolCalls", count("SELECT COUNT(*) FROM agent_tool_call"));

        // ---- 指标卡：今日增量 ----
        cards.put("tracesToday", count(
                "SELECT COUNT(*) FROM agent_trace WHERE DATE(created_at) = CURDATE()"));
        cards.put("toolCallsToday", count(
                "SELECT COUNT(*) FROM agent_tool_call WHERE DATE(created_at) = CURDATE()"));

        // ---- 指标卡：成本与耗时（累计） ----
        Map<String, Object> agg = jdbcTemplate.queryForMap(
                "SELECT COALESCE(SUM(cost_yuan),0) AS cost, "
                        + "COALESCE(SUM(prompt_tokens),0) AS pt, "
                        + "COALESCE(SUM(completion_tokens),0) AS ct, "
                        + "COALESCE(ROUND(AVG(latency_ms)),0) AS avg_ms "
                        + "FROM agent_trace");
        cards.put("totalCost", agg.get("cost"));
        cards.put("promptTokens", agg.get("pt"));
        cards.put("completionTokens", agg.get("ct"));
        cards.put("avgLatency", agg.get("avg_ms"));
        out.put("cards", cards);

        // 最新一条 trace 的时间：趋势图为空时前端用它说明「数据截止到哪」
        cards.put("latestTraceAt", latestTraceAt());

        // ---- 近 7 日趋势：按天聚合调用量与成本 ----
        // 用 DATE(created_at) 分组；没有数据的日期不会出现，前端自行补零
        out.put("trend", jdbcTemplate.queryForList(
                "SELECT DATE(created_at) AS d, COUNT(*) AS calls, "
                        + "COALESCE(SUM(cost_yuan),0) AS cost "
                        + "FROM agent_trace "
                        + "WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL 6 DAY) "
                        + "GROUP BY DATE(created_at) ORDER BY d"));

        // ---- 意图分布：intent 为空的记录归到「未识别」 ----
        out.put("intents", jdbcTemplate.queryForList(
                "SELECT COALESCE(NULLIF(intent,''),'未识别') AS intent, COUNT(*) AS c "
                        + "FROM agent_trace GROUP BY intent ORDER BY c DESC LIMIT 10"));

        // ---- 工具调用 TopN ----
        out.put("tools", jdbcTemplate.queryForList(
                "SELECT tool_name, COUNT(*) AS c, "
                        + "COALESCE(ROUND(AVG(latency_ms)),0) AS avg_ms "
                        + "FROM agent_tool_call GROUP BY tool_name ORDER BY c DESC LIMIT 10"));

        // ---- 阶段耗时：按 span_name 分布（agent.run / rag.retrieve / llm.chat） ----
        out.put("spans", jdbcTemplate.queryForList(
                "SELECT span_name, COUNT(*) AS c, "
                        + "COALESCE(ROUND(AVG(latency_ms)),0) AS avg_ms, "
                        + "COALESCE(MAX(latency_ms),0) AS max_ms "
                        + "FROM agent_trace GROUP BY span_name ORDER BY c DESC"));

        return out;
    }

    /**
     * 链路追踪明细。支持按 sessionId / spanName / 时间范围过滤。
     *
     * 用途：线上排查时定位「某次对话为什么慢 / 花了多少 token」。
     */
    @GetMapping("/traces")
    public Map<String, Object> traces(
            @RequestParam(required = false) String sessionId,
            @RequestParam(required = false) String spanName,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        StringBuilder where = new StringBuilder(" WHERE 1=1");
        java.util.List<Object> args = new java.util.ArrayList<>();

        if (sessionId != null && !sessionId.isBlank()) {
            where.append(" AND session_id = ?");
            args.add(sessionId.trim());
        }
        if (spanName != null && !spanName.isBlank()) {
            where.append(" AND span_name = ?");
            args.add(spanName.trim());
        }

        int total = count("SELECT COUNT(*) FROM agent_trace" + where, args.toArray());
        int safePage = Math.max(page, 1);
        int offset = (safePage - 1) * size;

        // LIMIT/OFFSET 用字符串拼接而非占位符：MySQL 对预处理占位符在 LIMIT 位置支持不稳，
        // 且 size/offset 已在下方做范围钳制，不存在注入面。
        int safeSize = Math.min(Math.max(size, 1), 200);
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(
                "SELECT id, trace_id, session_id, span_name, intent, "
                        + "prompt_tokens, completion_tokens, cost_yuan, latency_ms, created_at "
                        + "FROM agent_trace" + where
                        + " ORDER BY id DESC LIMIT " + safeSize + " OFFSET " + offset,
                args.toArray());

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("total", total);
        out.put("page", safePage);
        out.put("size", safeSize);
        out.put("rows", rows);
        return out;
    }

    /**
     * 单次会话的完整链路：给定 sessionId，按 trace_id 还原一次对话经历的各个 span。
     *
     * 这是「可观测性」真正有用的地方——把散落的 span 拼成一条时间线。
     */
    @GetMapping("/session")
    public Map<String, Object> session(@RequestParam String sessionId) {
        List<Map<String, Object>> spans = jdbcTemplate.queryForList(
                "SELECT trace_id, span_name, intent, prompt_tokens, completion_tokens, "
                        + "cost_yuan, latency_ms, created_at "
                        + "FROM agent_trace WHERE session_id = ? ORDER BY id",
                sessionId);

        List<Map<String, Object>> tools = jdbcTemplate.queryForList(
                "SELECT t.trace_id, t.tool_name, t.response_code, t.latency_ms, t.created_at "
                        + "FROM agent_tool_call t "
                        + "JOIN agent_trace a ON a.trace_id = t.trace_id "
                        + "WHERE a.session_id = ? ORDER BY t.id",
                sessionId);

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("sessionId", sessionId);
        out.put("spans", spans);
        out.put("tools", tools);
        return out;
    }

    /**
     * 工具调用审计。写操作与读操作分开统计，便于核对「是否有异常写」。
     */
    @GetMapping("/tools")
    public Map<String, Object> tools(
            @RequestParam(required = false) String toolName,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        StringBuilder where = new StringBuilder(" WHERE 1=1");
        java.util.List<Object> args = new java.util.ArrayList<>();
        if (toolName != null && !toolName.isBlank()) {
            where.append(" AND tool_name = ?");
            args.add(toolName.trim());
        }

        int total = count("SELECT COUNT(*) FROM agent_tool_call" + where, args.toArray());
        int safePage = Math.max(page, 1);
        int offset = (safePage - 1) * size;
        int safeSize = Math.min(Math.max(size, 1), 200);

        List<Map<String, Object>> rows = jdbcTemplate.queryForList(
                "SELECT id, trace_id, tool_name, response_code, latency_ms, "
                        + "idempotent_key, created_at "
                        + "FROM agent_tool_call" + where
                        + " ORDER BY id DESC LIMIT " + safeSize + " OFFSET " + offset,
                args.toArray());

        // 幂等键命中数：写操作去重实际生效的次数（非空即写操作）
        int writeCalls = count(
                "SELECT COUNT(*) FROM agent_tool_call WHERE idempotent_key IS NOT NULL");

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("total", total);
        out.put("writeCalls", writeCalls);
        out.put("page", safePage);
        out.put("size", safeSize);
        out.put("rows", rows);
        return out;
    }

    /**
     * 知识库：文档列表 + 每篇文档的块数与状态。
     *
     * 前端的「重建向量索引」按钮调用的仍是原有 POST /api/agent/knowledge/ingest，
     * 这里只负责把库里的状态读出来展示，不重复实现入库逻辑。
     */
    @GetMapping("/knowledge")
    public Map<String, Object> knowledge() {
        Map<String, Object> out = new LinkedHashMap<>();

        out.put("documents", jdbcTemplate.queryForList(
                "SELECT d.id, d.title, d.source_type, d.chunk_count, d.status, d.updated_at, "
                        + "COUNT(c.id) AS actual_chunks "
                        + "FROM kb_document d LEFT JOIN kb_chunk c ON c.document_id = d.id "
                        + "GROUP BY d.id ORDER BY d.id"));

        // 向量化覆盖度：**以 Qdrant 实际点数为准**，不看 kb_chunk.vector_id。
        // 原因：入库实现是「chunk id 派生确定性 UUID 写入 Qdrant」，MySQL 侧不回写，
        // 该列恒为空。若拿它当覆盖率，会误报「126 块全部未向量化」——事实上向量腿是正常的。
        out.put("total", count("SELECT COUNT(*) FROM kb_chunk"));
        out.put("vectorPoints", vectorPointCount());

        // 块长度分布：判断切分是否均衡（过短/过长都说明切分策略有问题）
        out.put("lengthBuckets", jdbcTemplate.queryForList(
                "SELECT CASE "
                        + "  WHEN CHAR_LENGTH(content) < 100 THEN '<100' "
                        + "  WHEN CHAR_LENGTH(content) < 200 THEN '100-200' "
                        + "  WHEN CHAR_LENGTH(content) < 400 THEN '200-400' "
                        + "  WHEN CHAR_LENGTH(content) < 800 THEN '400-800' "
                        + "  ELSE '>=800' END AS bucket, "
                        + "COUNT(*) AS c "
                        + "FROM kb_chunk GROUP BY bucket "
                        + "ORDER BY FIELD(bucket,'<100','100-200','200-400','400-800','>=800')"));

        return out;
    }

    /**
     * RAG 评测：各检索路线的 Recall@5 对比 + 逐条明细。
     *
     * 这里直接把 eval_run 的聚合结果算出来，让「四路消融」在页面上可见，
     * 而不是要求人跑 curl 再看 JSON。
     */
    @GetMapping("/eval")
    public Map<String, Object> eval() {
        Map<String, Object> out = new LinkedHashMap<>();

        out.put("runs", jdbcTemplate.queryForList(
                "SELECT run_name, COUNT(*) AS cases, SUM(hit_at_5) AS hits, "
                        + "ROUND(AVG(hit_at_5)*100, 2) AS recall_pct, "
                        + "ROUND(AVG(latency_ms)) AS avg_ms, MAX(created_at) AS last_run "
                        + "FROM eval_run GROUP BY run_name ORDER BY recall_pct DESC"));

        out.put("cases", count("SELECT COUNT(*) FROM eval_case"));

        // 按分类看命中率：定位「哪种类型的问题最差」
        out.put("byCategory", jdbcTemplate.queryForList(
                "SELECT e.category, COUNT(*) AS c, "
                        + "ROUND(AVG(r.hit_at_5)*100, 2) AS recall_pct "
                        + "FROM eval_run r JOIN eval_case e ON e.id = r.case_id "
                        + "WHERE r.run_name = 'hybrid' AND e.category IS NOT NULL "
                        + "GROUP BY e.category ORDER BY recall_pct DESC"));

        return out;
    }

    /**
     * 重建向量索引：直接复用 KnowledgeAdminController#ingestAll，
     * 不在后台层重复实现一遍「读 kb_chunk → 调 BGE-M3 → upsert Qdrant」。
     *
     * 这样后台按钮与刷库脚本走的是同一条代码路径，
     * 不会出现「后台点的结果和命令行跑的结果不一致」这类分叉问题。
     */
    @PostMapping("/knowledge/rebuild")
    public Map<String, Object> rebuildKnowledge() {
        log.info("后台触发知识库重建向量索引");
        return knowledgeAdminController.ingestAll();
    }

    /**
     * 意图路由试算器：输入一句话，返回命中的意图分支、候选工具集、是否触发 RAG。
     *
     * 直接调用 AgentOrchestrator#debugRoute —— 与线上真实路由是**同一份代码**。
     * 若这里另写一套关键词匹配，试算结果就只是「模拟」，与实际行为分叉后极难发现，
     * 那这个功能也就失去了意义。
     */
    @PostMapping("/agent/route-test")
    public Map<String, Object> routeTest(@RequestBody Map<String, String> body) {
        String input = body == null ? "" : body.getOrDefault("q", "");
        if (input.isBlank()) {
            return Map.of("error", "请输入要测试的句子");
        }
        return orchestrator.debugRoute(input);
    }

    /**
     * 路由规则清单：把 13 个分支的「意图名 → 关键词 → 工具集」列出来，供后台展示。
     *
     * 关键词清单在此处维护一份只读副本用于展示；
     * 判定本身仍走 detectIntent，所以即使这里漏写某个关键词，也不影响试算结果的正确性。
     */
    @GetMapping("/agent/routes")
    public Map<String, Object> routes() {
        List<Map<String, Object>> rules = new java.util.ArrayList<>();
        for (String intent : List.of("cart", "order", "order_natural", "order_buy",
                "address_change", "order_query", "coupon", "address", "category",
                "shop", "theme", "confirm", "fallback")) {
            Map<String, Object> r = new LinkedHashMap<>();
            r.put("intent", intent);
            r.put("tools", orchestrator.debugRoute(intentProbe(intent)).get("tools"));
            rules.add(r);
        }
        return Map.of("rules", rules,
                "note", "分支顺序即优先级：cart 先于 order，避免「买X加入购物车」被下单分支抢走");
    }

    /** 为每个意图构造一句能命中它的探测语，用于取回该分支的工具集。 */
    private String intentProbe(String intent) {
        return switch (intent) {
            case "cart" -> "购物车";
            case "order" -> "下单";
            case "order_natural" -> "我要一斤";
            case "order_buy" -> "买";
            case "address_change" -> "改地址";
            case "order_query" -> "订单";
            case "coupon" -> "优惠券";
            case "address" -> "收货地址";
            case "category" -> "分类";
            case "shop" -> "店铺";
            case "theme" -> "主题";
            case "confirm" -> "确认";
            default -> "你好";
        };
    }

    // ---------------- 内部工具方法 ----------------

    /** 最新一条 trace 的时间，供前端在趋势图空态时说明数据截止点。 */
    private String latestTraceAt() {
        try {
            java.sql.Timestamp ts = jdbcTemplate.queryForObject(
                    "SELECT MAX(created_at) FROM agent_trace", java.sql.Timestamp.class);
            return ts == null ? null : ts.toString();
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 查询 Qdrant 集合中的实际点数。
     *
     * 管理后台需要区分「MySQL 里有多少块」和「向量库里有多少点」——
     * 两者数量不一致通常意味着入库没跑完，或知识块改过但没重建索引。
     * 这个区别是排查 RAG 问题的第一现场。
     *
     * 查询失败返回 -1（而不是抛异常），因为 Qdrant 没启动时后台其余功能仍应可用。
     */
    private int vectorPointCount() {
        try {
            // Qdrant 与 agent-service 同机部署，端口固定 6333；
            // 集合名与 KnowledgeAdminController 保持一致
            java.net.http.HttpClient client = java.net.http.HttpClient.newHttpClient();
            java.net.http.HttpRequest req = java.net.http.HttpRequest.newBuilder()
                    .uri(java.net.URI.create("http://127.0.0.1:6333/collections/ms_tea_knowledge"))
                    .timeout(java.time.Duration.ofSeconds(2))
                    .GET().build();
            var resp = client.send(req, java.net.http.HttpResponse.BodyHandlers.ofString());
            if (resp.statusCode() != 200) return -1;
            com.fasterxml.jackson.databind.JsonNode node =
                    new com.fasterxml.jackson.databind.ObjectMapper().readTree(resp.body());
            return node.path("result").path("points_count").asInt(-1);
        } catch (Exception e) {
            log.debug("Qdrant 点数查询失败（不影响其他功能）: {}", e.getMessage());
            return -1;
        }
    }

    private int count(String sql, Object... args) {
        Integer n = jdbcTemplate.queryForObject(sql, Integer.class, args);
        return n == null ? 0 : n;
    }
}
