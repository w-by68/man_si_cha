package com.guchen.service;

import com.guchen.pojo.Product;
import com.baomidou.mybatisplus.extension.service.IService;
import com.guchen.utils.Result;

/**
* @author Administrator
* @description 针对表【product(商品表)】的数据库操作Service
* @createDate 2026-03-11 10:27:27
*/
public interface ProductService extends IService<Product> {
    Result selectShopSpecList();

    /**
     * 扣减规格库存（原子）。
     *
     * @return 成功时 data.affected = 1；库存不足时 affected = 0 且 ok = false
     */
    Result deductStock(Long specId, Integer qty);

    /** 回补规格库存（下单失败时的补偿动作）。 */
    Result restoreStock(Long specId, Integer qty);
}
