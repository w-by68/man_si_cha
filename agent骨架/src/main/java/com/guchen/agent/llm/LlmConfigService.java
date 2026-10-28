package com.guchen.agent.llm;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * LLM 运行时配置（模型 / baseUrl / apiKey），存 Redis 支持后台动态修改。
 *
 * <h3>为什么放 Redis 而不是改 @Value 字段</h3>
 * @Value 是启动时读一次的实例字段，每个 JVM 各有一份。若后台只改「当前这台」的内存，
 * 多实例部署时另一台仍用旧配置——同一时刻不同用户用不同模型，成本核算也对不上。
 * 放 Redis 后所有实例读同一份，天然一致。
 *
 * <h3>5 秒本地缓存</h3>
 * 一次对话可能触发 6 轮 LLM 调用，每轮都查 Redis 浪费。
 * 5 秒窗口：切换后最多 5 秒生效，正常请求几乎无额外开销。
 */
@Slf4j
@Service
public class LlmConfigService {

    private static final String KEY = "agent:config:llm";
    private static final String FIELD_MODEL = "model";
    private static final String FIELD_BASE_URL = "base_url";
    private static final String FIELD_API_KEY = "api_key";
    private static final long CACHE_TTL_MS = 5_000;

    /**
     * 快捷切换预设（仅 model 变化，baseUrl/apiKey 沿用当前值）。
     * 自定义模型不限于此列表——后台可直接填任意 model 字符串。
     */
    private static final List<Map<String, String>> PRESETS = List.of(
            preset("deepseek-v4.1-flash", "DeepSeek V4.1 Flash", "当前默认，快且便宜"),
            preset("deepseek-v4-flash",   "DeepSeek V4 Flash",   "上一代 Flash"),
            preset("deepseek-v4-pro",     "DeepSeek V4 Pro",     "更强推理，更贵更慢"),
            preset("glm-5.3-flash",       "GLM 5.3 Flash",       "智谱轻量版"),
            preset("glm-5.3",             "GLM 5.3",             "智谱旗舰"),
            preset("glm-5.2",             "GLM 5.2",             "智谱上一代"),
            preset("minimax-m3",          "MiniMax M3",          "长上下文")
    );

    private static Map<String, String> preset(String id, String name, String desc) {
        Map<String, String> m = new LinkedHashMap<>();
        m.put("id", id);
        m.put("name", name);
        m.put("desc", desc);
        return m;
    }

    private final StringRedisTemplate redis;
    private final String defaultModel;
    private final String defaultBaseUrl;

    /** 本地缓存（一次性读 Redis 全字段，避免 model/baseUrl/apiKey 各查一次） */
    private volatile Map<String, String> cachedConfig;
    private volatile long cachedAt = 0;

    public LlmConfigService(StringRedisTemplate redis,
                            @Value("${llm.chat-model}") String defaultModel,
                            @Value("${llm.base-url}") String defaultBaseUrl) {
        this.redis = redis;
        this.defaultModel = defaultModel;
        this.defaultBaseUrl = defaultBaseUrl;
    }

    /** 当前模型。Redis 覆盖值优先，否则配置文件默认。 */
    public String currentModel() {
        return config().get("model");
    }

    /** 当前 baseUrl（Redis 覆盖值或配置文件默认，已归一化去掉末尾 /v1）。 */
    public String currentBaseUrl() {
        String url = config().get("baseUrl");
        if (url == null || url.isBlank()) url = defaultBaseUrl;
        // 归一化
        while (url.endsWith("/")) url = url.substring(0, url.length() - 1);
        if (url.endsWith("/v1")) url = url.substring(0, url.length() - 3);
        return url;
    }

    /** 当前 apiKey（Redis 覆盖值或 null，null 时 LlmClient 用配置文件的 key）。 */
    public String currentApiKey() {
        return config().get("apiKey");
    }

    /** 当前完整配置快照（本地缓存 5 秒）。 */
    public Map<String, String> config() {
        long now = System.currentTimeMillis();
        Map<String, String> cached = cachedConfig;
        if (cached != null && now - cachedAt < CACHE_TTL_MS) return cached;

        Map<String, String> cfg = new LinkedHashMap<>();
        cfg.put("model", defaultModel);
        cfg.put("baseUrl", defaultBaseUrl);
        cfg.put("apiKey", "");
        try {
            Map<Object, Object> raw = redis.opsForHash().entries(KEY);
            String m = (String) raw.get(FIELD_MODEL);
            if (m != null && !m.isBlank()) cfg.put("model", m);
            String b = (String) raw.get(FIELD_BASE_URL);
            if (b != null && !b.isBlank()) cfg.put("baseUrl", b);
            String k = (String) raw.get(FIELD_API_KEY);
            if (k != null && !k.isBlank()) cfg.put("apiKey", k);
        } catch (Exception e) {
            log.debug("读取 Redis LLM 配置失败，使用配置文件默认值: {}", e.getMessage());
        }
        cachedConfig = cfg;
        cachedAt = now;
        return cfg;
    }

    /**
     * 更新配置。三个字段独立，传 null 或空表示「沿用当前值」。
     *
     * @param model   模型字符串（不限制在预设列表，支持任意网关的任意模型）
     * @param baseUrl API 地址（传 null/空 = 沿用当前）
     * @param apiKey  API 密钥（传 null/空 = 沿用当前）
     */
    public Map<String, Object> updateConfig(String model, String baseUrl, String apiKey) {
        if (model == null || model.isBlank()) {
            return Map.of("ok", false, "error", "模型名不能为空");
        }
        Map<String, String> before = config();
        try {
            redis.opsForHash().put(KEY, FIELD_MODEL, model.trim());
            if (baseUrl != null && !baseUrl.isBlank()) {
                redis.opsForHash().put(KEY, FIELD_BASE_URL, baseUrl.trim());
            }
            if (apiKey != null && !apiKey.isBlank()) {
                redis.opsForHash().put(KEY, FIELD_API_KEY, apiKey.trim());
            }
            redis.opsForHash().put(KEY, "updated_at", String.valueOf(System.currentTimeMillis()));
        } catch (Exception e) {
            log.error("写入 Redis LLM 配置失败", e);
            return Map.of("ok", false, "error", "写入配置失败: " + e.getMessage());
        }
        // 立即失效本地缓存
        cachedConfig = null;
        cachedAt = 0;
        log.info("LLM 配置更新: model {} -> {} baseUrl={}", before.get("model"), model, baseUrl);

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("ok", true);
        out.put("from", before.get("model"));
        out.put("to", model.trim());
        out.put("effectiveWithin", CACHE_TTL_MS / 1000 + " 秒");
        return out;
    }

    public void logout(String token) {
        // 保留接口签名兼容（此处不做令牌管理）
    }

    /** 预设列表。 */
    public List<Map<String, String>> presets() {
        return PRESETS;
    }

    /** 缓存 TTL。 */
    public long cacheTtl() {
        return CACHE_TTL_MS;
    }

    /** 默认模型。 */
    public String defaultModel() {
        return defaultModel;
    }

    /** 默认 baseUrl。 */
    public String defaultBaseUrl() {
        return defaultBaseUrl;
    }
}
