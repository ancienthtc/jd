package com.jd.shop.filter;

import com.jd.shop.annotation.AdminLogin;
import com.jd.shop.controller.BaseController;
import com.jd.shop.model.Admin;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.annotation.Annotation;

/**
 * Created by ThinkPad on 2017/8/3.
 */
public class AdminInterceptor implements HandlerInterceptor{

    private static Log logger = LogFactory.getLog(AdminInterceptor.class);

    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object handler) throws Exception {
        if (logger.isDebugEnabled()) {
            logger.debug("拦截器启动");
        }

        if (handler instanceof HandlerMethod)
        {
            AdminLogin adminLogin = findAnnotation((HandlerMethod) handler, AdminLogin.class);
            //没有声明需要权限,或者声明不验证权限
            if(adminLogin==null)
            {
                return true;
            }
            else
            {
                if(httpServletRequest.getSession().getAttribute("admin") != null  )
                {
                    return true;
                }
                else
                {
                    //httpServletRequest.getRequestDispatcher("redirect:login/alogin").forward(httpServletRequest,httpServletResponse);
                    //httpServletResponse.sendRedirect("redirect:login/admin");
                    httpServletRequest.getRequestDispatcher("/WEB-INF/jsp/admin/alogin.jsp").forward(httpServletRequest,httpServletResponse);
                    //throw new RuntimeException();
                    return false;
                }
//                String token=httpServletRequest.getHeader("token");
//                if(StringUtils.isEmpty(token)){
//                    token=httpServletRequest.getParameter("token");
//                }
//                //在这里实现自己的权限验证逻辑
//                if(!StringUtils.isEmpty(token)){//如果验证成功返回true（这里直接写false来模拟验证失败的处理）
//                    return true;
//                }else{//如果验证失败
//                    httpServletResponse.getWriter().write("您还未登录");
//                    return false;
//                }
            }
        }
        else
        {
            return true;
        }
    }

    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }

    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    private <T extends Annotation> T findAnnotation(HandlerMethod handler, Class<T> annotationType) {
        T annotation = handler.getBeanType().getAnnotation(annotationType);
        if (annotation != null) return annotation;
        return handler.getMethodAnnotation(annotationType);
    }
}
//if (null != webLoginRequired) {
//        if (httpServletRequest.getSession().getAttribute(WebLogin.CURRENTUSER) == null) {
//        String executeURL = webLoginRequired.value();
//        if (StringUtils.isBlank(executeURL)) {
//        executeURL = WebLogin.LOGIN;
//        }
//
//        httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + executeURL);
//        return false;
//        }
//        }