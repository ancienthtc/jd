package com.jd.shop.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;

import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import java.text.ParseException;

/**
 * Created by ThinkPad on 2017/7/6.
 */
public class BaseController {
    /** 基于@ExceptionHandler异常处理 */
    @ExceptionHandler
    public String exp(HttpServletRequest request, Exception ex , Model model) {

        request.setAttribute("ex", ex);

        // 根据不同错误转向不同页面
        // 根据不同的异常类型进行不同处理
        if(ex instanceof RuntimeException)
        {
            System.out.println(ex.getMessage());
            ex.printStackTrace();
            model.addAttribute("message",ex.getMessage());
            return "ex/error";
        }
        else
        {
            ex.printStackTrace();
            return "ex/error";
        }
    }
}
