package com.jd.shop.filter;

import com.jd.shop.annotation.AdminLogin;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by ThinkPad on 2017/8/3.
 */
public class AdminInterceptor implements HandlerInterceptor{

    private static Log logger = LogFactory.getLog(AdminInterceptor.class);

    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object handler) throws Exception {
        if (logger.isDebugEnabled()) {
            logger.debug("拦截器启动");
        }
        /*
        * 判断是否为 HandlerMethod.class
        * 如果不是说明当前请求并不是 SpringMVC 管理，
        * 如果不是再自行根据业务做响应操作，这里直接返回 true
        */
        if (HandlerMethod.class.isInstance(handler)) {
            HandlerMethod handlerMethod = (HandlerMethod) handler;
            AdminLogin adminLogin = handlerMethod.getMethod().getDeclaredAnnotation(AdminLogin.class);

            // 如果该 handler AdminLogin，判断所属Controller 是否包含注解
            if (null == adminLogin) {
                adminLogin = handlerMethod.getBeanType().getAnnotation(AdminLogin.class);
            }

            // 如果需要 AdminLogin 判断 session
//            if (null != adminLogin) {
//                if ( httpServletRequest.getSession().getAttribute("Admin") == null ) {
//                    String executeURL = adminLogin.value();
//                    if (StringUtils.isBlank(executeURL)) {
//                        executeURL = WebLogin.LOGIN;
//                    }
//
//                    httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + executeURL);
//                    return false;
//                }
//            }
        }
        return true;
    }

    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }

    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }
}
