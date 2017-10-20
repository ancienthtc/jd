package com.jd.shop.service;

import com.alibaba.fastjson.JSONObject;
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

    int goodsDel(Integer goodsid,String ServerPath);

    List<Image> getGoodsImgs(Integer piclist);

    List<Goods> getAllGoods();//可改分页

    List<Goods> search(String key);

    /**
     * 以下新需求
     */
    List<Goods> new_goods(int index,int end);

    List<Goods> GoodSale();

    Goods getGoodsInfo(Integer goodsid);

    PagedResult<Goods> goodsByPage(Integer pageNo, Integer pageSize,String[] key);

    PagedResult<Goods> goodsByPageSelect(JSONObject object);
}
