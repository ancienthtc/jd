package com.jd.shop.dao;

import com.jd.shop.model.Order;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

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

    List<Order> UserAllOrders(@Param("uuid") Integer uid);

    /**
     * 付款
     */
    //验证
    String pay_check(@Param("uuid") String uuid,@Param("uid") Integer uid);

    /**
     * 待付款
     * @param uid
     * @return
     */
    List<Order> getUserOrders(@Param("uid") Integer uid);//用户
    //管理员
    List<Order> getAllOrders();
    List<Order> getPartOrders(@Param("begin")String begin,@Param("end")String end,@Param("uuid")String uuid);//待付款帅选

    /**
     * 待发货
     * @param uid
     * @return
     */
    List<Order> getUserOrders2(@Param("uid") Integer uid);
    //管理员
    List<Order> getAllOrders2();
    List<Order> getPartOrders2(@Param("begin")String begin,@Param("end")String end,@Param("uuid")String uuid);//待发货帅选

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
     * 已完成
     * @param uid
     * @return
     */
    List<Order> getUserOrders5(@Param("uid") Integer uid);

    List<Order> getAllOrders5();//管理员

    /**
     * 超时/取消
     * @param uid
     * @return
     */
    List<Order> OrderCancel(@Param("uid") Integer uid);

    List<Order> getAllOrdersCancel();//管理员

    /**
     * 交易结束
     * @param uid
     * @return
     */
    List<Order> getUserOrders45(@Param("uid") Integer uid);

    /**
     * 统计
     * @return
     */
    //上月
    Map<String,Object> getLastCount();
    //本月
    Map<String,Object> getThisCount();
    //历史
    Map<String,Object> getHistoryCount();

    String getDetail(@Param("uuid")String uuid );

    int UpdateShopS(@Param("status") Integer i,@Param("uuid") String uuid);

    int UpdatePayS(@Param("status") Integer i,@Param("uuid") String uuid);

    //检查订单失效(用户登录)
    List<Order> checkOrderWithUser(@Param("uid") Integer uid);

    //检查所有失效订单(系统检查)
    List<Order> checkOrders();

    int delOrderByUUID(@Param("uuid")String uuid);

    //总查询
    List<Order> QueryOrder(@Param("uuid") String uuid,@Param("begin")String begin,@Param("end")String end,@Param("pay")Integer paystatus,@Param("shop")Integer shopstatus);

    /**
     *  新需求
     */
    //查询用户订单，前N个订单
    List<Order> getOrderByIdLimit(@Param("uid")Integer uid,@Param("count")Integer count);

    //地址删除 查询 未发货订单
    List<Order> getNoSend(@Param("uid")Integer uid);

    //用户所有订单
    List<Order> getAllByUser( @Param("uid") Integer uid );
}