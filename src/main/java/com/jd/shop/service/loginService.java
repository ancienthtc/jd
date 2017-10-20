package com.jd.shop.service;

import com.jd.shop.model.Admin;
import com.jd.shop.model.User;
import org.springframework.stereotype.Service;

/**
 * Created by ThinkPad on 2017/7/6.
 */

public interface loginService {

    public User login(String name,String pass,boolean tellogin);

    public Admin alogin(String admin,String pass);
}
