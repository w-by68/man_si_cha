<template>
	<div class="tea-app product-detail-page">
		<!-- 宣纸底纹背景 -->
		<div class="paper-texture"></div>

		<!-- 顶部导航 -->
		<header class="tea-header">
			<div class="header-left" @click="goBack">
				<van-icon name="arrow-left" size="20" color="#2C5E30" />
			</div>
			<h1 class="page-title">商品详情</h1>
			<div class="header-right" @click="goToCart">
				<van-icon name="shopping-cart-o" size="20" color="#8B5A2B" />
				<span v-if="cartCount > 0" class="cart-badge">{{ cartCount }}</span>
			</div>
		</header>
       
		<!-- 主内容区（可滚动） -->
		<main class="detail-content">
			<!-- 商品图片轮播
			     ⚠️ 这里必须做双端分流：
			     H5 端 vant 4 有 Swipe/SwipeItem，由 main.js 的 app.use(Vant) 全局注册，
			     模板直接写 <van-swipe> 在网页端是能解析的；
			     但小程序端走的是 wxcomponents/vant-weapp，而本项目这一份 vant-weapp
			     **并没有 swipe / swipe-item 组件目录**（只有 swipe-cell）——
			     实测小程序构建产物 pages/productxq.wxml 里照样输出了 <van-swipe> 标签，
			     而 productxq.json 的 usingComponents 是空的、app.json 里也没有这两个，
			     即小程序端这两个标签是「未注册组件」，真机上不会渲染出任何东西。
			     因此小程序端改用原生 swiper（等价能力，且零依赖）。 -->
			<div class="product-swipe">
				<!-- #ifdef H5 -->
				<van-swipe-cell :right-width="80"
					:left-width="80"
					>
					<div class="swipe-cell-content">
						<van-swipe :autoplay="3000" indicator-color="#2C5E30">
							<van-swipe-item :key="index">
								<div class="swipe-item">
									<span class="image-emoji">{{ product.emoji }}</span>
								</div>
							</van-swipe-item>
						</van-swipe>
						<div class="product-tag" :class="product.isNew ? 'new' : 'hot'">
							{{ product.isNew ? '新品' : '热卖' }}
						</div>
					</div>

					<!-- 右侧侧滑操作按钮（示例：收藏） -->
					<template #right>
						<div class="swipe-cell-btn right-btn">
							收藏
						</div>
					</template>

					<!-- 左侧侧滑操作按钮（示例：分享） -->
					<template #left>
						<div class="swipe-cell-btn left-btn">
							分享
						</div>
					</template>
				</van-swipe-cell>
				<!-- #endif -->

				<!-- #ifndef H5 -->
				<!-- 小程序端：原生 swiper 轮播 + 普通收藏/分享按钮（vant-weapp 无 swipe 组件） -->
				<div class="swipe-cell-content">
					<swiper class="native-swiper" :autoplay="true" :interval="3000" :circular="true"
						indicator-color="#2C5E30" indicator-active-color="#2C5E30">
						<swiper-item>
							<div class="swipe-item">
								<span class="image-emoji">{{ product.emoji }}</span>
							</div>
						</swiper-item>
					</swiper>
					<div class="product-tag" :class="product.isNew ? 'new' : 'hot'">
						{{ product.isNew ? '新品' : '热卖' }}
					</div>
				</div>
				<div class="native-actions">
					<div class="swipe-cell-btn left-btn" @click="goBack">分享</div>
					<div class="swipe-cell-btn right-btn" @click="goBack">收藏</div>
				</div>
				<!-- #endif -->
			</div>
			<!-- 商品基本信息 -->
			<div class="product-info-card">
				<div class="product-header">
					<div class="product-title">
						<h2 class="product-name">{{ product.name }}</h2>
						<span class="product-subtitle">{{ product.subtitle }}</span>
					</div>
					<div class="product-price">
						<span class="current-price">¥{{ product.price }}</span>
						<span v-if="product.originalPrice" class="original-price">¥{{ product.originalPrice }}</span>
					</div>
				</div>

				<div class="product-meta">
					<div class="meta-item">
						<span class="meta-label">评分</span>
						<span class="meta-value">
							<van-rate v-model="product.rating" :size="16" color="#DAA520" void-icon="star"
								void-color="#E0D9D0" :value="Math.round(product.rating)" allow-half/>
							<span class="rating-text">{{ product.rating }}分</span>
						</span>
					</div> 
					<div class="meta-item">
						<span class="meta-label">销量</span>
						<span class="meta-value">{{ product.sales }}件</span>
					</div>
					<div class="meta-item">
						<span class="meta-label">库存</span>
						<span class="meta-value">{{ product.stock }}件</span>
					</div>
				</div>

				<div class="product-origin">
					<span class="origin-label">产地</span>
					<span class="origin-value">{{ product.origin }} · {{ product.originDetail }}</span>
				</div>
			</div>

			<!-- 规格选择 -->
			<div class="spec-section">
				<div class="section-title">选择规格</div>
				<div class="spec-list">
					<div v-for="spec in product.specs" :key="spec.id" class="spec-item"
						:class="{ 'active': selectedSpec === spec.id }" @click="btnProductSpec(spec)">
						<span class="spec-name">{{ spec.specName }}</span>
						<span class="spec-price">¥{{ spec.price }}</span>
					</div>
				</div>
			</div>

			<!-- 数量选择 -->
			<div class="quantity-section">
				<div class="section-title">购买数量</div>
				<div class="quantity-control">
					<button class="qty-btn minus" @click="decreaseQuantity" :disabled="quantity <= 1">
						<van-icon name="minus" size="14" color="#8B5A2B" />
					</button>
					<span class="qty-number">{{ quantity }}</span>
					<button class="qty-btn plus" @click="increaseQuantity" :disabled="quantity >= product.stock">
						<van-icon name="plus" size="14" color="#8B5A2B" />
					</button>
					<span class="stock-text">库存 {{ product.stock }} 件</span>
				</div>
			</div>

			<!-- 店铺信息 -->
			<div class="shop-section" @click="goToShop(product.shopId)">
				<div class="shop-info">
					<div class="shop-avatar">
						<span class="shop-emoji">{{ product.shopEmoji || '🏪' }}</span>
					</div>
					<div class="shop-detail">
						<div class="shop-name-row">
							<span class="shop-name">{{ product.shopName }}</span>
							<span class="shop-badge">{{ product.shopBadge }}</span>
						</div>
						<div class="shop-meta">
							<span class="shop-rating">⭐ {{ product.shopRating }}</span>
							<span class="shop-fans">{{ product.fansCount }}粉丝</span>
						</div>
					</div>
				</div>
				<div class="shop-arrow">
					<van-icon name="arrow" size="16" color="#8B5A2B" />
				</div>
			</div>

			<!-- 商品详情 -->
			<div class="detail-section">
				<div class="section-title">商品详情</div>
				<div class="detail-content">
					<p class="detail-text">{{ product.description }}</p>

					<div class="detail-attributes">
						<div class="attribute-item">
							<span class="attribute-label">🍃 茶类</span>
							<span class="attribute-value">{{ product.categoryName }}</span>
						</div>
						<div class="attribute-item">
							<span class="attribute-label">📦 规格</span>
							<span class="attribute-value">{{ product.spec }}</span>
						</div>
						<div class="attribute-item">
							<span class="attribute-label">🏭 工艺</span>
							<span class="attribute-value">{{ product.craft || '传统工艺' }}</span>
						</div>
						<div class="attribute-item">
							<span class="attribute-label">📅 年份</span>
							<span class="attribute-value">{{ product.year || '2025' }}</span>
						</div>
					</div>

					<div class="tasting-notes">
						<h4 class="notes-title">🍵 品鉴笔记</h4>
						<p class="notes-text">{{ product.tastingNotes }}</p>
					</div>
				</div>
			</div>

			<!-- 商品评价 -->
			<div class="review-section">
				<div class="review-header">
					<div class="section-title" style="margin-bottom:0">商品评价</div>
					<div v-if="reviewTotal > 0" class="review-overview">
						<span class="review-avg">{{ reviewAvg }}</span>
						<span class="review-stars-small">{{ starsOf(reviewAvg) }}</span>
						<span class="review-good">好评率 {{ reviewGoodRate }}%</span>
					</div>
					<div v-else class="review-overview">
						<span class="review-empty-tip">暂无评价</span>
					</div>
				</div>

				<!-- 评分分布 -->
				<div v-if="reviewTotal > 0" class="review-dist">
					<div v-for="d in reviewDist" :key="d.rating" class="dist-row">
						<span class="dist-label">{{ d.rating }} 星</span>
						<div class="dist-track">
							<div class="dist-fill" :style="{ width: distPct(d) + '%' }"></div>
						</div>
						<span class="dist-count">{{ d.c }}</span>
					</div>
				</div>

				<!-- 评价列表 -->
				<div v-if="reviews.length > 0" class="review-list">
					<div v-for="r in reviews" :key="r.id" class="review-item">
						<div class="review-item-head">
							<span class="review-avatar">{{ r.avatarEmoji || '🍵' }}</span>
							<span class="review-nick">{{ r.nickname || '匿名用户' }}</span>
							<span class="review-item-stars">{{ starsOf(r.rating) }}</span>
							<span class="review-date">{{ (r.createdAt || '').slice(0, 10) }}</span>
						</div>
						<div class="review-content">{{ r.content }}</div>
						<div v-if="r.reply" class="review-reply">
							<span class="reply-tag">商家回复</span>{{ r.reply }}
						</div>
					</div>

					<div v-if="reviewTotal > reviews.length" class="review-more" @click="loadMoreReviews">
						{{ reviewLoading ? '加载中…' : '加载更多评价' }}
					</div>
				</div>

				<div v-else class="review-empty">
					<span class="review-empty-emoji">🍃</span>
					<div class="review-empty-text">还没有人评价这件茶品</div>
				</div>
			</div>

			<!-- 相关主题推荐 -->
			<div class="related-section">
				<div class="section-header">
					<h3 class="section-title">同主题推荐</h3>
				</div>
				<div class="related-products">
					<div v-for="item in relatedProducts" :key="item.productId" class="related-item"
						@click="goToProduct(item.productId)">
						<div class="related-image">
							<span class="related-emoji">{{ item.productEmoji }}</span>
						</div>
						<div class="related-info">
							<h4 class="related-name">{{ item.productName }}</h4>
							<span class="related-price">¥{{ item.price }}</span>
						</div>
					</div>
				</div>
			</div>

			<!-- 底部留白 -->
			<div class="bottom-space"></div>
		</main>
		<!-- 下架遮罩 -->
		<div v-if="offShelf" class="offshelf-mask">
			<div class="offshelf-card">
				<div class="offshelf-emoji">🍃</div>
				<div class="offshelf-title">该商品已下架</div>
				<div class="offshelf-text">暂时无法购买，去看看其他茶品吧</div>
				<button class="offshelf-btn" @click="goBack">返回</button>
			</div>
		</div>


		<!-- 底部操作栏 -->
		<footer class="detail-footer" v-if="!offShelf">
			<div class="footer-actions">
				<div class="action-item" @click="toggleFavorite">
					<van-icon :name="isFavorite ? 'like' : 'like-o'" :color="isFavorite ? '#CD5C5C' : '#8B5A2B'"
						size="22" />
					<span class="action-text">{{ isFavorite ? '已收藏' : '收藏' }}</span>
				</div>
				<div class="action-item" @click="goToCart">
					<van-icon name="shopping-cart-o" color="#8B5A2B" size="22" />
					<span class="action-text">购物车</span>
				</div>
			</div>
			<div class="footer-buttons">
				<button class="cart-btn" @click="addToCart">加入购物车</button>
				<button class="buy-btn" @click="buyNow">立即购买</button>
			</div>
		</footer>

		<!-- 加入购物车成功提示 -->
		<div class="toast" :class="{ visible: toastVisible }">
			<div class="toast-dot success" />
			<span>{{ toastMessage }}</span>
		</div>

		<!-- 添加到购物车动画 -->
		<div v-if="showAddAnimation" class="add-animation" @animationend="showAddAnimation = false">
			<span class="animation-emoji">🛒</span>
		</div>
	</div>
</template>

<script setup>
	import {
		ref,
		computed,
		onMounted,
		getCurrentInstance
	} from 'vue'
	import {
		selectSingle,
		ThemeSingle,
		selectVCartDetail,
		insertCartItem,
		AGENT_BASE_URL,
		favoriteToggle,
		favoriteStatus
	} from "../api/index.js"
	import { onLoad } from '@dcloudio/uni-app'

	// ============ 状态定义 ============
	const toastVisible = ref(false)
	const toastMessage = ref('')
	const toastTimer = ref(null)
	const showAddAnimation = ref(false)
	const cartCount = ref(0) // 模拟购物车数量
	const selectedSpec = ref(1)
	const quantity = ref(1)
	const isFavorite = ref(false)

	// ============ 商品数据 ============
	const product = ref({})
	const offShelf = ref(false)   // 商品已下架（后台下架或数据异常）

	// ============ 同主题推荐商品 ============
	const relatedProducts = ref([])

	// ============ 商品评价 ============
	const reviews = ref([])
	const reviewTotal = ref(0)
	const reviewAvg = ref(0)
	const reviewGoodRate = ref(0)
	const reviewDist = ref([])
	const reviewLoading = ref(false)
	const reviewPage = ref(1)
	const REVIEW_PAGE_SIZE = 10

	// ============ 方法 ============
	
	onLoad((option) => {
		// ⚠️ 兜底：本页原本只靠 eventChannel 从上游页面拿 productId，
		// 若从分享链接 / 扫码 / 页面栈被重置等场景直接进入，eventChannel 为空，
		// 商品数据永远加载不出来（页面空白、评价区也不显示）。
		// 用 URL 参数作为备选来源。
		if (option && option.productId) {
			selectProudctSingle({
				productId: option.productId,
				themeId: option.themeId || null
			})
		}

		// 获取当前组件实例
		const instance = getCurrentInstance()
		// 获取事件通道
		const eventChannel = instance.proxy.getOpenerEventChannel()
		if (eventChannel && typeof eventChannel.emit === 'function') {
			// 向父页面发送数据
			eventChannel.emit('acceptCateAndProductxq', {
				data: '首页面传来的数据'
			})
			eventChannel.emit('acceptShopAndProductxq', {
				data: '店铺页面传来的数据'
			})
			eventChannel.emit('acceptGowucAndProductxq', {
				data: '购物车页面传来的数据'
			})
			// 监听父页面传来的数据
			// 注意：这里的事件监听器会一直存在，需要在 onUnload 中移除
			const acceptCateAndProductxqHandler = async(data) => {
				// 这里可以处理接收到的数据
				selectProudctSingle(data.data)
			}
			const acceptShopAndProductxqHandler = async(data) => {
				// 这里可以处理接收到的数据
				selectProudctSingle(data.data)
			}
			const acceptGowucAndProductxqHandler = async(data) => {
				// 这里可以处理接收到的数据
				selectProudctSingle(data.data)
				quantity.value = data.data.quantity || 1
				selectedSpec.value = data.data.specId
				
			}
			eventChannel.on('acceptCateAndProductxq', acceptCateAndProductxqHandler)
			eventChannel.on('acceptShopAndProductxq', acceptShopAndProductxqHandler)
			eventChannel.on('acceptGowucAndProductxq', acceptGowucAndProductxqHandler)
		}
		quantityCount()
	})
	
	const btnProductSpec = (res) => {
		selectedSpec.value = res.id
		product.value.price = res.price
		product.value.originalPrice = res.originalPrice
	}
	
	// 计算当前用户购物车已有的数量
	const quantityCount = async() => {
		cartCount.value = 0;
		await selectVCartDetail().then(res => {
			res.VCartDetailEnhancedList.forEach(ele => {
				cartCount.value += ele.quantity
			})
		})
	}
	
	//获取商品数据
	const selectProudctSingle = async(data) => {
		await selectSingle({id: data.productId}).then(res => {
			// ⚠️ 老项目对已下架商品返回 vProductShopFull=null（但 productSpecs 仍有数据）。
			// 不判断的话 product.value 变成空对象，页面所有字段都是 undefined——
			// 看起来像白屏但加购/购买按钮还在，用户可以对不存在的商品下单。
			const p = res.vProductShopFull;
			if (!p || !p.id) {
				offShelf.value = true;
				product.value = { id: data.productId, name: '该商品已下架', status: 0 };
				product.value.specs = [];
				return;
			}
			offShelf.value = (Number(p.status) === 0);
			product.value = p;
			product.value.specs = res.productSpecs || [];
			// 初始化收藏状态（未登录返回 false，不报错）
			if (p.id) {
				favoriteStatus(p.id).then(fs => {
					isFavorite.value = !!(fs && fs.favorited)
				}).catch(() => {})
			}
		})
		// themeId 可能为空（URL 直达时没有主题上下文），为空就跳过关联推荐，
		// 不要让 ThemeSingle 抛错把后面的评价加载也带崩。
		if (data.themeId) {
			await ThemeSingle({themeId: data.themeId}).then(res => {
				relatedProducts.value = res.themeProductCategory || []
			})
		}
		// 商品 ID 到位后再拉评价：评价接口按 productId 查，提前调用拿不到数据。
		// 不 await —— 评价加载慢不该拖住商品详情的渲染。
		if (product.value && product.value.id) {
			loadReviews(true)
		}
	}
	
	const showToast = (msg, duration = 2000) => {
		if (toastTimer.value) clearTimeout(toastTimer.value)
		toastMessage.value = msg
		toastVisible.value = true
		toastTimer.value = setTimeout(() => {
			toastVisible.value = false
		}, duration)
	}

	const goBack = () => {
		uni.navigateBack()
	}

	const goToCart = () => {
		showToast('跳转购物车')
		uni.redirectTo({
			url: '/pages/gowuc'
		})
	}

	const goToShop = (shopId) => {
		showToast(`进入店铺：${shopId}`)
		uni.navigateTo({
			url: '/pages/shop',
			events: {
				// 为指定事件添加一个监听器，获取被打开页面传送到当前页面的数据
				acceptProductxqAndShop: function(data) {
					console.log("acceptProductxqAndShop", data)
				}
			},
			success: function(res) {
				// 通过eventChannel向被打开页面传送数据
				res.eventChannel.emit('acceptProductxqAndShop', {
					data: shopId
				})
			}
		});
	}

	/**
	 * 星级字符串。半星用「⯪」不好看，这里直接四舍五入到整星。
	 * 评分 4.6 → ★★★★★（5 颗），比显示 4.5 颗更符合电商习惯。
	 */
	const starsOf = (rating) => {
		const n = Math.max(0, Math.min(5, Math.round(Number(rating) || 0)))
		return '★'.repeat(n) + '☆'.repeat(5 - n)
	}

	/** 某档评分占全部评价的百分比，用于分布条宽度 */
	const distPct = (d) => {
		const total = Number(reviewTotal.value) || 0
		if (!total) return 0
		return Math.max(2, Math.round(Number(d.c) * 100 / total))
	}

	/**
	 * 加载评价（第一页）。
	 *
	 * 走 /api/admin/public/product-reviews —— 这个接口**不需要后台令牌**，
	 * 且只返回审核通过的评价。待审/拒绝的内容不会出现在这里。
	 *
	 * 失败时静默处理：评价加载不出来不该影响商品详情的浏览，
	 * 用户仍能看到商品、规格、价格。只在控制台留日志。
	 */
	const loadReviews = async (reset = true) => {
		if (reviewLoading.value) return
		if (!product.value.id) return

		reviewLoading.value = true
		if (reset) reviewPage.value = 1

		// 用回调式而非 await：与项目里其它 uni.request 的写法保持一致，
		// 且小程序端 Promise 化行为依赖基础库版本，回调式最稳。
		uni.request({
			url: AGENT_BASE_URL + '/api/admin/public/product-reviews?productId='
				+ product.value.id + '&page=' + reviewPage.value + '&size=' + REVIEW_PAGE_SIZE,
			method: 'GET',
			success: (res) => {
				const d = (res && res.data) || {}
				const rows = (d.rows || []).map(r => ({
					id: r.id,
					rating: r.rating,
					content: r.content,
					nickname: r.nickname,
					avatarEmoji: r.avatar_emoji,
					reply: r.reply,
					createdAt: r.created_at
				}))
				reviews.value = reset ? rows : reviews.value.concat(rows)
				reviewTotal.value = d.total || 0
				reviewAvg.value = d.avgRating || 0
				reviewGoodRate.value = d.goodRate || 0
				reviewDist.value = d.distribution || []
			},
			// 评价加载失败不影响商品浏览：商品图、规格、价格、加购都还能用，
			// 只是评价区显示「暂无评价」。不弹错误提示，避免干扰主流程。
			fail: (e) => {
				console.warn('评价加载失败（不影响商品浏览）', e)
			},
			complete: () => {
				reviewLoading.value = false
			}
		})
	}

	const loadMoreReviews = async () => {
		if (reviewLoading.value) return
		if (reviews.value.length >= reviewTotal.value) return
		reviewPage.value += 1
		await loadReviews(false)
	}

	const goToProduct = async(productId) => {
		showToast(`跳转商品：${productId}`)
		// 实际项目中更新当前页面
		await selectSingle({id: productId}).then(res => {
			product.value = res.vProductShopFull;
			product.value.specs = res.productSpecs;
		})
	}

	/**
	 * 收藏/取消收藏（接真实接口）。
	 * 原实现只翻转本地变量——刷新即丢，数据库里根本没有收藏记录。
	 * 现在 POST /favorite-toggle：唯一键兜底幂等，重复点不产生重复记录。
	 */
	const toggleFavorite = async () => {
		if (!product.value.id) return
		try {
			const res = await favoriteToggle(product.value.id)
			if (res && res.ok) {
				isFavorite.value = !!res.favorited
				showToast(res.favorited ? '已添加到收藏' : '已取消收藏')
			} else {
				showToast((res && res.error) || '操作失败')
			}
		} catch (e) {
			showToast('网络异常，请稍后重试')
		}
	}

	const decreaseQuantity = () => {
		if (quantity.value > 1) {
			quantity.value--
		}
	}

	const increaseQuantity = () => {
		if (quantity.value < product.value.stock) {
			quantity.value++
		}
	}

	const addToCart = async() => {
		// 显示动画
		showAddAnimation.value = true

		// 模拟加入购物车
		showToast(`成功加入购物车，数量：${quantity.value}`)
		const dat = {
			productId: product.value.id,
			quantity: quantity.value,
			checked: 1,
			specId: selectedSpec.value
		}
		// 更新购物车
		await insertCartItem(dat).then(res => {
			// 重新计算右上角购物车数量
			quantityCount()
		})
	}

	const buyNow = () => {
		showToast(`立即购买：${product.value.name} x${quantity.value}`)
		// 跳转到确认订单页
		// router.push('/checkout')
	}

</script>

<style scoped>
	/* ========== 全局样式 ========== */
	.tea-app {
		position: relative;
		width: 100%;
		min-height: 100vh;
		max-width: 400px;
		margin: 0 auto;
		background: linear-gradient(145deg, #F5F0E8 0%, #F0E9E0 100%);
		font-family: '思源宋体', 'Songti SC', 'Times New Roman', serif;
		overflow-x: hidden;
	}

	.paper-texture {
		position: fixed;
		top: 0;
		left: 50%;
		transform: translateX(-50%);
		width: 375px;
		height: 100%;
		background-image:
			repeating-linear-gradient(45deg,
				rgba(139, 90, 43, 0.02) 0px,
				rgba(139, 90, 43, 0.02) 2px,
				transparent 2px,
				transparent 8px);
		pointer-events: none;
		z-index: 0;
	}

	/* ========== 顶部导航 ========== */
	.tea-header {
		position: relative;
		display: flex;
		align-items: center;
		justify-content: space-between;
		padding: 12px 16px;
		background: rgba(253, 250, 245, 0.92);
		backdrop-filter: blur(8px);
		border-bottom: 0.5px solid rgba(139, 90, 43, 0.15);
		z-index: 10;
	}

	.page-title {
		margin: 0;
		font-size: 18px;
		font-weight: 600;
		color: #2C2C2C;
		letter-spacing: 1px;
	}

	.header-left,
	.header-right {
		width: 40px;
		height: 40px;
		display: flex;
		align-items: center;
		justify-content: center;
		border-radius: 50%;
		background: rgba(245, 240, 232, 0.8);
		border: 0.5px solid rgba(139, 90, 43, 0.1);
		cursor: pointer;
		position: relative;
	}

	.cart-badge {
		position: absolute;
		top: -4px;
		right: -4px;
		min-width: 18px;
		height: 18px;
		background: #CD5C5C;
		border-radius: 10px;
		color: #FFFFFF;
		font-size: 10px;
		display: flex;
		align-items: center;
		justify-content: center;
		padding: 0 4px;
	}

	/* ========== 商品图片轮播 ========== */
	/* 轮播容器样式 */
	.product-swipe {
	  position: relative;
	  width: 100%;
	  height: 100%; /* 根据需求调整 */
	}
	/* swipe-cell主体内容样式 */
	.swipe-cell-content {
	  height: 100%;
	}
	/* 轮播项样式 */
	.swipe-item {
	  display: flex;
	  align-items: center;
	  justify-content: center;
	  height: 100%;
	  background-color: #f5f5f5;
	}
	/* 图片表情样式 */
	.image-emoji {
	  font-size: 150px; /* 根据需求调整 */
	}
	/* 商品标签样式 */
	.product-tag {
	  position: absolute;
	  top: 10px;
	  right: 10px;
	  padding: 4px 8px;
	  border-radius: 4px;
	  color: #fff;
	  font-size: 12px;
	}
	/* 新品标签 */
	.product-tag.new {
	  background-color: #2C5E30;
	}
	/* 热卖标签 */
	.product-tag.hot {
	  background-color: #e64340;
	}
	/* 侧滑按钮样式 */
	.swipe-cell-btn {
	  display: flex;
	  align-items: center;
	  justify-content: center;
	  height: 100%;
	  width: 80px;
	  color: #fff;
	}
	/* 右侧按钮（收藏） */
	.right-btn {
	  background-color: #1989fa;
	}
	/* 左侧按钮（分享） */
	.left-btn {
	  background-color: #4cd964;
	}

	/* ---------- 小程序端专用：原生 swiper 轮播 ----------
	   小程序走原生 swiper 替代 van-swipe（本项目的 vant-weapp 没有该组件）。
	   swiper 必须给定高度，否则默认高度为 0，轮播不可见。 */
	.native-swiper {
	  width: 100%;
	  height: 360px;
	}
	.native-swiper .swipe-item {
	  height: 360px;
	}
	/* 小程序端专用：收藏/分享按钮从「侧滑」改为常驻一行
	   （原生 swiper 没有 swipe-cell 的手势容器，常驻更直观且不会误触） */
	.native-actions {
	  display: flex;
	  gap: 12px;
	  padding: 12px 16px 0;
	}
	.native-actions .swipe-cell-btn {
	  flex: 1;
	  height: 40px;
	  border-radius: 8px;
	  font-size: 14px;
	}

	/* ========== 商品信息卡片 ========== */
	.product-info-card {
		background: #FDFAF5;
		padding: 20px 16px;
		margin-bottom: 8px;
		border-bottom: 0.5px solid rgba(139, 90, 43, 0.1);
	}

	.product-header {
		display: flex;
		justify-content: space-between;
		align-items: flex-start;
		margin-bottom: 12px;
	}

	.product-title {
		flex: 1;
	}

	.product-name {
		font-size: 20px;
		font-weight: 700;
		color: #2C2C2C;
		margin: 0 0 4px;
	}

	.product-subtitle {
		font-size: 13px;
		color: #8E8E8E;
	}

	.product-price {
		text-align: right;
	}

	.current-price {
		font-size: 24px;
		font-weight: 700;
		color: #8B5A2B;
		display: block;
	}

	.original-price {
		font-size: 14px;
		color: #A7B89E;
		text-decoration: line-through;
	}

	.product-meta {
		display: flex;
		gap: 24px;
		margin-bottom: 12px;
		padding: 12px 0;
		border-top: 1px solid rgba(139, 90, 43, 0.08);
		border-bottom: 1px solid rgba(139, 90, 43, 0.08);
	}

	.meta-item {
		flex: 1;
		display: flex;
		flex-direction: column;
		gap: 4px;
	}

	.meta-label {
		font-size: 12px;
		color: #8E8E8E;
	}

	.meta-value {
		font-size: 14px;
		font-weight: 500;
		color: #2C2C2C;
		display: flex;
		align-items: center;
		gap: 4px;
	}

	.rating-text {
		width: 30px;
		margin-left: 4px;
		font-size: 13px;
		color: #DAA520;
	}

	.product-origin {
		display: flex;
		align-items: center;
		gap: 8px;
		font-size: 13px;
	}

	.origin-label {
		color: #8E8E8E;
		min-width: 40px;
	}

	.origin-value {
		color: #2C5E30;
		font-weight: 500;
	}

	/* ========== 规格选择 ========== */
	.spec-section,
	.quantity-section,
	.shop-section,
	.theme-section,
	.detail-section,
	.related-section {
		background: #FDFAF5;
		padding: 16px;
		margin-bottom: 8px;
		border-bottom: 0.5px solid rgba(139, 90, 43, 0.1);
	}

	.offshelf-mask {
		position: fixed;
		inset: 0;
		background: rgba(250, 247, 242, 0.96);
		z-index: 50;
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.offshelf-card {
		text-align: center;
		padding: 40px 30px;
	}

	.offshelf-emoji {
		font-size: 46px;
		margin-bottom: 16px;
		opacity: 0.6;
	}

	.offshelf-title {
		font-size: 17px;
		font-weight: 600;
		color: #2C2C2C;
		margin-bottom: 10px;
	}

	.offshelf-text {
		font-size: 13px;
		color: #8B7355;
		margin-bottom: 26px;
		line-height: 1.7;
	}

	.offshelf-btn {
		padding: 10px 38px;
		border-radius: 20px;
		border: 1px solid #8B5A2B;
		background: transparent;
		color: #8B5A2B;
		font-size: 14px;
		font-weight: 500;
	}

	.offshelf-btn:active {
		background: rgba(139, 90, 43, 0.08);
	}

	.review-section {
		background: #FDFAF5;
		padding: 16px;
		margin-bottom: 8px;
		border-bottom: 0.5px solid rgba(139, 90, 43, 0.1);
	}

	.review-header {
		display: flex;
		align-items: center;
		justify-content: space-between;
		margin-bottom: 12px;
	}

	.review-overview {
		display: flex;
		align-items: baseline;
		gap: 6px;
	}

	.review-avg {
		font-size: 20px;
		font-weight: 700;
		color: #C8A063;
	}

	.review-stars-small {
		font-size: 12px;
		color: #D4A853;
		letter-spacing: 1px;
	}

	.review-good {
		font-size: 11px;
		color: #8B7355;
	}

	.review-empty-tip {
		font-size: 12px;
		color: #B0A090;
	}

	.review-dist {
		background: rgba(139, 90, 43, 0.04);
		border-radius: 8px;
		padding: 10px 12px;
		margin-bottom: 14px;
	}

	.dist-row {
		display: flex;
		align-items: center;
		gap: 8px;
		margin-bottom: 6px;
	}

	.dist-row:last-child { margin-bottom: 0; }

	.dist-label {
		font-size: 11px;
		color: #8B7355;
		width: 30px;
		flex-shrink: 0;
	}

	.dist-track {
		flex: 1;
		height: 6px;
		background: rgba(139, 90, 43, 0.1);
		border-radius: 3px;
		overflow: hidden;
	}

	.dist-fill {
		height: 100%;
		background: linear-gradient(90deg, #D4A853, #C8A063);
		border-radius: 3px;
		transition: width 0.4s ease;
	}

	.dist-count {
		font-size: 11px;
		color: #8B7355;
		width: 26px;
		text-align: right;
		flex-shrink: 0;
	}

	.review-list { margin-top: 4px; }

	.review-item {
		padding: 12px 0;
		border-bottom: 0.5px solid rgba(139, 90, 43, 0.08);
	}

	.review-item:last-child { border-bottom: none; }

	.review-item-head {
		display: flex;
		align-items: center;
		gap: 8px;
		margin-bottom: 7px;
	}

	.review-avatar { font-size: 18px; }

	.review-nick {
		font-size: 12px;
		color: #5C4A38;
		font-weight: 500;
	}

	.review-item-stars {
		font-size: 11px;
		color: #D4A853;
		letter-spacing: 0.5px;
	}

	.review-date {
		font-size: 10px;
		color: #B0A090;
		margin-left: auto;
	}

	.review-content {
		font-size: 13px;
		color: #3C3028;
		line-height: 1.7;
		word-break: break-word;
	}

	.review-reply {
		margin-top: 8px;
		padding: 8px 10px;
		background: rgba(139, 90, 43, 0.05);
		border-radius: 6px;
		font-size: 12px;
		color: #6B5B4A;
		line-height: 1.6;
	}

	.reply-tag {
		color: #8B5A2B;
		font-weight: 600;
		margin-right: 6px;
	}

	.review-more {
		text-align: center;
		padding: 12px 0;
		font-size: 12px;
		color: #8B5A2B;
	}

	.review-empty {
		text-align: center;
		padding: 22px 0;
	}

	.review-empty-emoji {
		font-size: 26px;
		opacity: 0.5;
	}

	.review-empty-text {
		font-size: 12px;
		color: #B0A090;
		margin-top: 6px;
	}

	.section-title {
		font-size: 15px;
		font-weight: 600;
		color: #2C2C2C;
		margin-bottom: 12px;
		position: relative;
		padding-left: 10px;
	}

	.section-title::before {
		content: '';
		position: absolute;
		left: 0;
		top: 50%;
		transform: translateY(-50%);
		width: 3px;
		height: 16px;
		background: #2C5E30;
		border-radius: 2px;
	}

	.spec-list {
		display: flex;
		flex-wrap: wrap;
		gap: 8px;
	}

	.spec-item {
		flex: 1;
		min-width: 100px;
		padding: 12px;
		border: 1px solid rgba(139, 90, 43, 0.2);
		border-radius: 8px;
		text-align: center;
		cursor: pointer;
		transition: all 0.2s;
	}

	.spec-item.active {
		border-color: #2C5E30;
		background: rgba(44, 94, 48, 0.02);
		box-shadow: 0 0 0 1px #2C5E30;
	}

	.spec-name {
		display: block;
		font-size: 13px;
		color: #2C2C2C;
		margin-bottom: 4px;
	}

	.spec-price {
		display: block;
		font-size: 14px;
		font-weight: 600;
		color: #8B5A2B;
	}

	/* ========== 数量选择 ========== */
	.quantity-control {
		display: flex;
		align-items: center;
		gap: 12px;
	}

	.qty-btn {
		width: 36px;
		height: 36px;
		border-radius: 50%;
		border: 1px solid rgba(139, 90, 43, 0.2);
		background: #FFFFFF;
		display: flex;
		align-items: center;
		justify-content: center;
		cursor: pointer;
		transition: all 0.2s;
	}

	.qty-btn:active:not(:disabled) {
		background: rgba(44, 94, 48, 0.05);
		transform: scale(0.95);
	}

	.qty-btn:disabled {
		opacity: 0.3;
		cursor: not-allowed;
	}

	.qty-number {
		font-size: 16px;
		font-weight: 600;
		color: #2C2C2C;
		min-width: 30px;
		text-align: center;
	}

	.stock-text {
		font-size: 13px;
		color: #8E8E8E;
		margin-left: auto;
	}

	/* ========== 店铺信息 ========== */
	.shop-section {
		display: flex;
		align-items: center;
		justify-content: space-between;
		cursor: pointer;
	}

	.shop-info {
		display: flex;
		gap: 12px;
	}

	.shop-avatar {
		width: 48px;
		height: 48px;
		border-radius: 50%;
		background: linear-gradient(145deg, #EAEFE0, #DDE2D5);
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 24px;
	}

	.shop-detail {
		flex: 1;
	}

	.shop-name-row {
		display: flex;
		align-items: center;
		gap: 8px;
		margin-bottom: 4px;
	}

	.shop-name {
		font-size: 15px;
		font-weight: 600;
		color: #2C2C2C;
	}

	.shop-badge {
		padding: 2px 8px;
		background: rgba(44, 94, 48, 0.1);
		border-radius: 20px;
		font-size: 10px;
		color: #2C5E30;
	}

	.shop-meta {
		display: flex;
		gap: 16px;
		font-size: 12px;
		color: #8E8E8E;
	}

	.shop-arrow {
		padding: 8px;
	}

	/* ========== 主题关联 ========== */
	.theme-section {
		display: flex;
		align-items: center;
		justify-content: space-between;
		cursor: pointer;
		background: linear-gradient(145deg, rgba(44, 94, 48, 0.02), rgba(139, 90, 43, 0.02));
	}

	.theme-info {
		display: flex;
		align-items: center;
		gap: 12px;
	}

	.theme-emoji {
		font-size: 24px;
	}

	.theme-text {
		display: flex;
		flex-direction: column;
	}

	.theme-name {
		font-size: 14px;
		font-weight: 600;
		color: #2C5E30;
		margin-bottom: 2px;
	}

	.theme-desc {
		font-size: 11px;
		color: #8E8E8E;
	}

	.theme-arrow {
		display: flex;
		align-items: center;
		gap: 8px;
	}

	.theme-count {
		font-size: 11px;
		color: #8E8E8E;
	}

	/* ========== 商品详情 ========== */
	.detail-text {
		font-size: 14px;
		line-height: 1.7;
		color: #5A5A5A;
		margin-bottom: 16px;
	}

	.detail-attributes {
		display: grid;
		grid-template-columns: repeat(2, 1fr);
		gap: 12px;
		margin-bottom: 20px;
		padding: 16px;
		background: rgba(139, 90, 43, 0.02);
		border-radius: 12px;
	}

	.attribute-item {
		display: flex;
		flex-direction: column;
		gap: 4px;
	}

	.attribute-label {
		font-size: 11px;
		color: #8E8E8E;
	}

	.attribute-value {
		font-size: 13px;
		font-weight: 500;
		color: #2C2C2C;
	}

	.tasting-notes {
		padding: 16px;
		background: rgba(44, 94, 48, 0.02);
		border-radius: 12px;
		border-left: 3px solid #2C5E30;
	}

	.notes-title {
		font-size: 14px;
		font-weight: 600;
		color: #2C5E30;
		margin: 0 0 8px;
	}

	.notes-text {
		font-size: 13px;
		line-height: 1.6;
		color: #5A5A5A;
		margin: 0;
	}

	/* ========== 同主题推荐 ========== */
	.section-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 12px;
	}

	.more-link {
		font-size: 12px;
		color: #8E8E8E;
		cursor: pointer;
	}

	.related-products {
		display: flex;
		gap: 12px;
		overflow-x: auto;
		padding-bottom: 4px;
	}

	.related-item {
		flex: 0 0 100px;
		background: #FFFFFF;
		border-radius: 12px;
		padding: 12px;
		border: 0.5px solid rgba(139, 90, 43, 0.1);
		cursor: pointer;
		transition: all 0.2s;
	}

	.related-item:active {
		transform: scale(0.95);
	}

	.related-image {
		width: 60px;
		height: 60px;
		margin: 0 auto 8px;
		background: linear-gradient(145deg, #EAEFE0, #DDE2D5);
		border-radius: 50%;
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.related-emoji {
		font-size: 28px;
	}

	.related-info {
		text-align: center;
	}

	.related-name {
		font-size: 12px;
		font-weight: 500;
		color: #2C2C2C;
		margin: 0 0 4px;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}

	.related-price {
		font-size: 13px;
		font-weight: 600;
		color: #8B5A2B;
	}

	/* ========== 底部操作栏 ========== */
	.detail-footer {
		position: fixed;
		bottom: 0;
		left: 50%;
		transform: translateX(-50%);
		width: 100%;
		max-width: 375px;
		display: flex;
		align-items: center;
		background: rgba(253, 250, 245, 0.95);
		backdrop-filter: blur(10px);
		border-top: 0.5px solid rgba(139, 90, 43, 0.15);
		box-shadow: 0 -4px 12px rgba(44, 94, 48, 0.04);
		z-index: 20;
		box-sizing: border-box;
		padding: 8px 16px;
		gap: 16px;
	}

	.footer-actions {
		display: flex;
		gap: 16px;
	}

	.action-item {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 2px;
		cursor: pointer;
	}

	.action-text {
		font-size: 10px;
		color: #5A5A5A;
	}

	.footer-buttons {
		flex: 1;
		display: flex;
		gap: 8px;
	}

	.cart-btn,
	.buy-btn {
		flex: 1;
		height: 44px;
		border: none;
		border-radius: 22px;
		font-size: 15px;
		font-weight: 500;
		cursor: pointer;
		transition: all 0.2s;
	}

	.cart-btn {
		background: #F0E9E0;
		color: #5A5A5A;
		border: 0.5px solid rgba(139, 90, 43, 0.2);
	}

	.buy-btn {
		background: #2C5E30;
		color: #FFFFFF;
		box-shadow: 0 4px 8px rgba(44, 94, 48, 0.2);
	}

	.cart-btn:active {
		background: #E8DDD2;
	}

	.buy-btn:active {
		background: #1E4322;
		transform: scale(0.98);
	}

	/* ========== 轻提示 ========== */
	.toast {
		position: fixed;
		left: 50%;
		bottom: 100px;
		transform: translateX(-50%) translateY(20px);
		padding: 8px 16px;
		border-radius: 999px;
		background: rgba(4, 23, 12, 0.96);
		color: #f9fff8;
		font-size: 11px;
		display: flex;
		align-items: center;
		gap: 8px;
		box-shadow: 0 12px 24px rgba(0, 0, 0, 0.85);
		opacity: 0;
		pointer-events: none;
		transition: all 0.2s ease-out;
		z-index: 9999;
	}

	.toast.visible {
		opacity: 1;
		transform: translateX(-50%) translateY(0);
	}

	.toast-dot {
		width: 6px;
		height: 6px;
		border-radius: 999px;
		background: #9bffb9;
	}

	.toast-dot.success {
		background: #9bffb9;
	}

	/* ========== 加入购物车动画 ========== */
	.add-animation {
		position: fixed;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		z-index: 10000;
		pointer-events: none;
		animation: addToCart 0.6s ease-out forwards;
	}

	.animation-emoji {
		font-size: 60px;
		filter: drop-shadow(0 8px 16px rgba(44, 94, 48, 0.3));
	}

	@keyframes addToCart {
		0% {
			opacity: 1;
			transform: translate(-50%, -50%) scale(1);
		}

		50% {
			opacity: 0.8;
			transform: translate(100px, -100px) scale(0.5);
		}

		100% {
			opacity: 0;
			transform: translate(200px, -200px) scale(0.1);
		}
	}

	.bottom-space {
		height: 80px;
	}

	/* 滚动条隐藏 */
	::-webkit-scrollbar {
		display: none;
	}









	/* #ifdef H5 */
	/* ================= H5 适配（仅网页端，小程序零影响）=================
	   基准宽度：手机/平板/窄窗口统一 400px 居中；>=769px 放宽到 640px。
	   BASE_W 必须与「本页 .tea-app 的 max-width」一致（脚本 fixTeaAppBase 已统一为 400px），
	   否则底栏会与内容区错位。

	   ⚠️ 为什么底栏规则要放在「所有视口」而不是只放在 >=769px 里：
	   各页 .tea-tabbar 基础 CSS 是 `position: fixed; bottom: 0; width: 100%`，
	   没有 left → 浏览器用「静态位置」（＝ .tea-app 左边缘）当起点。
	   视口 620px 时：left=110（400px 内容区居中的留白）+ width=620 = 右边缘 730，
	   超出视口 110px，第 5 项「我的」被推出屏幕。
	   401~768px 区间原先完全没有约束（640px 限宽只写在 >=769px 里），所以必然溢出。
	   修法：底栏用 left:50% + translateX(-50%) 自居中（不再依赖静态位置），
	        再用 max-width 跟随内容区宽度。
	*/
	@media screen and (min-width: 1px) {
		/* 所有视口：与 .tea-app 的 400px 内容区对齐 */
		.detail-footer { left: 50%; right: auto; transform: translateX(-50%); width: 100%; max-width: 400px; box-sizing: border-box; }
		.toast { max-width: 400px; margin-left: auto; margin-right: auto; }
		.add-animation { max-width: 400px; margin-left: auto; margin-right: auto; }
	}

	@media screen and (min-width: 769px) {
		.tea-app { max-width: 640px; box-shadow: 0 0 40px rgba(44, 94, 48, 0.06); }
		.paper-texture { width: 640px; }
		.detail-footer { max-width: 640px; }
		.toast { max-width: 640px; }
		.add-animation { max-width: 640px; }
	}
	/* #endif */
</style>