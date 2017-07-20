package com.jd.shop.service;

import com.jd.shop.model.User;
import org.springframework.stereotype.Service;

/**
 * Created by ThinkPad on 2017/7/6.
 */

public interface UserService {

    //注册
    int insertSelective(User user);


}
