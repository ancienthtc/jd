package com.jd.shop.service;


import java.util.Map;

/**
 * Created by ThinkPad on 2017/7/18.
 */
public interface OrderService {

    Map<String,Object> createOrder(String json);
}
