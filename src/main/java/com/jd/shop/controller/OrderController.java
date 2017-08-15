package com.jd.shop.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jd.shop.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * Created by ThinkPad on 2017/8/14.
 */

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

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

}
