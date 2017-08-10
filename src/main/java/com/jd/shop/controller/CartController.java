package com.jd.shop.controller;

import com.alibaba.fastjson.JSONObject;
import com.jd.shop.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
        Map<String,Number> cal=new HashMap<String, Number>();
        Double total=0.0;
        int count=0;
        //结算

        for (int i = 0; i < cartitem.size(); i++) {
            if (cartitem.get(i).get("id") != null) {
                count++;
            }
            if (cartitem.get(i).get("all") != null) {
                try {
                System.out.print(cartitem.get(i).get("all"));
                total = total + Double.parseDouble( cartitem.get(i).get("all").toString() );
                }catch (ClassCastException e)
                {
                }
            }
        }

        cal.put("total",total);
        cal.put("count",count);
        model.addAttribute("cal",cal);
        return "user/shopcart";
    }

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

}
