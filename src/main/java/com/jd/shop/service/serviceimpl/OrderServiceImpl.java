package com.jd.shop.service.serviceimpl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jd.shop.dao.CartItemMapper;
import com.jd.shop.dao.GoodsMapper;
import com.jd.shop.dao.OrderMapper;
import com.jd.shop.model.Goods;
import com.jd.shop.model.Order;
import com.jd.shop.service.OrderService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by ThinkPad on 2017/8/14.
 */
@Service
public class OrderServiceImpl implements OrderService{

    @Resource
    private OrderMapper orderMapper;

    @Resource
    private GoodsMapper goodsMapper;

    @Resource
    private CartItemMapper cartItemMapper;

    @Transactional
    public Map<String,Object> createOrder(String json) {
        Map<String,Object> map=new HashMap<String,Object>();
        Order order=new Order();
        String uuid = UUID.randomUUID().toString();//UUID
        StringBuffer detail=new StringBuffer();//JSON
        //SimpleDateFormat sdf=  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar cc = Calendar.getInstance();//datetime

        //解析json
        JSONObject object = JSON.parseObject(json);
        JSONArray jsonArray = object.getJSONArray("goods");
        List<HashMap> goodslist = JSON.parseArray(jsonArray.toJSONString(), HashMap.class);//ccid,,amount,all,gid,title
        String uid=object.getString("userid");//用户
        String total=object.getString("total");//总价
        String aid=object.getString("aid");

        detail.append("{");detail.append("'Goods':[");
        for(int i=0;i<goodslist.size();i++)
        {
            //1.取得gid，判断商品是否存在
            Integer gid= Integer.parseInt(goodslist.get(i).get("gid").toString() );
            Goods goods=goodsMapper.selectByPrimaryKey(gid);
            if(goods==null)
            {
                map.put("Order",null);
                map.put("Msg","商品不存在!");
                return map;
            }

            //2.取得库存，判断库存量,库存小于数量，返回失败
            Double amount= Double.parseDouble(goodslist.get(i).get("amount").toString() );
            if(amount>goods.getStock())
            {
                map.put("Order",null);
                map.put("Msg","超过库存!");
                return map;
            }

            //3.减去商品库存
            if(goodsMapper.updateStock(amount,gid)<=0)
            {
                map.put("Order",null);
                map.put("Msg","库存减少失败");
                return map;
            }

            //4.移除购物车
            Integer ciid= Integer.parseInt(goodslist.get(i).get("ciid").toString() );
            if(cartItemMapper.deleteByPrimaryKey(ciid) <= 0)
            {
                map.put("Order",null);
                map.put("Msg","购物车移除失败");
                return map;
            }

            //5.生成新的JSON
            detail.append("{");
            detail.append("'goodsid':'"+gid+"',");
            detail.append("'goodsname':'"+goodslist.get(i).get("name")+"',");
            detail.append("'price':'"+goodslist.get(i).get("price")+"',");
            detail.append("'amount':'"+goodslist.get(i).get("amount")+"',");
            detail.append("'title':'"+goodslist.get(i).get("title"));
            detail.append("'},");
        }
        detail.deleteCharAt(detail.length() - 1);//去除,
        detail.append("]");
        detail.append(",'aid':"+aid);
        detail.append("}");//详情完毕
        //6.信息放入Order
        order.setUuid(uuid);//uuid
        order.setOrdertime( cc.getTime() );//下单时间
        order.setShopstatus(0);//发货状态 0-未发货
        order.setPaystatus(0);//付款状态 0-未付款
        //paytime null
        order.setLimit(48);//订单时效：48小时
        order.setAllprice( Double.parseDouble(total) );//总价
        order.setDetail(detail.toString());//商品详情(JSON)
        order.setOrderUser( Integer.parseInt(uid) );//关联用户
        if(orderMapper.insertSelective(order) > 0)
        {
            order.getId();
            map.put("Order",order);
            map.put("Msg","生成成功");
            return map;
        }
        else
        {
            order.getId();
            map.put("Order",order);
            map.put("Msg","生成失败");
            return map;
        }
    }
}
/*
    JSON:
{
    "Goods": [
        {
            "goodsid": 22,
            "goodsname": "xxx",
            "price": 33,
            "amount": 1,
            "title": "cccc"
        },
        {
            "goodsid": 23,
            "goodsname": "sa",
            "price": 22,
            "amount": 2,
            "title": "xxxx"
        }
    ]
}
 */