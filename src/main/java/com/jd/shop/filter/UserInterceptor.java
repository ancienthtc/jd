package com.jd.shop.filter;

import com.jd.shop.annotation.UserLogin;
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
public class UserInterceptor implements HandlerInterceptor{

    private static Log logger = LogFactory.getLog(UserInterceptor.class);

    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object handler) throws Exception {
        if (logger.isDebugEnabled()) {
            logger.debug("拦截器启动");
        }

        if (handler instanceof HandlerMethod)
        {
            UserLogin adminLogin = findAnnotation((HandlerMethod) handler, UserLogin.class);
            //没有声明需要权限,或者声明不验证权限
            if(adminLogin==null)
            {
                return true;
            }
            else
            {
                if(httpServletRequest.getSession().getAttribute("user") != null  )
                {
                    return true;
                }
                else
                {
                    httpServletRequest.getRequestDispatcher("/WEB-INF/jsp/user/login.jsp").forward(httpServletRequest,httpServletResponse);
                    return false;
                }
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
