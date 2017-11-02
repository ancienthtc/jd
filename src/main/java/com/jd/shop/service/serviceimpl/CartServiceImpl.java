package com.jd.shop.service.serviceimpl;

import com.jd.shop.dao.CartItemMapper;
import com.jd.shop.dao.CartMapper;
import com.jd.shop.model.Cart;
import com.jd.shop.model.CartItem;
import com.jd.shop.service.CartService;
import com.jd.shop.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ThinkPad on 2017/8/8.
 */
@Service
public class CartServiceImpl implements CartService{

    @Resource
    private CartMapper cartMapper;

    @Resource
    private CartItemMapper cartItemMapper;

    @Autowired
    private GoodsService goodsService;

    @Transactional
    public int cartadd(String userid, String goodsid, String count ,String tprice, String fid) {

        //旧
        //1.查找该用户的购物车，没有就创建   --->放入了用户注册 2017/8/9
        //2.获取购物车id，判断是否存在goodsid
        //3.不存在就填入记录，存在就更新数量
        //4.成功返回 1， 失败返回 0

        //新!
        //2.获取购物车 判断 商品id和商品规格是否同时存在
        //3.存在:数量增加,总价增加    不存在:新添记录(规格,总价)

        //2
        CartItem cartItem;
        if(fid==null || fid=="")
        {
            cartItem=cartItemMapper.queryByGoodsWithUserNormal( Integer.parseInt(goodsid) , Integer.parseInt(userid) );
        }
        else    //fid!=null
        {
            cartItem=cartItemMapper.queryByGoodsWithUserFormat( Integer.parseInt(goodsid),Integer.parseInt(userid),Integer.parseInt(fid) );
        }
        if(cartItem != null)  //已存在相同商品
        {
            Integer f;
            if( fid.length()>0)
            {
                f=Integer.parseInt(fid);
            }
            else
            {
                f=null;
            }
            return cartItemMapper.updateCountOfItem(Integer.parseInt(goodsid) ,Double.parseDouble(count),Integer.parseInt(userid) ,f  );
        }
        else //没有已存在商品,添加记录
        {
            //3
            Cart cart=cartMapper.selectCartByUser( Integer.parseInt(userid) );
            CartItem cartItem1=new CartItem();
            cartItem1.setAmount( Double.parseDouble(count) );
            cartItem1.setTprice( Double.parseDouble(tprice) );
            if( fid.length()>0 )
            {
                cartItem1.setItemFormat( Integer.parseInt(fid) );
            }
            cartItem1.setItemGoods( Integer.parseInt(goodsid)  );
            cartItem1.setItemCart(cart.getId());
            return cartItemMapper.insertSelective(cartItem1);
        }




    }

    public List<Map<String, Object>> cartItem(Integer uid) {
        //默认情况 CartItem.item_format 空
        //包含规格的列    CartItem.item_format 非空
        return cartMapper.cartitem(uid);
    }

    public int DelCartItem(Integer ciid) {
        return cartItemMapper.deleteByPrimaryKey(ciid);
    }

    public int ClearCartItem(Integer uid) {
        return cartMapper.clearCart(uid);
    }

    public Map<String, Number> getCal(List<Map<String, Object>> cartitem) {
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
                    //System.out.print(cartitem.get(i).get("all"));
                    total = total + Double.parseDouble( cartitem.get(i).get("all").toString() );
                }catch (ClassCastException e)
                {
                }
            }
        }

        cal.put("total",total);
        cal.put("count",count);
        return cal;
    }

    public Double getMaxFreight(List<HashMap> goodses) {
        Double Freight=0.0;
        double[] f=new double[goodses.size()];
        for(int i=0;i<goodses.size();i++)
        {
            f[i]=goodsService.getGoods( Integer.parseInt( goodses.get(i).get("gid").toString() )  ).getFreight();
            if(f[i]>Freight) {// 判断最大值
                Freight = f[i];
            }
        }
        return Freight;
    }
}
