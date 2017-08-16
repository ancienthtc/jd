package com.jd.shop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jd.shop.model.Order;
import com.jd.shop.model.User;
import com.jd.shop.service.OrderService;
import com.jd.shop.util.PagedResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
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

    //订单创建
    @RequestMapping("/create")
    @ResponseBody
    public String createOrder(@RequestBody String dates)
    {
        //JSONObject params=new JSONObject( JSONObject.parseObject(dates)  );
        //String json=params.getString("json").toString();
        //JSONArray jsonArray = params.getJSONArray("json");


        //Double all=Double.parseDouble(params.getString("all"));
        //Integer aid= Integer.parseInt(params.getString("aid"));
        Map<String,Object> map=orderService.createOrder(dates);

        if(map.get("Order")==null)
        {
            return map.get("Msg").toString();
        }

        return "true";
    }

    //订单查询(待付款),分页
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

    //跳转到待付款
    @RequestMapping("/toNoPay")
    public String toNoPay()
    {
        return "user/order_nopay";
    }

    //付款界面
    @RequestMapping("/topay")
    public String topay()
    {
        return "";
    }

    //通过uuid获取详情
    @RequestMapping("/getDetail")
    @ResponseBody
    public String getDetail(String json)
    {
        //JSONObject date=new JSONObject( JSONObject.parseObject(json)  );
        //String uuid=date.getString("uuid");
        String s=orderService.getDetail(json).replaceAll("'", "\"");
        return s;
    }

}
