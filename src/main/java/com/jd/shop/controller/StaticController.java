package com.jd.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by ThinkPad on 2017/9/15.
 */
@Controller
public class StaticController {

    @RequestMapping("/{page}")
    public String toPage(@PathVariable String page)
    {
        if(page.contains("."))
        {
            page=page.substring(0,page.lastIndexOf("."));
        }

        return "user/"+page;
    }

    @RequestMapping("/GetVersion/{pass}")
    @ResponseBody
    public String getVersion(@PathVariable String pass)
    {
        if(pass.equals("JDHu")) {
            return "Version 1.2 -- 17/11/2";
        }
        else
        {
            return "密码错误";
        }
    }

}
