package com.jd.shop.service;

import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ThinkPad on 2017/8/8.
 */
public interface CartService {

    int cartadd(String userid,String goodsid,String count ,String tprice,String fid);

    List<Map<String,Object>> cartItem(Integer uid);

    int DelCartItem(Integer ciid);

    int ClearCartItem(Integer uid);

    /**
     * 返回Total(Double)总价 和 Count(Integer)数量
     * @param cartitem
     * @return
     */
    Map<String,Number> getCal(List<Map<String,Object>> cartitem);

    Double getMaxFreight(List<HashMap> goodses);
}
