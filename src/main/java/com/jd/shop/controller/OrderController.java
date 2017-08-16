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

//        List<Order> orders= commentList.getDataList();
//        long pageNo=commentList.getPageNo();
//        long pageSize=commentList.getPageSize();
//        long total=commentList.getTotal();
//        long pages=commentList.getPages();
//        List<Map<String,Object>> list=new ArrayList<Map<String, Object>>();
//        for(int i=0;i<orders.size();i++)
//        {
//            Map<String,Object> m=new HashMap<String,Object>();
//            m.put("id",orders.get(i).getId());
//            m.put("uuid",orders.get(i).getUuid());
//            SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//            m.put("ordertime",df.format(orders.get(i).getOrdertime()) );
//            //paystatus
//            if(orders.get(i).getPaystatus()==0)
//            {
//                m.put("paystatus","未付款");
//            }
//            else if(orders.get(i).getPaystatus()==1)
//            {
//                m.put("paystatus","已付款");
//            }
//            else if(orders.get(i).getPaystatus()==2)
//            {
//                m.put("paystatus","取消支付");
//            }
//            //shopstatus
//            if(orders.get(i).getShopstatus()==0)
//            {
//                m.put("shopstatus","未发货");
//            }
//            else if(orders.get(i).getShopstatus()==1)
//            {
//                m.put("shopstatus","已发货");
//            }
//            else if(orders.get(i).getShopstatus()==3)
//            {
//                m.put("shopstatus","待评论");
//            }
//            else if(orders.get(i).getShopstatus()==4)
//            {
//                m.put("shopstatus","已评论");
//            }
//            Date d=new Date( Long.parseLong(orders.get(i).getOrdertime().toString())+ orders.get(i).getLimit()*60*60*1000 );
//            //Date f=new Date( Long.parseLong(df.format(orders.get(i).getOrdertime() ) )+(long) orders.get(i).getLimit()*60*60*1000  );
//            m.put("final",d);
//            m.put("allprice",orders.get(i).getAllprice());
//            list.add(m);
//        }
//        PagedResult<Map<String,Object>> order2=new PagedResult<Map<String, Object>>();
//        order2.setDataList(list);
//        order2.setPageNo(pageNo);
//        order2.setPages(pages);
//        order2.setPageSize(pageSize);
//        order2.setTotal(total);

        String json = JSON.toJSONString(commentList);
        return json;
    }

    //跳转到待付款
    @RequestMapping("/toNoPay")
    public String toNoPay()
    {
        return "user/order_nopay";
    }

}
