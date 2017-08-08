package com.jd.shop.service;

import com.jd.shop.model.Goods;
import com.jd.shop.model.Image;
import com.jd.shop.util.PagedResult;

import java.util.List;

/**
 * Created by ThinkPad on 2017/7/7.
 */
public interface GoodsService {

    List<Goods> getAll();

    List<Image> getGoodsPic(int goodsid);

    Goods addGoods(Goods goods);

    Goods getGoods(int goodsid);

    int goodsLoad(Goods goods);

    int goodsAlter(Goods goods);

    int goodsunder(int goodsid);

    PagedResult<Goods> queryByPage(Integer pageNo, Integer pageSize);

    int goodsDel(Integer goodsid);

    List<Image> getGoodsImgs(Integer piclist);
}
