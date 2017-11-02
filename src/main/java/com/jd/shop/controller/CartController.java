package com.jd.shop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jd.shop.annotation.UserLogin;
import com.jd.shop.model.Address;
import com.jd.shop.service.AddressService;
import com.jd.shop.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ThinkPad on 2017/8/8.
 */

//用户拦截器
@UserLogin
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
        String tprice=date.getString("tprice");

        String fid=null;
        try{
            fid=date.getString("fid");
        }
        catch (NullPointerException e)
        {
            fid="";
        }

        if(fid==null || fid.length()<=0)
        {
            fid="";
        }

        if(userid==null || goodsid==null)
        {
            return "false";
        }
        if( Integer.parseInt(count)<=0 )
        {
            return "false";
        }
        if( cartService.cartadd( userid  , goodsid  ,count,tprice ,fid  ) >0 )
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
        for(int i=0;i<cartitem.size();i++)
        {
            if(cartitem.get(i).get("fname")==null || cartitem.get(i).get("fname").toString().length()<=0)
            {
                cartitem.get(i).put("fname","默认");
            }
        }
        model.addAttribute("items",cartitem);   //id,name,price,freight,gclass,ciid,amount,fid,fname,user_cart,all,title || fname空为默认

        Map<String,Number> cal=cartService.getCal(cartitem);//放入service
        model.addAttribute("cal",cal);//total count
        //return "user/shopcart";
        return "user/member_cart";
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

    //计算当前价格
    @RequestMapping("/getcal")
    @ResponseBody
    public String calPrice(@RequestBody String a)
    {
        try{
            JSONObject object = JSON.parseObject(a);
            //JSONObject data = (JSONObject) object.get("goods");
            JSONArray jsonArray = object.getJSONArray("goods");

            List<HashMap> goodslist = JSON.parseArray(jsonArray.toJSONString(), HashMap.class);
            Map<String,Object> map=new HashMap<String, Object>();
            Integer goodses=0;
            Double allof=0.0;
            for(int i=0;i<goodslist.size();i++)
            {
                goodses++;
                allof=allof+ Double.valueOf( goodslist.get(i).get("all").toString() );
            }
            map.put("count",goodses);
            map.put("allof",allof);

            //System.out.print(JSON.toJSONString(map, true));
            return JSON.toJSONString(map, true);
        }catch (Exception e)
        {
            return "false";
        }

    }

    //进入结算
    @RequestMapping(value = "/tocommit")

    public String toCommit(String json, Model model , String uid, String total, HttpSession session)
    {
        //解析JSON
        JSONObject object = JSON.parseObject(json);
        //取得JSON中的数组
        JSONArray jsonArray = object.getJSONArray("goods");
        //转换List<Map<>>
        List<HashMap> goodslist = JSON.parseArray(jsonArray.toJSONString(), HashMap.class);
        //title,gid,name,price,amount,gclass,all,ciid   fid , fname
        model.addAttribute("goodslist",goodslist);
        //取得最大运费
        Double freight=cartService.getMaxFreight(goodslist);
        model.addAttribute("freight",freight);//运费
        //取得选中商品总价
        total=object.getString("total");
        model.addAttribute("total",Double.parseDouble(total) );//总价
        //获取收货地址
        uid=object.getString("userid");
        List<Address> addresses=addressService.FirstMainByUser( Integer.parseInt(uid) );//默认地址
        model.addAttribute("addresses",addresses);//收货地址
        //传递JSON

        json=json.substring(0,json.length()-1);
        json+=",'freight':'"+freight+"'}";
        json=json.replaceAll("\'","\"");


        session.setAttribute("info",json);
        model.addAttribute("cart",json);
        //return "user/shopcommit";
        //return "user/shopcommit";
        return "user/member_checkout";
    }

    @RequestMapping("/commit")
    public String toC()
    {
        return "user/shopcommit";
    }

    //获取发货价格(API接口)
//    @RequestMapping(value = "/freight")
//    @ResponseBody
//    public String getFreight(@RequestBody Integer aid,Model model)
//    {
//        model.addAttribute("freight",Double.valueOf( aid%5 ));
//        //return Double.valueOf( aid%5 ) ;//模拟接口
//        //return "user/shopcommit";
//        return Double.valueOf( aid%5 ).toString() ;
//    }

}
