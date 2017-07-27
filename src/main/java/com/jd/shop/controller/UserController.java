package com.jd.shop.controller;

import com.alibaba.fastjson.JSON;
import com.jd.shop.model.User;
import com.jd.shop.service.UserService;
import com.jd.shop.util.Md5Utils;
import com.jd.shop.util.PagedResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by ThinkPad on 2017/7/6.
 */

@Controller
@RequestMapping("/user")
public class UserController extends BaseController{

    @Autowired
    private UserService userService;

    @RequestMapping(value = "register" , method = RequestMethod.POST)
    public String register(User user, HttpServletRequest request , Model model) throws Exception
    {
        //impleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
        String nickname=request.getParameter("nickname");//昵称(not null)
        String tel=request.getParameter("tel");//手机(not null)
        String birth=request.getParameter("birth"); //生日
        String sex=request.getParameter("sex");//性别
        String live=request.getParameter("live");//居住地
        String pass=request.getParameter("pass");//密码(not null)

        if(nickname==null || nickname.equals("") || tel==null || tel.equals("") || pass==null || pass.equals(""))
        {
            model.addAttribute("message","注册失败");
            return "login";
        }
        if(userService.insertSelective(user) != 0 )
        {
            model.addAttribute("message","注册成功");
        }
        else
        {
            model.addAttribute("message","注册失败");
        }
        return "login";
    }

    //进入用户列表
    @RequestMapping("tolist")
    public String toUserlist()
    {
        return "admin/userlist";
    }

    //分页 获取用户列表(json)
    @RequestMapping("/list_get")
    @ResponseBody
    public String selectUserList(Integer pageNo, Integer pageSize )
    {
        PagedResult<User> parts=userService.queryByPage(pageNo,pageSize);

        String json= JSON.toJSONString(parts);
        return json;
    }

}
