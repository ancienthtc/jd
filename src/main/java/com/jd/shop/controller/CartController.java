package com.jd.shop.controller;

import com.alibaba.fastjson.JSONObject;
import com.jd.shop.model.Address;
import com.jd.shop.service.AddressService;
import com.jd.shop.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ThinkPad on 2017/8/8.
 */

//用户拦截器
@Controller
@RequestMapping("/cart")
public class CartController extends BaseController{

    @Autowired
    private CartService cartService;

    @Autowired
    private AddressService addressService;

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
    @RequestMapping("/toCart/{id}")
    public String toCart(@PathVariable Integer id, Model model)//用户id
    {
        List<Map<String,Object>> cartitem=cartService.cartItem(id);
        model.addAttribute("items",cartitem);   //id,name,price,freight,gclass,ciid,amount,user_cart,all,title

        Map<String,Number> cal=cartService.getCal(cartitem);//放入service
        model.addAttribute("cal",cal);
        return "user/shopcart";
    }

    //删除一个
    @RequestMapping("/del")
    @ResponseBody
    public String delCartItem(@RequestBody String json)
    {
        JSONObject date=new JSONObject( JSONObject.parseObject(json)  );
        String cartitemid=date.getString("cartitemid");

        if(cartService.DelCartItem( Integer.parseInt(cartitemid) ) > 0)
        {
            return "true";
        }
        return "false";
    }

    //清空购物车
    @RequestMapping("/delall")
    @ResponseBody
    public String clearCratItem(@RequestBody String json)
    {
        JSONObject date=new JSONObject( JSONObject.parseObject(json)  );
        String uid=date.getString("uid");
        if(cartService.ClearCartItem( Integer.parseInt(uid) ) > 0)
        {
            return "true";
        }
        return "false";
    }

    //进入结算
    @RequestMapping(value = "/tocommit/{json}")
    public String toCommit(Model model,@PathVariable String json)
    {
        JSONObject date=new JSONObject( JSONObject.parseObject(json)  );
        String uid=date.getString("uid");
        //获取收货地址
        List<Address> addresses=addressService.findAddressByUserId( Integer.parseInt(uid) );
        model.addAttribute("addresses",addresses);
        //获取发货价格(API接口)

        return "user/shopcommit";
    }

}
