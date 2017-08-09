package com.jd.shop.controller;

import com.alibaba.fastjson.JSONObject;
import com.jd.shop.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by ThinkPad on 2017/8/8.
 */

//用户拦截器
@Controller
@RequestMapping("/cart")
public class CartController extends BaseController{

    @Autowired
    private CartService cartService;

    //购物车添加
    @RequestMapping("/add")
    @ResponseBody
    public String addCart(@RequestBody String json /*,Integer count, Integer userid, Integer goodsid*/)
    {
        JSONObject date=new JSONObject( JSONObject.parseObject(json)  );
        String count=date.getString("count");
        String userid=date.getString("userid");
        String goodsid=date.getString("goodsid");

        if(userid==null || goodsid==null)
        {
            return "false";
        }
        if( Integer.parseInt(count)<=0 )
        {
            return "false";
        }
        if( cartService.cartadd( Integer.parseInt(userid)  , Integer.parseInt(goodsid)  ,Double.parseDouble(count) ) >0 )
        {
            return "true";
        }
        else
        {
            return "false";
        }

    }

    //购物车界面
    @RequestMapping("/toCart")
    public String toCart(Integer id)//用户id
    {

        return "user/shopcart";
    }

}
