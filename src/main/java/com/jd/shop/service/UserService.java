package com.jd.shop.service;

import com.jd.shop.model.User;
import com.jd.shop.util.PagedResult;
import org.springframework.stereotype.Service;

/**
 * Created by ThinkPad on 2017/7/6.
 */

public interface UserService {

    //注册
    int insertSelective(User user);

    //获取用户列表(分页)
    PagedResult<User> queryByPage(Integer pageNo, Integer pageSize);

    int updatePersonalInfo(User user);

    String userDel(Integer uid,Integer status);

}
