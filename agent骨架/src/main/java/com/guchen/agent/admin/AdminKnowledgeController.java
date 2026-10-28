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
 * 知识块 CRUD 与工具调用审计。
 *
 * 知识块编辑的核心约束：**改内容不等于改索引**。
 *   kb_chunk 是「真相源」，Qdrant 是「派生索引」。
 *   改了 kb_chunk 而不重建索引，检索结果仍是旧内容——这种「改了没生效」的错觉
 *   是最容易浪费排查时间的坑。所以每个写操作都返回 needsRebuild 标记，
 *   前端据此持续提示用户「内容已改，请重建索引」。
 *
 * 删除策略：物理删除 kb_chunk 行，但**不删除 Qdrant 里的点**。
 *   因为 Qdrant 点 id 是由 chunk id 派生的确定性 UUID，
 *   重建索引时只 upsert 存在的块，被删块的点会残留但不再被 MySQL 侧关联。
 *   彻底清理需要 Qdrant 支持按 payload 过滤删除，当前实现没做——
 *   这是已知限制，写在这里而不是假装不存在。
 */
@Slf4j
@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminKnowledgeController {

    private final JdbcTemplate jdbc;

    /**
     * content 列是 MySQL TEXT，上限 65535 **字节**（不是字符）。
     * UTF-8 下一个汉字占 3 字节，所以中文实际只能放约 21800 字。
     * 超限时 MySQL 抛 DataTruncation → 未处理会变成 500，
     * 使用者只看到「Internal Server Error」，完全不知道是内容太长。
     * 所以入库前自己校验字节数，给出明确提示。
     */
    private static final int CONTENT_MAX_BYTES = 65535;

    // ==================== 知识块 ====================

    /**
     * 知识块列表。支持按文档过滤、按内容搜索。
     *
     * 不返回全部内容（长文本会很重），只给前 200 字符摘要，
     * 点开某一行再单独取全文。
     */
    @GetMapping("/chunks")
    public Map<String, Object> chunks(
            @RequestParam(required = false) Long documentId,
            @RequestParam(required = false) String keyword,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        StringBuilder where = new StringBuilder(" WHERE 1=1 ");
        List<Object> args = new ArrayList<>();
        if (documentId != null) {
            where.append(" AND c.document_id = ? ");
            args.add(documentId);
        }
        if (keyword != null && !keyword.isBlank()) {
            where.append(" AND c.content LIKE ? ");
            args.add("%" + keyword.trim() + "%");
        }

        Integer total = jdbc.queryForObject(
                "SELECT COUNT(*) FROM kb_chunk c" + where, Integer.class, args.toArray());

        int safeSize = Math.min(Math.max(size, 1), 100);
        int safePage = Math.max(page, 1);
        int offset = (safePage - 1) * safeSize;

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT c.id, c.document_id, c.chunk_index, c.token_count, c.vector_id, "
                        + "c.created_at, d.title AS doc_title, "
                        + "CHAR_LENGTH(c.content) AS len, "
                        + "LEFT(c.content, 200) AS preview "
                        + "FROM kb_chunk c LEFT JOIN kb_document d ON d.id = c.document_id"
                        + where + " ORDER BY c.document_id, c.chunk_index, c.id "
                        + "LIMIT " + safeSize + " OFFSET " + offset,
                args.toArray());

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("total", total == null ? 0 : total);
        out.put("page", safePage);
        out.put("size", safeSize);
        out.put("rows", rows);
        return out;
    }

    /** 单块全文。 */
    @GetMapping("/chunk")
    public Map<String, Object> chunk(@RequestParam long id) {
        try {
            return jdbc.queryForMap(
                    "SELECT c.*, d.title AS doc_title FROM kb_chunk c "
                            + "LEFT JOIN kb_document d ON d.id = c.document_id WHERE c.id = ?", id);
        } catch (Exception e) {
            return Map.of("error", "知识块不存在: " + id);
        }
    }

    /**
     * 新增知识块。
     *
     * chunk_index 自动取该文档下最大值 +1，避免人工输入错位。
     * token_count 按粗略估算写入（1 汉字 ≈ 1 token），仅用于统计展示，
     * 真实 token 数以 LLM 返回为准，这里不追求精确。
     */
    @PostMapping("/chunk-create")
    public Map<String, Object> createChunk(@RequestBody Map<String, Object> body) {
        long docId = Long.parseLong(String.valueOf(body.get("documentId")));
        String content = String.valueOf(body.getOrDefault("content", "")).trim();
        if (content.isEmpty()) return Map.of("ok", false, "error", "内容不能为空");
        String tooLong = checkContentSize(content);
        if (tooLong != null) return Map.of("ok", false, "error", tooLong);

        // 文档必须存在，否则外键约束会报错（错误信息对使用者不友好，先自己校验）
        Integer docExists = jdbc.queryForObject(
                "SELECT COUNT(*) FROM kb_document WHERE id = ?", Integer.class, docId);
        if (docExists == null || docExists == 0) {
            return Map.of("ok", false, "error", "文档不存在: " + docId);
        }

        Integer maxIdx = jdbc.queryForObject(
                "SELECT COALESCE(MAX(chunk_index), 0) FROM kb_chunk WHERE document_id = ?",
                Integer.class, docId);

        jdbc.update("INSERT INTO kb_chunk (document_id, content, chunk_index, token_count, created_at) "
                        + "VALUES (?, ?, ?, ?, NOW())",
                docId, content, maxIdx == null ? 1 : maxIdx + 1, content.length());

        Long newId = jdbc.queryForObject("SELECT LAST_INSERT_ID()", Long.class);
        syncDocChunkCount(docId);
        log.info("后台新增知识块: doc={} id={} len={}", docId, newId, content.length());

        return Map.of("ok", true, "id", newId,
                "needsRebuild", true,
                "note", "已写入 kb_chunk，重建索引后才会被检索到");
    }

    /** 修改知识块内容。 */
    @PostMapping("/chunk-update")
    public Map<String, Object> updateChunk(@RequestBody Map<String, Object> body) {
        long id = Long.parseLong(String.valueOf(body.get("id")));
        String content = String.valueOf(body.getOrDefault("content", "")).trim();
        if (content.isEmpty()) return Map.of("ok", false, "error", "内容不能为空");
        String tooLong = checkContentSize(content);
        if (tooLong != null) return Map.of("ok", false, "error", tooLong);

        List<Map<String, Object>> before = jdbc.queryForList(
                "SELECT document_id, CHAR_LENGTH(content) AS len FROM kb_chunk WHERE id = ?", id);
        if (before.isEmpty()) return Map.of("ok", false, "error", "知识块不存在: " + id);

        jdbc.update("UPDATE kb_chunk SET content = ?, token_count = ? WHERE id = ?",
                content, content.length(), id);
        log.info("后台修改知识块: id={} 原长度={} 新长度={}", id, before.get(0).get("len"), content.length());

        return Map.of("ok", true, "needsRebuild", true,
                "note", "内容已更新，重建索引后检索结果才会变化");
    }

    /** 删除知识块。 */
    @PostMapping("/chunk-delete")
    public Map<String, Object> deleteChunk(@RequestBody Map<String, Object> body) {
        long id = Long.parseLong(String.valueOf(body.get("id")));

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT document_id, LEFT(content, 50) AS preview FROM kb_chunk WHERE id = ?", id);
        if (rows.isEmpty()) return Map.of("ok", false, "error", "知识块不存在: " + id);

        Long docId = ((Number) rows.get(0).get("document_id")).longValue();
        int n = jdbc.update("DELETE FROM kb_chunk WHERE id = ?", id);
        syncDocChunkCount(docId);
        log.info("后台删除知识块: id={} 预览={}", id, rows.get(0).get("preview"));

        return Map.of("ok", true, "deleted", n, "needsRebuild", true,
                "note", "kb_chunk 已删除；Qdrant 中的旧向量点会残留在库中，"
                        + "重建索引不会恢复它（因为源已不存在），但不影响检索正确性");
    }

    // ==================== 工具调用审计 ====================

    /**
     * 工具调用流水。
     *
     * 写操作识别：idempotent_key 非空即为写操作（幂等键只对写操作生成）。
     * 这是「Agent 重试导致重复下单」防线的直接证据——前端可以展示
     * 「有 N 次写操作生成了幂等键」，说明防护实际生效过。
     */
    @GetMapping("/tool-calls")
    public Map<String, Object> toolCalls(
            @RequestParam(required = false) String toolName,
            @RequestParam(required = false) Boolean onlyFailed,
            @RequestParam(required = false) Boolean onlyWrite,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        StringBuilder where = new StringBuilder(" WHERE 1=1 ");
        List<Object> args = new ArrayList<>();

        if (toolName != null && !toolName.isBlank()) {
            where.append(" AND tool_name = ? ");
            args.add(toolName.trim());
        }
        if (Boolean.TRUE.equals(onlyFailed)) {
            where.append(" AND response_code IS NOT NULL AND response_code <> 200 ");
        }
        if (Boolean.TRUE.equals(onlyWrite)) {
            where.append(" AND idempotent_key IS NOT NULL ");
        }

        Integer total = jdbc.queryForObject(
                "SELECT COUNT(*) FROM agent_tool_call" + where, Integer.class, args.toArray());

        int safeSize = Math.min(Math.max(size, 1), 100);
        int safePage = Math.max(page, 1);
        int offset = (safePage - 1) * safeSize;

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT id, trace_id, tool_name, response_code, latency_ms, "
                        + "idempotent_key, created_at FROM agent_tool_call"
                        + where + " ORDER BY id DESC LIMIT " + safeSize + " OFFSET " + offset,
                args.toArray());

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("total", total == null ? 0 : total);
        out.put("page", safePage);
        out.put("size", safeSize);
        out.put("rows", rows);
        out.put("stats", toolStats());
        return out;
    }

    /**
     * 按工具汇总：调用次数、成功率、平均耗时。失败率高的工具是排查重点。
     *
     * ⚠️ 成功率必须区分「没有数据」与「全部失败」：
     * 历史记录（v1.2 之前）从不写 response_code，若直接用
     * SUM(code=200)/COUNT(*)，会算成 0% —— 看上去像「所有工具全挂了」，
     * 实际上只是没记录。所以这里用 NULLIF 让无数据时返回 NULL，
     * 前端据此显示「—」而不是误报为异常。
     */
    private List<Map<String, Object>> toolStats() {
        return jdbc.queryForList(
                "SELECT tool_name, COUNT(*) AS calls, "
                        + "SUM(CASE WHEN response_code = 200 THEN 1 ELSE 0 END) AS success, "
                        + "COUNT(response_code) AS recorded, "
                        + "ROUND(SUM(CASE WHEN response_code = 200 THEN 1 ELSE 0 END) * 100.0 "
                        + "      / NULLIF(COUNT(response_code), 0), 2) AS success_pct, "
                        + "ROUND(AVG(latency_ms)) AS avg_ms, "
                        + "MAX(CASE WHEN idempotent_key IS NOT NULL THEN 1 ELSE 0 END) AS has_write "
                        + "FROM agent_tool_call GROUP BY tool_name ORDER BY calls DESC");
    }

    // ==================== 内部工具 ====================

    /**
     * 校验内容字节数。返回 null 表示通过，否则返回给用户看的错误信息。
     *
     * 提示里同时给字节和字符两个口径：字节是真实限制，字符是使用者的直觉单位。
     * 中文（3 字节/字）和英文（1 字节/字符）差异很大，只给其中一个都容易误导。
     */
    private String checkContentSize(String content) {
        int bytes = content.getBytes(java.nio.charset.StandardCharsets.UTF_8).length;
        if (bytes <= CONTENT_MAX_BYTES) return null;
        return String.format(
                "内容过长：当前 %d 字节（约 %d 字），上限 %d 字节（中文约 %d 字）。"
                        + "请拆分为多个知识块。",
                bytes, content.length(), CONTENT_MAX_BYTES, CONTENT_MAX_BYTES / 3);
    }

    /**
     * 回填文档的块数字段。
     *
     * 为什么不写数据库触发器：老项目/本项目的既有做法都是应用层维护，
     * 加触发器会让「块数」与「实际块数」出现两份真相。这里每次增删后同步一次，
     * 逻辑简单且可见（改了就能在列表上看到）。
     */
    private void syncDocChunkCount(long docId) {
        try {
            jdbc.update("UPDATE kb_document d SET d.chunk_count = "
                    + "(SELECT COUNT(*) FROM kb_chunk c WHERE c.document_id = d.id) WHERE d.id = ?", docId);
        } catch (Exception e) {
            log.warn("回填 chunk_count 失败 docId={}: {}", docId, e.getMessage());
        }
    }
}
