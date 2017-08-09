package com.jd.shop.service.serviceimpl;

import com.github.pagehelper.PageHelper;
import com.jd.shop.dao.CartMapper;
import com.jd.shop.dao.UserMapper;
import com.jd.shop.model.Cart;
import com.jd.shop.model.User;
import com.jd.shop.service.UserService;
import com.jd.shop.util.BeanUtil;
import com.jd.shop.util.Md5Utils;
import com.jd.shop.util.PagedResult;
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
}
