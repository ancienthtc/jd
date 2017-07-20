package com.jd.shop.service.serviceimpl;

import com.jd.shop.dao.AdminMapper;
import com.jd.shop.dao.UserMapper;
import com.jd.shop.model.Admin;
import com.jd.shop.model.User;
import com.jd.shop.service.loginService;
import com.jd.shop.util.Md5Utils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * Created by ThinkPad on 2017/7/6.
 */

@Service
public class loginServiceImpl implements loginService {

    @Resource
    private UserMapper userMapper;

    @Resource
    private AdminMapper adminMapper;

    //login time
    Calendar now = Calendar.getInstance();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Timestamp ts = Timestamp.valueOf( sdf.format(now.getTime()) );


    public User login(String name,String pass) {
        //MD5加密password
        pass= Md5Utils.string2MD5(pass);

        User u=new User();
        try {
            u=userMapper.login(name,pass);
        }catch (Exception e)
        {
            e.printStackTrace();
        }

        if(u != null)
        {
            //刷新登录时间
            u.setLogin(ts);
            userMapper.updateByPrimaryKeySelective(u);
            return u;
        }
        else
        {
            return null;
        }
    }

    public Admin alogin(String admin, String pass) {
        pass=Md5Utils.string2MD5(pass);

        Admin a=new Admin();
        a=adminMapper.selectByAdmin(admin,pass);

        if(a != null)
        {
            a.setAlogin(ts);
            adminMapper.updateByPrimaryKeySelective(a);
            return a;
        }
        else
        {
            return null;
        }
    }


}
