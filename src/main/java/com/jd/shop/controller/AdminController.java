package com.jd.shop.controller;

import com.jd.shop.model.Admin;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


/**
 * Created by ThinkPad on 2017/7/7.
 */

@Controller
@RequestMapping("/admin")
public class AdminController {

    //admin dispather
    //管理员主页

    /**
     * 管理员跳转主页
     * @param req
     * @return
     */
    @RequestMapping("/tohome")
    public String home(HttpServletRequest req){
        //判断session是否存在
        HttpSession session = req.getSession();
        if(session == null){
            return "admin/login";
        }
        //判断是否为登录状态
        Admin admin = (Admin) session.getAttribute("admin");
        if(admin==null){
            return "admin/login";
        }
        //将权限标识存入request
        req.setAttribute("alevel",admin.getAlevel());


        return "admin/aindex";
    }

    //导航栏frame
    @RequestMapping("/frame")
    public String frame()
    {
        return "admin/show";
    }

    //商品列表
    @RequestMapping("/goodslist")
    public String goGoodsList()
    {
        return "admin/goodslist";
    }

    //商品添加
    @RequestMapping("/goodsadd")
    public String goGoodsAdd()
    {
        return "admin/goodsadd";
    }



    //板块列表
    @RequestMapping("/partlist")
    public String goPartAlter()
    {
        return "admin/partlist";
    }

}
