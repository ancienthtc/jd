package com.jd.shop.service.serviceimpl;

import com.github.pagehelper.PageHelper;
import com.jd.shop.dao.UserMapper;
import com.jd.shop.model.User;
import com.jd.shop.service.UserService;
import com.jd.shop.util.BeanUtil;
import com.jd.shop.util.Md5Utils;
import com.jd.shop.util.PagedResult;
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

    //获取用户列表 分页
    public PagedResult<User> queryByPage(Integer pageNo, Integer pageSize) {
        pageNo = pageNo == null?1:pageNo;
        pageSize = pageSize == null?10:pageSize;
        PageHelper.startPage(pageNo,pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。

        return BeanUtil.toPagedResult( userMapper.getAll() );
    }
}
