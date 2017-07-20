package com.jd.shop.service.serviceimpl;

import com.jd.shop.dao.UserMapper;
import com.jd.shop.model.User;
import com.jd.shop.service.UserService;
import com.jd.shop.util.Md5Utils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by ThinkPad on 2017/7/6.
 */

@Service
public class UserServiceImpl implements UserService{

    @Resource
    private UserMapper userMapper;

    //注册
    public int insertSelective(User user) {
        //MD5 密码加密
        user.setPass(Md5Utils.string2MD5(user.getPass()));

        return userMapper.insertSelective(user);
    }

}
