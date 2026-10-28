package com.guchen.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.guchen.mapper.ProductSpecMapper;
import com.guchen.pojo.Product;
import com.guchen.service.ProductService;
import com.guchen.mapper.ProductMapper;
import com.guchen.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author Administrator
* @description 针对表【product(商品表)】的数据库操作Service实现
* @createDate 2026-03-11 10:27:27
*/
@Service
public class ProductServiceImpl extends ServiceImpl<ProductMapper, Product>
    implements ProductService{

    @Autowired
    ProductMapper productMapper;

    @Autowired
    ProductSpecMapper productSpecMapper;

    @Override
    public Result selectShopSpecList() {
        LambdaQueryWrapper<Product> wrapper = new LambdaQueryWrapper<>();
        List<Product> ShopSpecList = productMapper.selectList(wrapper);
        Result result = Result.ok("获取所有的商品");
        result.put("ShopSpecList", ShopSpecList);
        return result;
    }

    /**
     * 【2026-10-23 新增】扣减库存。
     * 单条条件 UPDATE 即完成「校验 + 扣减」，由数据库保证原子性，
     * 不需要先 select 再 update（那才是超卖的根源）。
     */
    @Override
    @org.springframework.transaction.annotation.Transactional(rollbackFor = Exception.class)
    public Result deductStock(Long specId, Integer qty) {
        if (specId == null || qty == null || qty <= 0) {
            return Result.error("参数不合法：specId 与 qty(>0) 必填");
        }
        int affected = productSpecMapper.deductStock(specId, qty);
        if (affected <= 0) {
            Result r = Result.error("库存不足");
            r.put("affected", 0);
            return r;
        }
        Result r = Result.ok("库存扣减成功");
        r.put("affected", affected);
        r.put("specId", specId);
        return r;
    }

    @Override
    @org.springframework.transaction.annotation.Transactional(rollbackFor = Exception.class)
    public Result restoreStock(Long specId, Integer qty) {
        if (specId == null || qty == null || qty <= 0) {
            return Result.error("参数不合法：specId 与 qty(>0) 必填");
        }
        int affected = productSpecMapper.restoreStock(specId, qty);
        Result r = Result.ok("库存已回补");
        r.put("affected", affected);
        return r;
    }
}




