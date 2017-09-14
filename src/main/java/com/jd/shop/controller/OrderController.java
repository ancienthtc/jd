package com.jd.shop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jd.shop.annotation.AdminLogin;
import com.jd.shop.model.Address;
import com.jd.shop.model.Admin;
import com.jd.shop.model.Order;
import com.jd.shop.model.User;
import com.jd.shop.service.AddressService;
import com.jd.shop.service.OrderService;
import com.jd.shop.util.PagedResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by ThinkPad on 2017/8/14.
 */

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private AddressService addressService;

    //订单创建
    @RequestMapping(value = "/create" , produces="text/html;charset=UTF-8;")
    @ResponseBody
    public String createOrder(@RequestBody String date) throws Exception
    {
        Map<String,Object> map=orderService.createOrder(date);

        if(map.get("Order")==null)
        {
            //System.out.print(JSON.toJSON(map));
            //return URLDecoder.decode(map.get("Msg").toString(),"UTF-8");
            return map.get("Msg").toString();
        }

        return "true";
    }

    //订单查询(待付款),分页,用户
    @RequestMapping("/queryNoPay")
    @ResponseBody
    public String queryNoPay(Integer pageNumber, Integer pagesize, HttpSession session)
    {
        User user = (User)session.getAttribute("user");
        if(user==null){
            return "";
        }
        PagedResult<Order> commentList=orderService.queryByPageNoPay(pageNumber,pagesize,user.getId());
        String json = JSON.toJSONString(commentList);
        return json;
    }

    //订单查询(待发货)，分页,用户
    @RequestMapping("/queryNoSend")
    @ResponseBody
    public String queryNoSend(Integer pageNumber, Integer pagesize, HttpSession session)
    {
        User user = (User)session.getAttribute("user");
        if(user==null){
            return "";
        }
        PagedResult<Order> commentList=orderService.queryByPageNoSend(pageNumber,pagesize,user.getId());
        String json = JSON.toJSONString(commentList);
        return json;
    }

    //订单查询(待收货)，分页,用户
    @RequestMapping("/queryNoAccept")
    @ResponseBody
    public String queryNoAccept(Integer pageNumber, Integer pagesize, HttpSession session)
    {
        User user = (User)session.getAttribute("user");
        if(user==null){
            return "";
        }
        PagedResult<Order> commentList=orderService.queryByPageNoAccept(pageNumber,pagesize,user.getId());
        String json = JSON.toJSONString(commentList);
        return json;
    }

    //订单查询(待评价)，分页,用户
    @RequestMapping("/queryNoComment")
    @ResponseBody
    public String queryNoComment(Integer pageNumber, Integer pagesize, HttpSession session)
    {
        User user = (User)session.getAttribute("user");
        if(user==null){
            return "";
        }
        PagedResult<Order> commentList=orderService.queryByPageNoComment(pageNumber,pagesize,user.getId());
        String json = JSON.toJSONString(commentList);
        return json;
    }

    //订单查询(已完成)，分页，用户


    //订单查询(超时取消)，分页，用户
    @RequestMapping("/queryOutTime")
    @ResponseBody
    public String queryOutTime(Integer pageNumber, Integer pagesize, HttpSession session)
    {
        User user = (User)session.getAttribute("user");
        if(user==null){
            return "";
        }
        PagedResult<Order> commentList=orderService.queryByPageOutTime(pageNumber,pagesize,user.getId());
        String json = JSON.toJSONString(commentList);
        return json;
    }



    //跳转到待付款,跳转检查订单过时
    @RequestMapping("/toNoPay")
    public String toNoPay(HttpSession session)
    {
        User user = (User)session.getAttribute("user");
        if(user==null){
            return "";
        }
        List<Order> orders=orderService.checkOrder(user.getId());//超时订单
        if(orders!=null)
        {
            for(Order o:orders)
            {
                orderService.cancelOrder(o.getUuid());
            }
        }

        return "user/order_nopay";
    }

    //跳转到待发货
    @RequestMapping("toNoSend")
    public String toNoSend()
    {
        return "user/order_nosend";
    }

    //跳转到待收货
    @RequestMapping("/toNoAccept")
    public String toNoAccept()
    {
        return "user/order_noaccept";
    }

    //跳转到待评价
    @RequestMapping("/toNoComment")
    public String toNoComment()
    {
        return "user/order_nocomment";
    }

    //待评价-详情到待评价-评论
    @RequestMapping("/detailComment")
    public String detailTOcomment()
    {
        return "user/order_nocomment_comment";
    }

    //跳转到完成的订单(未做)
    @RequestMapping("/toFinish")
    public String toFinish()
    {

        return "";
    }

    //跳转到取消的订单
    @RequestMapping("/toOutTime")
    public String toOutTime()
    {
        return "user/order_outtime";
    }

    //付款界面(未做)
    @RequestMapping("/topay")
    public String topay()
    {

        return "";
    }

    //付款(未做)
    @RequestMapping(value = "/pay" , method = RequestMethod.POST)
    @ResponseBody
    public String pay()
    {
        return "";
    }

    //收货
    @RequestMapping("/accept")
    public String accept(String json)
    {
        //更新订单信息
        Order order=orderService.getOrder(json);
        orderService.updateShopS(json,2);

        return "user/order_noaccept";
    }

    //通过uuid获取详情
    @RequestMapping("/getDetail")
    //@ResponseBody
    public String getDetail(String json, Model model)
    {
        //JSONObject date=new JSONObject( JSONObject.parseObject(json)  );
        //String uuid=date.getString("uuid");
        String detail=orderService.getDetail(json).replaceAll("'", "\"");

        //获取的信息做转换
        //重组json
        JSONObject object = JSON.parseObject(detail);
        JSONArray jsonArray = object.getJSONArray("Goods");

        List<HashMap> goodslist = JSON.parseArray(jsonArray.toJSONString(), HashMap.class);
        //System.out.print(goodslist);
        String aid=object.getString("aid");
        Address address=addressService.findById( Integer.valueOf(aid) );
        object.remove("aid");
        object.put("Address",address);
        //System.out.print(object);

        String logistics=object.getString("log");
        model.addAttribute("logistics",logistics);

        model.addAttribute("info",goodslist);
        model.addAttribute("address",address);

        //return object.toJSONString();
        return "user/order_nopay_detail";
    }

    //待收货中获取物流信息
    @RequestMapping("/getLogistics")
    public String getLogistics(String json, Model model)
    {
        //根据uuid，取出order.detail中的物流信息
        String detail=orderService.getDetail(json).replaceAll("'", "\"");
        //获取的信息做转换
        //重组json
        JSONObject object = JSON.parseObject(detail);
        JSONArray jsonArray = object.getJSONArray("Goods");

        List<HashMap> goodslist = JSON.parseArray(jsonArray.toJSONString(), HashMap.class);
        String aid=object.getString("aid");
        Address address=addressService.findById( Integer.valueOf(aid) );
        object.remove("aid");
        object.put("Address",address);
        //物流
        String logistics=object.getString("log");
        model.addAttribute("logistics",logistics);

        model.addAttribute("info",goodslist);
        model.addAttribute("address",address);

        return "user/order_noaccept_detail";
    }


    //待评价中获取详情页面(有评论)   改!
    @RequestMapping("/getComment")
    public String getComment(String json,Model model)//json=uuid
    {
        String detail=orderService.getDetail(json).replaceAll("'", "\"");
        JSONObject object = JSON.parseObject(detail);
        JSONArray jsonArray = object.getJSONArray("Goods");
        List<HashMap> goodslist = JSON.parseArray(jsonArray.toJSONString(), HashMap.class);

        //改造goodlist，有评价的商品添加标识 改!
        for(int i=0;i<goodslist.size();i++)
        {
            goodslist.get(i).put("isComment","false");
        }

        model.addAttribute("info",goodslist);

        return "user/order_nocomment_detail";
    }


    //评论商品(未做)


    //取消的订单删除
    @RequestMapping("/OrderDel")
    @ResponseBody
    public String OrderDel(String uuid)
    {
        if(orderService.orderDel(uuid) > 0)
        {
            return "true";
        }
        return "false";
    }

    /*  *                           管理员
    *
    *   **********************************************************************
    *
    *   */

    //跳转
    //order1:等待支付
    @AdminLogin
    @RequestMapping("/toListPay")
    public String toListPay()
    {
        orderService.CheckOrderToCancel();//检查失效订单
        return "admin/orderlist_pay";
    }

    //order2:待发货/填写发货物流
    @AdminLogin
    @RequestMapping("/toListLog")
    public String toListLog()
    {
        return "admin/orderlist_log";
    }

    //填写物流
    @AdminLogin
    @RequestMapping("/toFillLog")
    public String toFillLog(String id,Model model)
    {
        if(id==null){
            throw new RuntimeException("参数不合法");
        }
        //查询订单
        Order order=orderService.getOrder(id);
        model.addAttribute("order",order);
        return "admin/orderlist_log_fill";
    }

    //order3:待收货/修改发货物流
    @AdminLogin
    @RequestMapping("/toListSend")
    public String toListSend()
    {
        return "admin/orderlist_send";
    }

    //进入修改物流
    @AdminLogin
    @RequestMapping("/toAlterLog")
    public String toAlterLog(String id,Model model)
    {
        if(id==null){
            throw new RuntimeException("参数不合法");
        }
        //查询订单
        Order order=orderService.getOrder(id);
        model.addAttribute("order",order);
        JSONObject object = JSON.parseObject(order.getDetail());
        String log=object.getString("log");
        model.addAttribute("log",log);

        return "admin/orderlist_send_alter";
    }

    //order4:待评价
    @AdminLogin
    @RequestMapping("/toListComment")
    public String toListComment()
    {
        return "admin/orderlist_comment";
    }

    //填写log并保存，更新订单
    @AdminLogin
    @RequestMapping("/FillLog")
    //@ResponseBody
    public String FillLog(@RequestBody String json)
    {
        //System.out.print(id+"/"+log);
        JSONObject date=new JSONObject( JSONObject.parseObject(json)  );
        String uuid=date.getString("id");
        String info=date.getString("log");
        //获取id和运单
        Order order=orderService.getOrder(uuid);
        String detail=order.getDetail();
        //解析detail
        JSONObject date2=new JSONObject( JSONObject.parseObject(detail));
        //放入键 log
        date2.put("log",info);
        //更新detail
        orderService.Send(uuid,date2.toString());

        return "admin/orderlist_log";
    }

    //修改log并保存，不更新订单
    @AdminLogin
    @RequestMapping("/AlterLog")
    //@ResponseBody
    public String AlterLog(@RequestBody String json)
    {
        //System.out.print(id+"/"+log);
        JSONObject date=new JSONObject( JSONObject.parseObject(json)  );
        String uuid=date.getString("id");
        String info=date.getString("log");
        //获取id和运单
        Order order=orderService.getOrder(uuid);
        String detail=order.getDetail();
        //解析detail
        JSONObject date2=new JSONObject( JSONObject.parseObject(detail));
        //修改键 log
        date2.put("log",info);
        System.out.print(date2);
        //更新detail
        orderService.updateDetail(uuid,date2.toString());

        return "admin/orderlist_send";
    }

    //order5:已完成(未做)
    //@AdminLogin

    //order6:已取消
    @AdminLogin
    @RequestMapping("/toOrderCancel")
    public String toOrderCancel()
    {
        orderService.CheckOrderToCancel();//检查失效订单
        return "admin/orderlist_cancel";
    }

    //order7:统计
    @AdminLogin
    @RequestMapping("/toOrderAll")
    public String toOrderAll(Model model)
    {
        orderService.CheckOrderToCancel();//检查失效订单
        //统计结果
        model.addAttribute("info",orderService.getCount());

        return "admin/orderlist_all";
    }

    //获取高级查询
    @AdminLogin
    @RequestMapping("/getQuery")
    @ResponseBody
    public String getQuery(@RequestBody String date)
    {
        //System.out.print(date);
        JSONObject object = JSON.parseObject(date);
        String uuid=object.getString("uuid");
        String strtus=object.getString("strtus");
        String begin=object.getString("begin");
        String end=object.getString("end");
        Integer paystatus=0;
        Integer shopstatus=0;
        List<Order> orderList=new ArrayList<Order>();
        switch (Integer.parseInt(strtus))
        {
            case 1://待付款
                paystatus=0;
                shopstatus=0;
                break;
            case 2://待发货
                paystatus=1;
                shopstatus=0;
                break;
            case 3://待收货
                paystatus=1;
                shopstatus=1;
                break;
            case 4://待评价
                paystatus=1;
                shopstatus=2;
                break;
            case 5://已完成
                paystatus=1;
                shopstatus=3;
                break;
            case 6://已取消
                paystatus=2;
                shopstatus=0;
                break;
        }
        orderService.CheckOrderToCancel();//检查失效订单
        String json=JSON.toJSONString (orderList=orderService.HighQuery(uuid,begin,end,paystatus,shopstatus) );
        return json;
    }

    //获取所有未支付订单
    @AdminLogin
    @RequestMapping("/getNoPay")
    @ResponseBody
    public String getNoPay(Integer pageNumber, Integer pagesize, HttpSession session)
    {
        Admin a = (Admin) session.getAttribute("admin");
        if(a==null){
            return "";
        }

        orderService.CheckOrderToCancel();//检查失效订单

        PagedResult<Order> commentList=orderService.getByPageNoPay(pageNumber,pagesize);
        String json = JSON.toJSONString(commentList);
        return json;
    }

    //获取所有待发货商品
    @AdminLogin
    @RequestMapping("/getNoSend")
    @ResponseBody
    public String getNoSend(Integer pageNumber, Integer pagesize, HttpSession session)
    {
        Admin a = (Admin) session.getAttribute("admin");
        if(a==null){
            return "";
        }

        PagedResult<Order> commentList=orderService.getByPageNoSend(pageNumber,pagesize);
        String json = JSON.toJSONString(commentList);
        return json;
    }

    //获取所有已发货/待收货订单
    @AdminLogin
    @RequestMapping("/getNoAccept")
    @ResponseBody
    public String getNoAccept(Integer pageNumber, Integer pagesize, HttpSession session)
    {
        Admin a = (Admin) session.getAttribute("admin");
        if(a==null){
            return "";
        }

        PagedResult<Order> commentList=orderService.getByPageNoAccept(pageNumber,pagesize);
        String json = JSON.toJSONString(commentList);
        return json;
    }

    //获取所有未评价订单
    @AdminLogin
    @RequestMapping("/getNoComment")
    @ResponseBody
    public String getNoComment(Integer pageNumber, Integer pagesize, HttpSession session)
    {
        Admin a = (Admin) session.getAttribute("admin");
        if(a==null){
            return "";
        }

        PagedResult<Order> commentList=orderService.getByPageNoComment(pageNumber,pagesize);
        String json = JSON.toJSONString(commentList);
        return json;
    }

    //获取所有已完成订单
    //@AdminLogin

    //获取所有取消的订单
    @AdminLogin
    @RequestMapping("/getCancel")
    @ResponseBody
    public String getCancel(Integer pageNumber, Integer pagesize, HttpSession session)
    {
        Admin a = (Admin) session.getAttribute("admin");
        if(a==null){
            return "";
        }

        orderService.CheckOrderToCancel();//检查失效订单

        PagedResult<Order> commentList=orderService.getByPageCancel(pageNumber,pagesize);
        String json = JSON.toJSONString(commentList);
        return json;
    }

}
