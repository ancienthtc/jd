package com.jd.shop.service;


import com.jd.shop.model.Order;
import com.jd.shop.util.PagedResult;

import java.util.List;
import java.util.Map;

/**
 * Created by ThinkPad on 2017/7/18.
 */
public interface OrderService {

    Map<String,Object> createOrder(String json);

    //List<Map<String,Object>> user_orders(Integer uid);

    PagedResult<Order> queryByPageNoPay(Integer pageNo, Integer pageSize, Integer userId);
}
