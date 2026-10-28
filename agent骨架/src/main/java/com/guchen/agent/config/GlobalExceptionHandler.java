package com.guchen.agent.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 全局异常处理（2026-10-23 新增）。
 *
 * <h3>为什么需要它</h3>
 * 项目里所有接口都返回统一的 {@code {ok:false, error:"..."}} 契约，
 * 但**没有**任何 {@code @ControllerAdvice}。结果是：参数缺失/类型错误这类
 * 客户端问题会一路冒泡成 Spring 默认的 500 错误页，返回
 * {@code {"timestamp":...,"status":500,"error":"Internal Server Error","path":"..."}}。
 *
 * 实测案例：{@code POST /api/admin/order-status} 少传 id，
 * {@code Long.parseLong(String.valueOf(null))} 抛 NumberFormatException → 500，
 * 前端完全无法区分「参数写错了」和「服务挂了」，排查成本极高。
 *
 * <p>现在统一收口为 400/500 两种语义，且**不回显**堆栈与路径信息。</p>
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    /** 少传 query 参数（如 ?id= 缺失）。 */
    @ExceptionHandler(MissingServletRequestParameterException.class)
    public ResponseEntity<Map<String, Object>> onMissingParam(MissingServletRequestParameterException e) {
        return bad("缺少必填参数：" + e.getParameterName());
    }

    /** 参数类型不对（如 ?id=abc 传给 long）。 */
    @ExceptionHandler(MethodArgumentTypeMismatchException.class)
    public ResponseEntity<Map<String, Object>> onTypeMismatch(MethodArgumentTypeMismatchException e) {
        return bad("参数类型不正确：" + e.getName());
    }

    /** 请求体不是合法 JSON / 字段类型不符。 */
    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<Map<String, Object>> onUnreadable(HttpMessageNotReadableException e) {
        return bad("请求体格式不正确，请检查 JSON 与字段类型");
    }

    /** 业务代码里显式的参数校验失败（Long.parseLong("null") 等）。 */
    @ExceptionHandler({NumberFormatException.class, IllegalArgumentException.class})
    public ResponseEntity<Map<String, Object>> onBadArgument(RuntimeException e) {
        log.warn("参数解析失败: {}", e.getMessage());
        return bad("参数不合法，请检查请求内容");
    }

    /**
     * 外键约束阻止了本次操作（如删除一条仍被引用的券）。
     *
     * <p>预检与实际 DELETE 之间存在并发窗口：预检时没有引用，
     * 真正删的时候刚被领取 → {@code ON DELETE RESTRICT} 抛
     * {@link DataIntegrityViolationException}。若不单独处理，会被下面的
     * {@code onAny} 兜成 500「服务内部错误」，运营看到的就是「删了没反应 / 服务挂了」，
     * 完全不知道是被引用挡住。</p>
     *
     * <p>返回 409 让前端能把「被引用」与「服务故障」区分开；
     * 只记 warn 且不打印整棵堆栈 —— 这是可预期的业务冲突，不是 bug。</p>
     */
    @ExceptionHandler(DataIntegrityViolationException.class)
    public ResponseEntity<Map<String, Object>> onDataIntegrity(DataIntegrityViolationException e) {
        String cause = e.getMostSpecificCause() == null ? "" : e.getMostSpecificCause().getMessage();
        log.warn("外键约束拦截了本次操作: {}", cause);

        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", false);
        body.put("code", "FK_CONSTRAINT");
        body.put("error", "该记录仍被其他数据引用，无法删除");
        return ResponseEntity.status(HttpStatus.CONFLICT).body(body);
    }

    /**
     * 静态资源 404（favicon.ico、微信开发者工具的探测路径等）。
     *
     * 【2026-10-23 修复自身回归】兜底的 Exception 处理器会把
     * {@code NoResourceFoundException} 也一并接住，于是每请求一次 favicon.ico
     * 就打一整屏 ERROR 堆栈（实测日志被 `No static resource favicon.ico` 刷满，
     * 比原来的 MQ 重连噪音还严重），并且把本该是 404 的响应变成 500。
     * 这里单独接住，按 404 返回、只记 debug。
     */
    @ExceptionHandler(org.springframework.web.servlet.resource.NoResourceFoundException.class)
    public ResponseEntity<Map<String, Object>> onNoResource(
            org.springframework.web.servlet.resource.NoResourceFoundException e) {
        log.debug("资源不存在: {}", e.getResourcePath());
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", false);
        body.put("error", "接口或资源不存在");
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(body);
    }

    /** 兜底：不把内部堆栈与路径暴露给调用方。 */
    @ExceptionHandler(Exception.class)
    public ResponseEntity<Map<String, Object>> onAny(Exception e) {
        // 只打一行摘要，不打完整堆栈：否则任何一次客户端异常都会在日志里刷几十行，
        // 把真正需要关注的错误淹没掉。需要栈时按 traceId 单独排查。
        log.error("未捕获异常: {}", e.toString());
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", false);
        body.put("error", "服务内部错误，请稍后重试");
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body);
    }

    private ResponseEntity<Map<String, Object>> bad(String message) {
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", false);
        body.put("error", message);
        return ResponseEntity.badRequest().body(body);
    }
}
