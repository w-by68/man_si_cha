package com.guchen.mapper;

import com.guchen.pojo.ProductSpec;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

/**
* @author Administrator
* @description 针对表【product_spec(商品规格表)】的数据库操作Mapper
* @createDate 2026-03-10 23:07:56
* @Entity com.guchen.pojo.ProductSpec
*/
public interface ProductSpecMapper extends BaseMapper<ProductSpec> {

    /**
     * 条件扣减库存（原子）。
     *
     * 【2026-10-23 新增】原项目全仓没有任何库存扣减代码（grep setStock = 0），
     * 下单链路只校验不扣减 —— 库存永远不减，等于可以无限超卖。
     * 这里用「stock >= qty 才更新」的单条 SQL 做原子扣减：
     * 并发下由数据库行锁 + 条件保证不会扣成负数，返回受影响行数，
     * 调用方据此判断是否扣减成功（0 = 库存不足或被并发抢完）。
     */
    @Update("UPDATE product_spec SET stock = stock - #{qty} "
            + "WHERE id = #{specId} AND stock >= #{qty}")
    int deductStock(@Param("specId") Long specId, @Param("qty") int qty);

    /**
     * 回补库存（补偿）。
     *
     * 下单主流程失败时必须把已扣的库存加回去，否则会「扣了库存却没生成订单」。
     */
    @Update("UPDATE product_spec SET stock = stock + #{qty} WHERE id = #{specId}")
    int restoreStock(@Param("specId") Long specId, @Param("qty") int qty);
}




