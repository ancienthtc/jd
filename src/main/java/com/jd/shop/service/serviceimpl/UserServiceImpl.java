package com.jd.shop.service.serviceimpl;

import com.github.pagehelper.PageHelper;
import com.jd.shop.dao.CartMapper;
import com.jd.shop.dao.UserMapper;
import com.jd.shop.model.*;
import com.jd.shop.service.*;
import com.jd.shop.util.BeanUtil;
import com.jd.shop.util.Md5Utils;
import com.jd.shop.util.PagedResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by ThinkPad on 2017/7/6.
 */

@Service
public class UserServiceImpl implements UserService{

    @Resource
    private UserMapper userMapper;

    @Resource
    private CartMapper cartMapper;

    @Autowired
    private OrderService orderService;

    @Autowired
    private CartService cartService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private AddressService addressService;

    @Autowired
    private HistoryService historyService;

    //注册
    @Transactional
    public int insertSelective(User user) {
        //验证nickname是否重复
        List<String> nicknames=userMapper.username(user.getNickname());
        if(nicknames.isEmpty())
        {
            //MD5 密码加密
            user.setPass(Md5Utils.string2MD5(user.getPass()));

            int i=userMapper.insertSelective(user);//用户添加

            Cart cart=new Cart();
            cart.setUserCart(user.getId());
            int j=cartMapper.insertSelective(cart);

            if(i>0 && j>0)  //购物车和添加用户都成功
            {
                return 1;//成功
            }
            else
            {
                if(i>0 && j<=0)
                {
                    userMapper.deleteByPrimaryKey(user.getId());//购物车添加失败，用户成功后也删除
                }
                return 0;//失败
            }

        }
        else    //重复
        {
            return -1;
        }

    }

    //获取用户列表 分页
    public PagedResult<User> queryByPage(Integer pageNo, Integer pageSize) {
        pageNo = pageNo == null?1:pageNo;
        pageSize = pageSize == null?10:pageSize;
        PageHelper.startPage(pageNo,pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。

        return BeanUtil.toPagedResult( userMapper.getAll() );
    }

    public int updatePersonalInfo(User user){
        int num = userMapper.updateByPrimaryKeySelective(user);
        return num;
    }

    /**
     * status:0 普通删除 , status:1 强制删除
     * @param uid
     * @param status
     * @return
     */
    @Override
    @Transactional
    public String userDel(Integer uid, Integer status) {
        if(status!=1)
        {
            status=0;
        }
        if(userMapper.selectByPrimaryKey(uid)==null)
        {
            return "用户不存在";
        }
        //status 0普通删除  1强制删除
        //删除订单
        List<Order> torders=orderService.UserAllOrder(uid);
        if(torders!=null && status==0)
        {
            return "失败，用户存在订单";
        }
        else if(torders!=null && status==1)
        {
            for(Order o:torders)
            {
                orderService.cancelOrder(o.getUuid());
                orderService.orderDel(o.getUuid());
            }
        }


        //删除购物车
        if(status==0)
        {
            cartService.ClearCartItem(uid);
        }
        else
        {
            cartService.ClearCartItem(uid);
            cartMapper.delCartByUserIsDel(uid);
        }

        //删除图片集
        //暂时空

        //删除评论
        List<Comment> comments=commentService.findByUserId(uid);
        for(Comment c:comments)
        {
            commentService.CommentDel(c.getId());
        }

        //删除收货地址
        List<Address> addresses=addressService.findAddressByUserId(uid);
        for(Address a:addresses)
        {
            addressService.deleteAddress(a.getId());
        }
        //删除访问历史
        List<History> histories=historyService.findByUserId(uid);
        for(History h:histories)
        {
            historyService.deleteByPrimaryKey(h.getId());
        }

        if(userMapper.deleteByPrimaryKey(uid) > 0)
        {
            return "删除成功";
        }
        else
        {
            return "删除失败";
        }

    }

}
