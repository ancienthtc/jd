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

    int cancelOrder(String uuid);//订单取消

    List<Order> checkOrder(Integer userid);//用户订单失效列表

    List<Order> checkAllOrders();

    //List<Map<String,Object>> user_orders(Integer uid);

    //用户
    PagedResult<Order> queryByPageNoPay(Integer pageNo, Integer pageSize, Integer userId);

    PagedResult<Order> queryByPageNoSend(Integer pageNo, Integer pageSize, Integer userId);

    PagedResult<Order> queryByPageNoAccept(Integer pageNo, Integer pageSize, Integer userId);

    PagedResult<Order> queryByPageNoComment(Integer pageNo, Integer pageSize, Integer userId);

    PagedResult<Order> queryByPageOutTime(Integer pageNo, Integer pageSize, Integer userId);

    //管理员
    PagedResult<Order> getByPageNoPay(Integer pageNo, Integer pageSize);

    PagedResult<Order> getByPageNoSend(Integer pageNo, Integer pageSize);

    PagedResult<Order> getByPageNoAccept(Integer pageNo, Integer pageSize);

    PagedResult<Order> getByPageNoComment(Integer pageNo, Integer pageSize);


    PagedResult<Order> getByPageCancel(Integer pageNo, Integer pageSize);

    Order getOrder(String uuid);

    String getDetail(String uuid);

    int Send(String uuid,String detail);

    int updateDetail(String uuid,String detail);

    int updateShopS(String uuid,Integer i);

    int updatePayS(String uuid,Integer i);

    int orderDel(String uuid);
}
