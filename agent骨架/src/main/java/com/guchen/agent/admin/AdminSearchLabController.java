package com.guchen.agent.admin;

import com.guchen.agent.rag.HybridRetriever;
import com.guchen.agent.rag.HybridRetriever.RetrievalMode;
import com.guchen.agent.rag.HybridRetriever.RetrievedChunk;
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
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 检索测试台：把四路检索的结果并排展示，让「混合检索到底有没有用」变成可看见的东西。
 *
 * 这是整个后台演示价值最高的功能，原因不是技术含量，而是**它能把一份 markdown 报告
 * 变成可以当场输入的交互界面**。面试官问「你怎么证明混合检索有效」，不用讲 PPT，
 * 输一句话就能看见 BM25 漏召、向量召回、重排后命中。
 *
 * 复用 HybridRetriever 的四种模式，不重新实现检索逻辑——
 * 若这里另写一套，测试台的结果与线上的实际行为就会分叉，那它就没有证明力了。
 */
@Slf4j
@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminSearchLabController {

    private static final int DEFAULT_TOPK = 5;

    private final HybridRetriever retriever;
    private final JdbcTemplate jdbc;

    /**
     * 四路检索并排对比。
     *
     * 若该问题在评测集中存在（按问题文本精确匹配），会带出期望块 ID 并判定各路命中情况；
     * 否则只返回检索结果，不做命中判定（没有标准答案就不该编造判定）。
     */
    @PostMapping("/search-lab")
    public Map<String, Object> searchLab(@RequestBody Map<String, Object> body) {
        String q = String.valueOf(body.getOrDefault("q", "")).trim();
        if (q.isEmpty()) return Map.of("error", "请输入检索问题");
        int topK = body.get("topK") == null ? DEFAULT_TOPK
                : Math.min(Math.max(Integer.parseInt(String.valueOf(body.get("topK"))), 1), 20);

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("query", q);
        out.put("topK", topK);

        // 期望答案：该问题在评测集里吗？
        List<Map<String, Object>> cases = jdbc.queryForList(
                "SELECT id, question, expected_chunk_ids, category FROM eval_case WHERE question = ? LIMIT 1", q);
        Set<String> expected = new LinkedHashSet<>();
        if (!cases.isEmpty()) {
            out.put("evalCase", cases.get(0));
            expected.addAll(parseIds(cases.get(0).get("expected_chunk_ids")));
            out.put("hasExpected", !expected.isEmpty());
        } else {
            out.put("hasExpected", false);
            out.put("evalCase", null);
        }

        // 四路各跑一次，独立计时
        List<Map<String, Object>> lanes = new ArrayList<>();
        lanes.add(runLane("BM25-only", "关键词精确匹配，擅长专业名词", RetrievalMode.BM25_ONLY, q, topK, expected));
        lanes.add(runLane("向量-only", "BGE-M3 语义相似，擅长口语化提问", RetrievalMode.VECTOR_ONLY, q, topK, expected));
        lanes.add(runLane("RRF-only", "双路召回 + RRF 融合，不重排", RetrievalMode.HYBRID_RRF_ONLY, q, topK, expected));
        lanes.add(runLane("混合+重排", "线上默认：双路 + RRF + 向量重排", RetrievalMode.HYBRID, q, topK, expected));

        out.put("lanes", lanes);
        out.put("expectedIds", new ArrayList<>(expected));
        return out;
    }

    /**
     * 跑一路检索。异常不向上抛——某一路挂了（如 Qdrant 没启动导致向量腿不可用）
     * 其它路仍应正常展示，并明确标出哪一路失败、失败原因。
     */
    private Map<String, Object> runLane(String name, String desc, RetrievalMode mode,
                                        String q, int topK, Set<String> expected) {
        Map<String, Object> lane = new LinkedHashMap<>();
        lane.put("name", name);
        lane.put("desc", desc);
        lane.put("mode", mode.name());

        long t0 = System.currentTimeMillis();
        try {
            List<RetrievedChunk> chunks = retriever.retrieve(q, topK, mode);
            long cost = System.currentTimeMillis() - t0;

            List<Map<String, Object>> items = new ArrayList<>();
            boolean hit = false;
            for (RetrievedChunk c : chunks) {
                Map<String, Object> it = new LinkedHashMap<>();
                it.put("id", c.id());
                it.put("score", Math.round(c.score() * 10000) / 10000.0);
                it.put("preview", abbreviate(c.content(), 90));
                boolean isExpected = expected.contains(c.id());
                it.put("expected", isExpected);
                if (isExpected) hit = true;
                items.add(it);
            }

            lane.put("items", items);
            lane.put("costMs", cost);
            lane.put("hit", expected.isEmpty() ? null : hit);
            lane.put("ok", true);
        } catch (Exception e) {
            lane.put("items", List.of());
            lane.put("costMs", System.currentTimeMillis() - t0);
            lane.put("ok", false);
            lane.put("error", e.getClass().getSimpleName() + ": " + e.getMessage());
            log.warn("检索测试台 {} 失败: {}", name, e.getMessage());
        }
        return lane;
    }

    /**
     * 评测集中可作为示例的问题，供页面一键填入。
     *
     * 优先挑 BM25 失败但向量成功的样本——那正是最能让「为什么要做混合检索」
     * 一目了然的例子。
     */
    @GetMapping("/search-lab/samples")
    public Map<String, Object> samples(@RequestParam(defaultValue = "8") int limit) {
        int safe = Math.min(Math.max(limit, 1), 30);
        // 从 eval_run 里找：bm25_only 未命中、hybrid 命中 的用例
        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT c.id, c.question, c.category, c.expected_chunk_ids "
                        + "FROM eval_case c "
                        + "WHERE EXISTS (SELECT 1 FROM eval_run r WHERE r.case_id=c.id AND r.run_name='bm25_only' AND r.hit_at_5=0) "
                        + "  AND EXISTS (SELECT 1 FROM eval_run r WHERE r.case_id=c.id AND r.run_name='hybrid' AND r.hit_at_5=1) "
                        + "ORDER BY c.id LIMIT " + safe);
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("samples", rows);
        out.put("note", "这些用例的特征是：BM25 漏召但混合检索命中，最适合演示混合检索的价值");
        return out;
    }

    // ==================== 内部工具 ====================

    private Set<String> parseIds(Object raw) {
        Set<String> out = new LinkedHashSet<>();
        if (raw == null) return out;
        for (String s : String.valueOf(raw).split("[,，\\s]+")) {
            if (!s.isBlank()) out.add(s.trim());
        }
        return out;
    }

    private String abbreviate(String s, int max) {
        if (s == null) return "";
        String one = s.replaceAll("\\s+", " ").trim();
        return one.length() <= max ? one : one.substring(0, max) + "…";
    }
}
