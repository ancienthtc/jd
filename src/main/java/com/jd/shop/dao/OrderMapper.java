package com.jd.shop.dao;

import com.jd.shop.model.Order;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Order record);

    int insertSelective(Order record);

    Order selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);

    //new
    Order selectByUUID(@Param("uuid") String uuid);

    int updateDetailByUUID(@Param("uuid") String uuid,@Param("detail") String detail);
    /**
     * 待付款
     * @param uid
     * @return
     */
    List<Order> getUserOrders(@Param("uid") Integer uid);//用户

    List<Order> getAllOrders();//管理员

    /**
     * 待发货
     * @param uid
     * @return
     */
    List<Order> getUserOrders2(@Param("uid") Integer uid);

    List<Order> getAllOrders2();//管理员

    /**
     * 待收货
     * @param uid
     * @return
     */
    List<Order> getUserOrders3(@Param("uid") Integer uid);

    List<Order> getAllOrders3();//管理员

    /**
     * 待评价
     * @param uid
     * @return
     */
    List<Order> getUserOrders4(@Param("uid") Integer uid);

    List<Order> getAllOrders4();//管理员



    /**
     * 超时/取消
     * @param uid
     * @return
     */
    List<Order> OrderCancel(@Param("uid") Integer uid);

    List<Order> getAllOrdersCancel();//管理员


    String getDetail(@Param("uuid")String uuid );

    int UpdateShopS(@Param("status") Integer i,@Param("uuid") String uuid);

    int UpdatePayS(@Param("status") Integer i,@Param("uuid") String uuid);

    //检查订单失效(用户登录)
    List<Order> checkOrderWithUser(@Param("uid") Integer uid);

    //检查所有失效订单(系统检查)
    List<Order> checkOrders();

    int delOrderByUUID(@Param("uuid")String uuid);
}