package com.jd.shop.service;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by ThinkPad on 2017/8/8.
 */
public interface CartService {

    int cartadd(Integer userid,Integer goodsid,Double count);

    List<Map<String,Object>> cartItem(Integer uid);

    int DelCartItem(Integer ciid);

    int ClearCartItem(Integer uid);
}
