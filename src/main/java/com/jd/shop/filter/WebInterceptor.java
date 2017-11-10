package com.jd.shop.filter;


import com.jd.shop.model.User;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class WebInterceptor implements HandlerInterceptor {

    /**
     * 在请求执行之前
     * 在请求处理之前进行调用（Controller方法调用之前
     *
     * @param req
     * @param resp
     * @param handler
     * @return
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest req,
                             HttpServletResponse resp,
                             Object handler) throws Exception {


//        System.out.println("====执行登录====");
        /**
         * 获取session
         */
        HttpSession session = req.getSession();
        /**
         * 获取请求路径
         */
        String path = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort();
        User sessionUser = (User) session.getAttribute("user");
        //System.out.println(path);
        //System.out.println(sessionUser);
        if (sessionUser != null) {
            return true;
        } else {
            resp.sendRedirect(path + "/JDWebShop/login/login");
        }

        return false;

    }


    /**
     * 在请求之后执行的
     * 但是在视图被渲染之前（Controller方法调用之后）
     *
     * @param req
     * @param resp
     * @param handler
     * @param modelAndView
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest req,
                           HttpServletResponse resp,
                           Object handler,
                           ModelAndView modelAndView) throws Exception {

    }


    /**
     * 在整个请求调用之后,视图渲染完成以后执行的
     * 也就是在DispatcherServlet 渲染了对应的视图之后执行（主要是用于进行资源清理工作）
     *
     * @param req
     * @param resp
     * @param handler
     * @param ex
     * @throws Exception
     */
    @Override
    public void afterCompletion(HttpServletRequest req,
                                HttpServletResponse resp,
                                Object handler,
                                Exception ex) throws Exception {

    }
}
