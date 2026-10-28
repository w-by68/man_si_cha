// main.js 或 api/index.js
import request from '../axios/axios-interceptor';

// 使用示例
export const login = (data) => {
  return request({
    url: '/user/login',
    method: 'post',
    data
  });
};

export const register = (data) => {
  return request({
    url: '/user/regist',
    method: 'post',
    data
  });
};

export const theme = () => {
  return request({
    url: '/theme/lists',
    method: 'get',
  });
};

// 获取茶叶类型
export const categoryLists = () => {
  return request({
    url: '/category/lists',
    method: 'get',
  });
};

// 获取全部茶叶
export const productThemeLists = () => {
  return request({
    url: '/theme/themeProductList',
    method: 'get',
  });
};

export const codeNo = (data) => {
  return request({
    url: '/coupon/codeNo',
    method: 'post',
    data
  });
};

// 获取优惠券
export const selectCUListId = () => {
  return request({
    url: '/coupon/selectCUListId',
    method: 'get'
  });
};

// 获取用户优惠券列表
export const selectCouponUserVOList = () => {
  return request({
    url: '/coupon/selectCouponUserVOList',
    method: 'get'
  });
};

// 获取单个商品数据（商品详情页面）
export const selectSingle = (data) => {
  return request({
    url: '/product/selectSingle',
    method: 'post',
    data
  });
};

//获取同主题所有商品
export const ThemeSingle = (data) => {
  return request({
    url: '/product/ThemeSingle',
    method: 'post',
    data
  });
};

//获取店铺详细信息
export const SingleOne = (data) => {
  return request({
    url: '/shop/SingleOne',
    method: 'post',
    data
  });
};

//获取店铺下的所有商品
export const shopProductList = (data) => {
  return request({
    url: '/shop/productList',
    method: 'post',
    data
  });
};

// 获取用户购物车商品数据
export const selectVCartDetail = () => {
  return request({
    url: '/cart/VCartDetail',
    method: 'get'
  });
};

// 获取product表中商品数据
export const shopSpecList = () => {
  return request({
    url: '/product/shopSpecList',
    method: 'get'
  });
};

// 删除购物车中的商品
export const delCartItem = (data) => {
  return request({
    url: '/cart/delCartItem',
    method: 'delete',
	data
  });
};

// 删除购物车全部的商品
export const delAllCartItem = () => {
  return request({
    url: '/cart/delAllCartItem',
    method: 'delete'
  });
};

// 更新购物车中的商品
export const insertCartItem = (data) => {
  return request({
    url: '/cart/insertCartItem',
    method: 'post',
	data
  });
};

// 获取当前用户基本数据
export const userDatas = () => {
  return request({
    url: '/user/userData',
    method: 'get'
  });
};

// 修改当前用户基本数据
export const userDataUpdate = (data) => {
  return request({
    url: '/user/userDataUpdate',
    method: 'post',
	data
  });
};

// 获取收藏茶具数据
export const productTeaware = () => {
  return request({
    url: '/product/teaware',
    method: 'get'
  });
};

// 获取用户余额
export const userBalanceI = () => {
  return request({
    url: '/user/balanceI',
    method: 'get'
  });
};

// 获取用户地址
export const userAddressList = () => {
  return request({
    url: '/user/addressI',
    method: 'get'
  });
};

// 修改用户地址
export const userAddressUpdateInsert = (data) => {
  return request({
    url: '/user/addressUpdateInsert',
    method: 'post',
	data
  });
};

// 修改用户默认地址
export const userAddressUpdateIsDefault = (data) => {
  return request({
    url: '/user/addressUpdateIsDefault',
    method: 'post',
	data
  });
};

// 删除用户地址
export const userAddressDelete = (data) => {
  return request({
    url: '/user/addressDelete',
    method: 'delete',
	data
  });
};

// 获取品茶笔记数据
export const userNoteList = () => {
  return request({
    url: '/user/noteI',
    method: 'get'
  });
};

// 修改用户地址
export const noteUpdateInsert = (data) => {
  return request({
    url: '/user/noteUpdateInsert',
    method: 'post',
	data
  });
};

// 删除用户地址
export const noteDelete = (data) => {
  return request({
    url: '/user/noteDelete',
    method: 'delete',
	data
  });
};

// 获取用户购买的茶叶
export const userProductCategory = () => {
  return request({
    url: '/user/productCategory',
    method: 'get'
  });
};

// 获取朋友圈数据
export const vMomentList = () => {
  return request({
    url: '/moment/list',
    method: 'get'
  });
};

// 获取对应朋友圈的评论
export const vMomentCommentList = (data) => {
  return request({
    url: '/moment/commentList',
    method: 'post',
	data
  });
};

// 当前朋友圈用户是否点赞
export const vMomentLikeFlag = (data) => {
  return request({
    url: '/moment/likeFlag',
    method: 'post',
	data
  });
};

// 获取动态emoji表情接口
export const vMomentImageFlag = (data) => {
  return request({
    url: '/moment/imageList',
    method: 'post',
	data
  });
};

// 修改点赞数据表
export const vMomentUpdateLike = (data) => {
  return request({
    url: '/moment/updateLike',
    method: 'post',
	data
  });
};

// 添加评论
export const vMomentInsertComment = (data) => {
  return request({
    url: '/moment/insertComment',
    method: 'post',
	data
  });
};

// 添加动态
export const vMomentInsertMoment = (data) => {
  return request({
    url: '/moment/insertMoment',
    method: 'post',
	data
  });
};

// 添加动态图片
export const vMomentInsertImage = (data) => {
  return request({
    url: '/moment/insertImage',
    method: 'post',
	data
  });
};

// 获取用户订单
export const VOrderData = () => {
  return request({
    url: '/order/VOrderData',
    method: 'get'
  });
};

// 获取用户订单详细
export const VOrderItemDetail = () => {
  return request({
    url: '/order/VOrderItemDetail',
    method: 'get'
  });
};

// 获取用户拥有的优惠券
export const VUserCouponService = () => {
  return request({
    url: '/coupon/vUserCouponService',
    method: 'get'
  });
};

// 添加订单
export const insertOrderData = (data) => {
  return request({
    url: '/order/OrderData',
    method: 'post',
	data
  });
};

// 添加订单详情
export const insertOrderItemData = (data) => {
  return request({
    url: '/order/OrderItemData',
    method: 'post',
	data
  });
};

/**
 * 取消订单（真正落库）。
 *
 * 为什么需要：原先前端「取消订单」只把本地数组里那条 splice 掉（纯 UI 假动作），
 * 数据库状态没变，用户下次进页面又看到同一笔未付款订单。
 * 后端 order/CancelOrder 会校验「本人 + 未发货」并置 status=cancelled。
 */
export const cancelOrder = (orderId, reason) => {
  return request({
    url: '/order/CancelOrder',
    method: 'post',
    data: { orderId, reason }
  });
};

// 获取验证码
export const userCaptcha = () => {
  return request({
    url: '/user/captcha',
    method: 'get',
  });
};

// 提交验证码后端判断
export const userYzmcap = (data) => {
  return request({
    url: '/user/yzmcap',
    method: 'post',
	data
  });
};

// ============================================================
// Agent 智能茶饮顾问（独立服务 agent-service:8081，不走本 axios 实例）
// 说明：本文件其余接口统一走 axios 实例（baseURL=127.0.0.1:8080，自动带 token）。
//       Agent 服务是另一个微服务，地址与鉴权头都不同，因此单独封装。
// ============================================================

/** Agent 服务基地址（部署时改这里，或注入环境变量） */
export const AGENT_BASE_URL = 'http://127.0.0.1:8081';

/**
 * 组装 Agent 请求头。
 * <p>关键：把商城登录拿到的 token 透传给 agent-service，
 * agent-service 再经 Feign 透传给老项目 tearSpring 做鉴权 ——
 * 否则 Agent 的工具调用会被老项目 401 拦截，只能回答通用茶知识、
 * 查不到真实商品数据（这是双端接入必须打通的链路）。
 */
const agentHeaders = () => {
  const h = { 'Content-Type': 'application/json; charset=utf-8' };
  try {
    const token = uni.getStorageSync('token');
    if (token) h.token = token;
  } catch (e) { /* 未登录则不带 token */ }
  return h;
};

/**
 * 非流式问答（降级路径 / 压测）
 * @param {{message:string, sessionId:string}} data
 */
export const agentChat = (data) => {
  return new Promise((resolve, reject) => {
    uni.request({
      url: AGENT_BASE_URL + '/api/agent/chat',
      method: 'POST',
      header: agentHeaders(),
      data,
      success: (res) => (res.statusCode === 200 ? resolve(res.data) : reject(res.data)),
      fail: reject
    });
  });
};

/**
 * 解析一段 SSE 缓冲，返回未消费的剩余部分。
 * @param {string} buf       累计缓冲
 * @param {(evt:{event:string,data:object})=>void} onEvent 事件回调
 * @param {()=>void} onDone 收到 done/error 时回调
 * @returns {string} 剩余未成块的缓冲
 */
const drainSse = (buf, onEvent, onDone) => {
  let pos;
  while ((pos = buf.indexOf('\n\n')) >= 0) {
    const block = buf.slice(0, pos);
    buf = buf.slice(pos + 2);
    let event = 'message', payload = '';
    for (const line of block.split('\n')) {
      if (line.startsWith('event:')) event = line.slice(6).trim();
      else if (line.startsWith('data:')) payload += line.slice(5).trim();
    }
    if (!payload) continue;
    try { onEvent({ event, data: JSON.parse(payload) }); }
    catch (e) { /* 半截 JSON，忽略 */ }
    if (event === 'done' || event === 'error') onDone();
  }
  return buf;
};

/**
 * 流式问答（SSE）。
 *
 * 双端实现差异（重要）：
 *   - 小程序：`uni.request` 的 `enableChunked` 分块接收（微信基础库 2.20.2+）；
 *   - H5：`uni.request` 不支持 enableChunked，改用浏览器原生 fetch + ReadableStream，
 *     否则会静默走降级路径、丢掉打字机效果（这正是 H5 端曾显示「· 降级」的原因）。
 *   两端共用 drainSse 解析，行为一致。
 *
 * @param {{message:string, sessionId:string}} data
 * @param {(evt:{event:string, data:object})=>void} onEvent 逐事件回调
 * @returns {Promise<{finished:boolean}>} finished=false 表示未收到任何流式数据，调用方应降级
 */
export const agentChatStream = (data, onEvent) => {
  let gotAny = false;
  let settled = false;
  let done = false;
  let resolveFn = null;
  const finish = (v) => { if (!settled) { settled = true; resolveFn && resolveFn(v); } };

  const promise = new Promise((resolve) => { resolveFn = resolve; });

  // ---------- H5：原生 fetch + ReadableStream ----------
  // #ifdef H5
  (async () => {
    try {
      const resp = await fetch(AGENT_BASE_URL + '/api/agent/chat/stream', {
        method: 'POST',
        headers: agentHeaders(),
        body: JSON.stringify(data)
      });
      if (!resp.ok || !resp.body) { finish({ finished: false }); return; }

      const reader = resp.body.getReader();
      const decoder = new TextDecoder('utf-8');
      let buf = '';
      for (;;) {
        const { value, done: streamDone } = await reader.read();
        if (streamDone) break;
        buf += decoder.decode(value, { stream: true });
        gotAny = true;
        buf = drainSse(buf, onEvent, () => { done = true; });
        if (done) break;
      }
      finish({ finished: gotAny });
    } catch (e) {
      console.warn('H5 SSE 流式失败，将降级为非流式', e);
      finish({ finished: false });
    }
  })();
  // #endif

  // ---------- 小程序：uni.request enableChunked ----------
  // #ifndef H5
  {
    let buf = '';
    const task = uni.request({
      url: AGENT_BASE_URL + '/api/agent/chat/stream',
      method: 'POST',
      header: agentHeaders(),
      data,
      enableChunked: true,
      responseType: 'text',
      success: () => finish({ finished: gotAny }),
      fail: () => finish({ finished: false })
    });

    if (!task || !task.onChunkReceived) {
      finish({ finished: false });
    } else {
      task.onChunkReceived((res) => {
        try {
          const chunk = typeof res.data === 'string'
            ? res.data
            : new TextDecoder('utf-8').decode(new Uint8Array(res.data));
          buf += chunk;
          gotAny = true;
          buf = drainSse(buf, onEvent, () => { done = true; });
        } catch (e) {
          console.error('SSE 分块解析失败', e);
        }
      });
    }
  }
  // #endif

  return promise;
};

/**
 * 提交商品评价。
 *
 * 走 agent-service（8081）而不是老项目（8080）：老项目没有评价接口，
 * 评价表 product_review 是后台侧新建的。
 *
 * ⚠️ 不传 userId —— 后端从 token 解析。若由前端传，任何人都能伪造他人身份
 * 给别人的订单打评价。
 *
 * @param {number} orderItemId 订单项 ID（订单里每个商品一行）
 * @param {number} rating 1-5 星
 * @param {string} content 评价内容
 */
export const submitReview = (orderItemId, rating, content) => {
  return new Promise((resolve) => {
    uni.request({
      url: AGENT_BASE_URL + '/api/admin/review/submit',
      method: 'POST',
      header: agentHeaders(),
      data: { orderItemId, rating, content },
      success: (res) => resolve(res.data || {}),
      fail: () => resolve({ ok: false, error: '网络异常，请稍后重试' })
    });
  });
};

/**
 * 领券中心：列出当前可领取的优惠券。
 *
 * 只返回「启用中 + 有库存 + 在有效期内」的券。
 * 库里 27 张种子券都是 2024 年到期的，若后端不过滤，用户会看到一屏领不了的券。
 */
export const availableCoupons = () => {
  return new Promise((resolve) => {
    uni.request({
      url: AGENT_BASE_URL + '/api/admin/public/coupons',
      method: 'GET',
      header: agentHeaders(),
      success: (res) => resolve(res.data || { rows: [] }),
      fail: () => resolve({ rows: [] })
    });
  });
};

/**
 * 凭兑换码领取优惠券（只需兑换码，无需密码）。
 *
 * 走 agent-service 而非老项目 /coupon/codeNo，原因有三：
 *   ① 老项目强制校验 code + password，本需求只要券码
 *   ② 老项目兑换不扣 coupon.stock，运营看到的剩余量永远不变
 *   ③ 老项目逻辑写死，改它违反「tearSpring 零改动」的架构决策
 * agent-service 侧自建完整流程：券码校验 → 查重 → 原子扣库存 → 写券包（失败全回滚）。
 */
export const redeemCoupon = (code) => {
  return new Promise((resolve) => {
    uni.request({
      url: AGENT_BASE_URL + '/api/admin/public/coupon-redeem',
      method: 'POST',
      header: agentHeaders(),
      data: { code },
      success: (res) => resolve(res.data || {}),
      fail: () => resolve({ ok: false, error: '网络异常，请稍后重试' })
    });
  });
};

/**
 * 购物车校验：逐项检查商品是否仍在售、库存是否足够。
 *
 * 场景：用户加购后运营下架商品，老项目结算/下单不校验商品状态，
 * 会「成功」产出一笔发货时发现商品不在售的订单。
 * 在购物车页和结算页调这个接口，下架商品标红并禁止结算。
 */
export const cartCheck = () => {
  return new Promise((resolve) => {
    uni.request({
      url: AGENT_BASE_URL + '/api/admin/public/cart-check',
      method: 'GET',
      header: agentHeaders(),
      success: (res) => resolve(res.data || {}),
      fail: () => resolve({ items: [], allValid: true })
    });
  });
};

/** 模拟支付：待付款 → 待发货。写 payment 表留痕，跳过支付网关。 */
export const payOrder = (orderId, paymentMethod) => {
  return new Promise((resolve) => {
    uni.request({
      url: AGENT_BASE_URL + '/api/admin/public/order-pay',
      method: 'POST',
      header: agentHeaders(),
      data: { orderId, paymentMethod },
      success: (res) => resolve(res.data || {}),
      fail: () => resolve({ ok: false, error: '网络异常，请稍后重试' })
    });
  });
};

/**
 * 获取客服配置（后台「客服」页可编辑）。
 * 热线电话、工作时间、常见问题列表都从后台读，运营改信息不用发版。
 */
export const getSupportConfig = () => {
  return new Promise((resolve) => {
    uni.request({
      url: AGENT_BASE_URL + '/api/admin/public/support-config',
      method: 'GET',
      success: (res) => resolve(res.data || {}),
      fail: () => resolve({})
    });
  });
};

/** 收藏/取消收藏商品（toggle）。返回 {ok, favorited}。 */
export const favoriteToggle = (productId) => {
  return new Promise((resolve) => {
    uni.request({
      url: AGENT_BASE_URL + '/api/admin/public/favorite-toggle',
      method: 'POST',
      header: agentHeaders(),
      data: { productId },
      success: (res) => resolve(res.data || {}),
      fail: () => resolve({ ok: false, error: '网络异常' })
    });
  });
};

/** 查询某商品是否已收藏（详情页初始化心形状态）。 */
export const favoriteStatus = (productId) => {
  return new Promise((resolve) => {
    uni.request({
      url: AGENT_BASE_URL + '/api/admin/public/favorite-status?productId=' + productId,
      method: 'GET',
      header: agentHeaders(),
      success: (res) => resolve(res.data || { favorited: false }),
      fail: () => resolve({ favorited: false })
    });
  });
};

/** 我的收藏商品列表。 */
export const favoriteList = () => {
  return new Promise((resolve) => {
    uni.request({
      url: AGENT_BASE_URL + '/api/admin/public/favorites',
      method: 'GET',
      header: agentHeaders(),
      success: (res) => resolve(res.data || { rows: [] }),
      fail: () => resolve({ rows: [] })
    });
  });
};

/** 取消收藏茶具（只能取消自己的）。 */
export const removeTeaware = (teawareId) => {
  return new Promise((resolve) => {
    uni.request({
      url: AGENT_BASE_URL + '/api/admin/public/teaware-remove',
      method: 'POST',
      header: agentHeaders(),
      data: { teawareId },
      success: (res) => resolve(res.data || {}),
      fail: () => resolve({ ok: false, error: '网络异常' })
    });
  });
};

/** 领取一张券。需要登录（token 由 agentHeaders 带上）。 */
export const claimCoupon = (couponId) => {
  return new Promise((resolve) => {
    uni.request({
      url: AGENT_BASE_URL + '/api/admin/public/coupon-claim',
      method: 'POST',
      header: agentHeaders(),
      data: { couponId },
      success: (res) => resolve(res.data || {}),
      fail: () => resolve({ ok: false, error: '网络异常，请稍后重试' })
    });
  });
};

/**
 * 删除自己的一张「已失效」优惠券。
 *
 * 传的是 coupon_user.id（我的券列表里的 id），不是券模板的 coupon.id。
 * 服务端只把该用户这条记录软删成 status='deleted'，不影响其他人，
 * 也不动物理数据和发放统计。未过期的券会被服务端拒绝。
 */
export const deleteMyCoupon = (id) => {
  return new Promise((resolve) => {
    uni.request({
      url: AGENT_BASE_URL + '/api/admin/public/coupon-user-delete',
      method: 'POST',
      header: agentHeaders(),
      data: { id },
      success: (res) => resolve(res.data || {}),
      fail: () => resolve({ ok: false, error: '网络异常，请稍后重试' })
    });
  });
};

/**
 * 确认收货（待收货 → 待评价）。
 *
 * 老项目没有这个接口，原小程序实现只弹 Toast、改本地变量，
 * 刷新后状态会还原。这里接到 agent-service 的真实实现。
 */
export const confirmReceipt = (orderId) => {
  return new Promise((resolve) => {
    uni.request({
      url: AGENT_BASE_URL + '/api/admin/public/order-confirm-receipt',
      method: 'POST',
      header: agentHeaders(),
      data: { orderId },
      success: (res) => resolve(res.data || {}),
      fail: () => resolve({ ok: false, error: '网络异常，请稍后重试' })
    });
  });
};

/** 清空会话记忆 */
export const agentClearSession = (sessionId) => {
  return new Promise((resolve) => {
    uni.request({
      url: AGENT_BASE_URL + '/api/agent/session/' + sessionId,
      method: 'DELETE',
      complete: resolve
    });
  });
};

/**
 * 拉取当前用户的对话历史（退出页面再进入时恢复聊天记录）。
 * 后端按「用户身份」查（登录用户记忆域是 u{userId}，跨会话共享），
 * 所以退出重进、甚至换个页面再回来，都能拿到同一份记录。
 * 未登录时退回按 sessionId 查，保证匿名访客也能看到本会话记录。
 */
export const agentHistory = (sessionId) => {
  return new Promise((resolve) => {
    uni.request({
      url: AGENT_BASE_URL + '/api/agent/history',
      method: 'GET',
      header: agentHeaders(),
      data: { sessionId },
      success: (res) => resolve(res.statusCode === 200 ? (res.data || {}) : {}),
      fail: () => resolve({})
    });
  });
};

/** 当前生效的 LLM 运行态（模型名 / 是否 Mock），用于前端徽章 */
export const agentLlmInfo = () => {
  return new Promise((resolve) => {
    uni.request({
      url: AGENT_BASE_URL + '/api/agent/llm-info',
      method: 'GET',
      success: (res) => resolve(res.statusCode === 200 ? res.data : null),
      fail: () => resolve(null)
    });
  });
};