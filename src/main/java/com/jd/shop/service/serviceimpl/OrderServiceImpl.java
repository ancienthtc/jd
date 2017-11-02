package com.jd.shop.service.serviceimpl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.jd.shop.dao.CartItemMapper;
import com.jd.shop.dao.FormatMapper;
import com.jd.shop.dao.GoodsMapper;
import com.jd.shop.dao.OrderMapper;
import com.jd.shop.model.Format;
import com.jd.shop.model.Goods;
import com.jd.shop.model.Order;
import com.jd.shop.service.GoodsService;
import com.jd.shop.service.OrderService;
import com.jd.shop.util.BeanUtil;
import com.jd.shop.util.PagedResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by ThinkPad on 2017/8/14.
 */
@Service
public class OrderServiceImpl implements OrderService{

    @Autowired
    private GoodsService goodsService;

    @Resource
    private OrderMapper orderMapper;

    @Resource
    private GoodsMapper goodsMapper;

    @Resource
    private CartItemMapper cartItemMapper;

    @Resource
    private FormatMapper formatMapper;

    //订单统计 全局变量
    public final static int LAST_TYPE=-1;
    public final static int THIS_TYPE=0;
    public final static int HISTORY_TYPE=1;
    public final static int GROW_TYPE=2;

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
        String total=object.getString("total");//商品总价
        String freight=object.getString("freight");//运费



        Double final_price=Double.parseDouble(total)+Double.parseDouble(freight);//最终价格
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

            //判断规格参数，默认/自定义
            //规格参数
            String fid=  goodslist.get(i).get("fid").toString()  ;
            String fname= goodslist.get(i).get("fname").toString();

            /*  */
            if(fid.length()>0 && !fid.equalsIgnoreCase("null") )   // 运算规格
            {
                //获取规格
                Format format=formatMapper.selectByPrimaryKey( Integer.parseInt(fid) );
                //取得购买数量
                Double amount= Double.parseDouble(goodslist.get(i).get("amount").toString() );

                //2.取得库存，判断库存量,库存小于数量，返回失败
                if(amount-format.getFstock() >= 0 || format.getFstock() <= 0 )
                {
                    map.put("Order",null);
                    map.put("Msg",goods.getName()+"超过库存!");
                    return map;
                }
                //3.减去商品库存
                double left=format.getFstock()-amount;
                if( formatMapper.updateStock(left,gid) <= 0)
                {
                    map.put("Order",null);
                    map.put("Msg","库存减少失败");
                    return map;
                }
                //规格无库存不下架
                //4.加上销售量
                if( formatMapper.updateSales(format.getFsale()+amount , gid) <= 0 )
                {
                    map.put("Order",null);
                    map.put("Msg","销量增加失败");
                    return map;
                }


            }
            else if(fid.length()<=0 || fid.equalsIgnoreCase("null")  )   // 运算普通
            {
                //2.取得库存，判断库存量,库存小于数量，返回失败
                Double amount= Double.parseDouble(goodslist.get(i).get("amount").toString() );
                if(amount-goods.getStock() >= 0 || goods.getStock()<=0 )
                {
                    map.put("Order",null);
                    map.put("Msg",goods.getName()+"超过库存!");
                    return map;
                }

                //3.减去商品库存 如果为0 就下架
                double left=goods.getStock()-amount;
                if(goodsMapper.updateStock(left , gid)<=0)
                {
                    map.put("Order",null);
                    map.put("Msg","库存减少失败");
                    return map;
                }
                if(left==0.0)
                {
                    goodsService.goodsunder(goods.getId());
                }

                //4.加上销售量
                if(goodsMapper.updateSales(goods.getSales()+amount , gid)<=0)
                {
                    map.put("Order",null);
                    map.put("Msg","销量增加失败");
                    return map;
                }

            }

            /*  */

            //5.移除购物车(如果有ciid)
            if( goodslist.get(i).get("ciid")!=null)
            {
                Integer ciid = Integer.parseInt(goodslist.get(i).get("ciid").toString());
                if (cartItemMapper.deleteByPrimaryKey(ciid) <= 0) {
                    map.put("Order", null);
                    map.put("Msg", "购物车不存在"+goods.getName()+"!");
                    return map;
                }
            }

            //6.生成新的JSON
            detail.append("{");
            detail.append("'goodsid':'"+gid+"',");
            detail.append("'goodsname':'"+goodslist.get(i).get("name")+"',");
            detail.append("'price':'"+goodslist.get(i).get("price")+"',");
            detail.append("'amount':'"+goodslist.get(i).get("amount")+"',");
            detail.append("'title':'"+goodslist.get(i).get("title")+"',");
            detail.append("'fid':'"+goodslist.get(i).get("fid")+"',");
            detail.append("'fname':'"+goodslist.get(i).get("fname")+"'");
            //detail.append("'freight':'"+ Double.valueOf(freight) );
            detail.append("},");
        }
        detail.deleteCharAt(detail.length() - 1);//去除,
        detail.append("]");
        detail.append(",'aid':"+aid);
        detail.append(",'freight':"+ Double.valueOf(freight) );
        detail.append("}");//详情完毕
        //7.信息放入Order
        order.setUuid(uuid);//uuid
        order.setOrdertime( cc.getTime() );//下单时间
        order.setShopstatus(0);//发货状态 0-未发货
        order.setPaystatus(0);//付款状态 0-未付款
        //paytime null
        order.setLimit(48);//订单时效：48小时
        order.setAllprice( final_price );//总价
        order.setDetail( detail.toString().replaceAll("\'","\"") );//商品详情(JSON)
        order.setOrderUser( Integer.parseInt(uid) );//关联用户
        if(orderMapper.insertSelective(order) > 0)
        {
            //order.getId();
            map.put("Order",order);
            map.put("id",order.getId());
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

    @Override
    public boolean CheckInfo(String session_json, String ajax_json) {
        JSONObject o1 = JSON.parseObject(session_json);
        JSONObject o2 = JSON.parseObject(ajax_json);
        o2.remove("aid");
        if(o1.toJSONString().equals(o2.toJSONString()))
        {
            return true;
        }
        return false;

    }

    @Override
    public String getUUID(Integer id) {
        return orderMapper.selectByPrimaryKey(id).getUuid();
    }

    @Override
    @Transactional
    public boolean Pay(Integer uid, String uuid) {
        String s=orderMapper.pay_check(uuid,uid) ;
        if( s.equals("0") )
        {
            if( orderMapper.UpdatePayS(1,uuid) > 0 )
            {
                return true;
            }
            else
            {
                return false;
            }

        }
        else
        {
            return false;
        }

    }

    public List<Order> user_orders(Integer uid) {
        return orderMapper.getUserOrders(uid);
    }

    //分页
    public PagedResult<Order> queryByPageNoPay(Integer pageNo, Integer pageSize, Integer userId) {
        pageNo = pageNo == null ? 1 : pageNo;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNo, pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。
        List<Order> orders=orderMapper.getUserOrders(userId);
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        for (int i=0;i<orders.size();i++)
//        {
//            //orders.get(i).getOrdertime()
//            orders.get(i).setOrdertime( df.format(orders.get(i).getOrdertime() ) );
//        }
        for(int i=0;i<orders.size();i++)
        {
            orders.get(i).setOrdertime2(df.format(orders.get(i).getOrdertime()));
            Date date=orders.get(i).getOrdertime();
            //orders.get(i).setOrdertime2(df.format(date));
            Long tim=Timestamp.valueOf(df.format(date)).getTime();
            Long lim=(long)orders.get(i).getLimit()* 60 * 60 * 1000;
            date=new Date(tim+lim);
            orders.get(i).setLimit2(df.format(date));
            //orders.get(i).setOrdertime2(df.format(date));
        }
        return BeanUtil.toPagedResult(orders);
    }

    @Override
    public PagedResult<Order> queryByPageNoSend(Integer pageNo, Integer pageSize, Integer userId) {
        pageNo = pageNo == null ? 1 : pageNo;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNo, pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。
        List<Order> orders=orderMapper.getUserOrders2(userId);
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for(int i=0;i<orders.size();i++)
        {
            orders.get(i).setOrdertime2(df.format(orders.get(i).getOrdertime()));
        }

        return BeanUtil.toPagedResult(orders);
    }

    @Override
    public PagedResult<Order> queryByPageNoAccept(Integer pageNo, Integer pageSize, Integer userId) {
        pageNo = pageNo == null ? 1 : pageNo;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNo, pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。
        List<Order> orders=orderMapper.getUserOrders3(userId);
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for(int i=0;i<orders.size();i++)
        {
            orders.get(i).setOrdertime2(df.format(orders.get(i).getOrdertime()));
        }
        return BeanUtil.toPagedResult(orders);
    }

    @Override
    public PagedResult<Order> queryByPageNoComment(Integer pageNo, Integer pageSize, Integer userId) {
        pageNo = pageNo == null ? 1 : pageNo;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNo, pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。
        List<Order> orders=orderMapper.getUserOrders4(userId);
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for(int i=0;i<orders.size();i++)
        {
            orders.get(i).setOrdertime2(df.format(orders.get(i).getOrdertime()));
        }
        return BeanUtil.toPagedResult(orders);
    }

    @Override
    public PagedResult<Order> queryByPageOutTime(Integer pageNo, Integer pageSize, Integer userId) {
        pageNo = pageNo == null ? 1 : pageNo;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNo, pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。
        List<Order> orders=orderMapper.OrderCancel(userId);
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        for(int i=0;i<orders.size();i++)
        {
            orders.get(i).setOrdertime2(df.format(orders.get(i).getOrdertime()));
            Date date=orders.get(i).getOrdertime();
            Long tim=Timestamp.valueOf(df.format(date)).getTime();
            Long lim=(long)orders.get(i).getLimit()* 60 * 60 * 1000;
            date=new Date(tim+lim);
            orders.get(i).setLimit2(df.format(date));
        }
        return BeanUtil.toPagedResult(orders);
    }

    public String getDetail(String uuid) {
        return orderMapper.getDetail(uuid);
    }



    //管理员
    @Override
    public Order getOrder(String uuid) {
        return orderMapper.selectByUUID(uuid);
    }

    //发货
    @Override
    @Transactional
    public int Send(String uuid, String detail) {

        int i=orderMapper.updateDetailByUUID(uuid,detail);
        int j=orderMapper.UpdateShopS(1,uuid);
        if(i+j>1)
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }

    //修改详情
    @Override
    public int updateDetail(String uuid, String detail) {
        return orderMapper.updateDetailByUUID(uuid,detail);
    }

    public PagedResult<Order> getByPageNoPay(Integer pageNo, Integer pageSize) {
        pageNo = pageNo == null ? 1 : pageNo;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNo, pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。
        List<Order> orders=orderMapper.getAllOrders();
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        for(int i=0;i<orders.size();i++)
        {
            orders.get(i).setOrdertime2(df.format(orders.get(i).getOrdertime()));
            Date date=orders.get(i).getOrdertime();
            //orders.get(i).setOrdertime2(df.format(date));
            Long tim=Timestamp.valueOf(df.format(date)).getTime();
            Long lim=(long)orders.get(i).getLimit()* 60 * 60 * 1000;
            date=new Date(tim+lim);
            orders.get(i).setLimit2(df.format(date));
            //orders.get(i).setOrdertime2(df.format(date));
        }
        return BeanUtil.toPagedResult(orders);
    }

    @Override
    public PagedResult<Order> getByPageNoSend(Integer pageNo, Integer pageSize) {
        pageNo = pageNo == null ? 1 : pageNo;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNo, pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。
        List<Order> orders=orderMapper.getAllOrders2();
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for(int i=0;i<orders.size();i++)
        {
            orders.get(i).setOrdertime2(df.format(orders.get(i).getOrdertime()));
        }
        return BeanUtil.toPagedResult(orders);
    }

    @Override
    public PagedResult<Order> getByPageNoAccept(Integer pageNo, Integer pageSize) {
        pageNo = pageNo == null ? 1 : pageNo;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNo, pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。
        List<Order> orders=orderMapper.getAllOrders3();
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for(int i=0;i<orders.size();i++)
        {
            orders.get(i).setOrdertime2(df.format(orders.get(i).getOrdertime()));
        }
        return BeanUtil.toPagedResult(orders);
    }

    @Override
    public PagedResult<Order> getByPageNoComment(Integer pageNo, Integer pageSize) {
        pageNo = pageNo == null ? 1 : pageNo;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNo, pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。
        List<Order> orders=orderMapper.getAllOrders4();
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for(int i=0;i<orders.size();i++)
        {
            orders.get(i).setOrdertime2(df.format(orders.get(i).getOrdertime()));
        }
        return BeanUtil.toPagedResult(orders);
    }


    @Override
    public PagedResult<Order> getByPageCancel(Integer pageNo, Integer pageSize) {
        pageNo = pageNo == null ? 1 : pageNo;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNo, pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。
        List<Order> orders=orderMapper.getAllOrdersCancel();
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        for(int i=0;i<orders.size();i++)
        {
            orders.get(i).setOrdertime2(df.format(orders.get(i).getOrdertime()));
            Date date=orders.get(i).getOrdertime();
            Long tim=Timestamp.valueOf(df.format(date)).getTime();
            Long lim=(long)orders.get(i).getLimit()* 60 * 60 * 1000;
            date=new Date(tim+lim);
            orders.get(i).setLimit2(df.format(date));
        }
        return BeanUtil.toPagedResult(orders);
    }

    @Override
    public int updatePayS(String uuid, Integer i) {
        return orderMapper.UpdatePayS(i,uuid);
    }

    @Override
    public int updateShopS(String uuid, Integer i) {
        return orderMapper.UpdateShopS(i,uuid);
    }

    //检查订单失效情况
    @Override
    public List<Order> checkOrder(Integer userid) {
        return orderMapper.checkOrderWithUser(userid);
    }

    //定时器检查
    @Override
    public List<Order> checkAllOrders() {
        return orderMapper.checkOrders();
    }

    @Override
    @Transactional
    public int cancelOrder(String uuid) {
        //1.取出detail
        Order order=orderMapper.selectByUUID(uuid);
        if(order==null)
        {
            return 0;
        }
        JSONObject jsonObject=JSON.parseObject(order.getDetail());
        JSONArray jsonArray = jsonObject.getJSONArray("Goods");
        List<HashMap> goodslist = JSON.parseArray(jsonArray.toJSONString(), HashMap.class);
        //2.判断商品是否存在，存在就恢复库存
        for(int i=0;i<goodslist.size();i++)
        {
            //获取detail中的goodsid
            Integer goodsid= Integer.parseInt( goodslist.get(i).get("goodsid").toString() ) ;//取出id
            //获取detail中的fid
            String fid=goodslist.get(i).get("fid").toString();
            if( fid.length()<=0 || fid.equalsIgnoreCase("null") ) //判断商品
            {
                //查找商品
                Goods goods=goodsMapper.selectByPrimaryKey(goodsid);
                if(goods != null)
                {
                    Double amount=Double.parseDouble( goodslist.get(i).get("amount").toString() ) ;//取出数量
                    //goods.setStock( goods.getStock()+amount );
                    //恢复库存
                    goodsMapper.updateStock(goods.getStock()+amount,goodsid);
                    //恢复销量
                    goodsMapper.updateSales(goods.getSales()-amount,goodsid);
                }
            }
            else    //判断规格
            {
                Format format=formatMapper.selectByPrimaryKey( Integer.parseInt( fid ) );
                if(format!=null)
                {
                    Double amount=Double.parseDouble( goodslist.get(i).get("amount").toString() );
                    //恢复库存
                    formatMapper.updateStock( format.getFstock()+amount , goodsid );
                    //恢复销量
                    formatMapper.updateSales( format.getFsale()-amount,goodsid );
                }

            }
        }
        //3.更新状态
        int i=updatePayS(uuid,2);//取消为2
        return i;
    }

    @Override
    public int orderDel(String uuid) {
        return orderMapper.delOrderByUUID(uuid);
    }

    //统计
    @Override
    public List<Map<String, Object>> getCount() {
        List<Map<String, Object>> mapList=new ArrayList<Map<String, Object>>();
        //上月
        Map<String,Object> last=orderMapper.getLastCount();
        last.put("type",LAST_TYPE);
        mapList.add(0,last);//0
        //本月
        Map<String,Object> th=orderMapper.getThisCount();
        th.put("type",THIS_TYPE);
        mapList.add(1,th);//1
        //增长率
        Map<String,Object> grow=new HashMap<String, Object>();
        //(本月-上月)/上月
        grow.put("all", getRate(Double.parseDouble(th.get("all").toString()) ,Double.parseDouble(last.get("all").toString())));

        grow.put("nopay",getRate(Double.parseDouble(th.get("nopay").toString()) ,Double.parseDouble(last.get("nopay").toString())) );
        grow.put("pay",getRate(Double.parseDouble(th.get("pay").toString()) ,Double.parseDouble(last.get("pay").toString())) );
        grow.put("finish",getRate(Double.parseDouble(th.get("finish").toString()) ,Double.parseDouble(last.get("finish").toString())) );
        grow.put("type",GROW_TYPE);
        mapList.add(2,grow);
        //历史
        Map<String,Object> history=orderMapper.getHistoryCount();
        history.put("type",HISTORY_TYPE);
        mapList.add(3,history);//3


        return mapList;
    }

    public String getRate(Double now,Double last)
    {
        Double result=0.0;
        try {
            if(last==0)
            {
                throw new NumberFormatException();
            }
            result=(now-last)/last;

        }catch (NumberFormatException ex)
        {
            return "";
        }
        catch (StringIndexOutOfBoundsException e)
        {
            return "";
        }
        //return result.toString().substring(0,4);
        DecimalFormat df   = new DecimalFormat("######0.00");
        return df.format(result*100)+"%";
    }

    @Override
    public List<Order> HighQuery(String uuid, String begin, String end, Integer paystatus, Integer shopstatus) {
        List<Order> orderList=orderMapper.QueryOrder(uuid,begin,end,paystatus,shopstatus);
        //SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for (Order o:orderList)
        {
            o.setOrdertime2(o.getOrdertime().toLocaleString());
        }

        return orderList;
    }

    @Override
    public void CheckOrderToCancel() {
        List<Order> orders=orderMapper.checkOrders();//超时订单
        if(orders!=null)
        {
            for(Order o:orders)
            {
                cancelOrder(o.getUuid());
            }
        }
    }

    /**
     *  新需求
     */

    @Override
    public List<Order> getLimitOrder(Integer uid, Integer count) {
        return orderMapper.getOrderByIdLimit(uid,count);
    }

    @Override
    public PagedResult<Order> OrderList_deafult(Integer pageNo, Integer pageSize,Integer uid) {
        pageNo = pageNo == null?1:pageNo;
        pageSize = pageSize == null?5:pageSize;
        PageHelper.startPage(pageNo,pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。
        //List<Order> orders=orderMapper.getAllByUser(uid);
        //PagedResult<Order> o=BeanUtil.toPagedResult( orderMapper.getAllByUser(uid) );
        return BeanUtil.toPagedResult( orderMapper.getAllByUser(uid) );
    }

    /*  AJAX
     *  Type -1: ALL 上一页 下一页
     *  Type 0: Awaiting Payment 上一页 下一页
     *  Type 1: Awaiting Shipping 上一页 下一页
     *  Type 2: Shipment Shipped 上一页 下一页
     *  Type 3: Received 上一页 下一页
     *  Type 4: Cancelled 上一页 下一页
     *  Type 5:
     *  Type 6:
     */
    @Override
    public PagedResult<Order> orderPageSelect(JSONObject object,Integer uid) {
        String type=object.getString("type");
        Integer pageNo;
        Integer pageSize;
        try{
            pageNo=Integer.parseInt( object.getString("pageNo") );
            pageSize=Integer.parseInt(object.getString("pageSize") );
        }catch (NumberFormatException e)
        {
            pageNo=null;
            pageSize=null;
        }

        pageNo = pageNo == null?1:pageNo;
        pageSize = pageSize == null?5:pageSize;
        PageHelper.startPage(pageNo,pageSize);
        switch ( Integer.valueOf(type) )
        {
            case -1:
                return BeanUtil.toPagedResult( orderMapper.getAllByUser(uid) );
            case  0:
                return BeanUtil.toPagedResult( orderMapper.getUserOrders(uid) );
            case  1:
                return BeanUtil.toPagedResult( orderMapper.getUserOrders2(uid) );
            case  2:
                return BeanUtil.toPagedResult( orderMapper.getUserOrders3(uid) );
            case  3:
                return BeanUtil.toPagedResult( orderMapper.getUserOrders45(uid) );
            case  4:
                return BeanUtil.toPagedResult( orderMapper.OrderCancel(uid) );
        }

        return null;
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