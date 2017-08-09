package com.jd.shop.service.serviceimpl;

import com.jd.shop.dao.CartItemMapper;
import com.jd.shop.dao.CartMapper;
import com.jd.shop.model.Cart;
import com.jd.shop.model.CartItem;
import com.jd.shop.service.CartService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
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

    @Transactional
    public int cartadd(Integer userid, Integer goodsid, Double count) {

        //1.查找该用户的购物车，没有就创建   --->放入了用户注册 2017/8/9
        //2.获取购物车id，填入记录，成功返回 1， 失败返回 0

        Cart cart=cartMapper.selectCartByUser(userid);
        CartItem cartItem=new CartItem();
        cartItem.setAmount(count);
        cartItem.setItemGoods(goodsid);
        cartItem.setItemCart(cart.getId());

        return cartItemMapper.insertSelective(cartItem);
    }

    public List<Map<String, String>> cartItem(Integer uid) {
        return null;
    }
}
