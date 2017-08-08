package com.jd.shop.service.serviceimpl;

import com.jd.shop.dao.CartItemMapper;
import com.jd.shop.dao.CartMapper;
import com.jd.shop.model.Cart;
import com.jd.shop.model.CartItem;
import com.jd.shop.service.CartService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * Created by ThinkPad on 2017/8/8.
 */
@Service
public class CartServiceImpl implements CartService{

    @Resource
    private CartMapper cartMapper;

    @Resource
    private CartItemMapper cartItemMapper;

    @Transactional
    public int cartadd(Integer userid, Integer goodsid, Double count) {
        //1.查找该用户的购物车，没有就创建
        //2.获取购物车id，填入记录，成功返回 1， 失败返回 0
        int id;
        if(cartMapper.selectCartByUser(userid) == null)
        {
            Cart cart=new Cart();
            cart.setUserCart(userid);
            cartMapper.insertSelective(cart);
            id=cart.getId();
        }
        else
        {
            Cart cart=cartMapper.selectCartByUser(userid);
            id=cart.getId();
        }

        CartItem cartItem=new CartItem();
        cartItem.setAmount(count);
        cartItem.setItemGoods(goodsid);
        cartItem.setItemCart(id);

        return cartItemMapper.insertSelective(cartItem);
    }



}
