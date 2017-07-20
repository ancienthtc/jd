package com.jd.shop.controller;

import com.jd.shop.model.Admin;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Created by ThinkPad on 2017/7/7.
 */

@Controller
@RequestMapping("/admin")
public class AdminController {

    //admin dispather
    //管理员主页
    @RequestMapping("/tohome")
    public String home()
    {
        return "admin/home";
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

    //板块添加
    @RequestMapping("/partadd")
    public String goPartAdd()
    {
        return "admin/partadd";
    }

    //板块列表
    @RequestMapping("/partlist")
    public String goPartAlter()
    {
        return "admin/partlist";
    }

}
