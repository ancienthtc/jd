package com.jd.shop.controller;

import com.jd.shop.annotation.AdminLogin;
import com.jd.shop.model.Admin;
import com.jd.shop.model.User;
import com.jd.shop.service.PartService;
import com.jd.shop.service.loginService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * Created by ThinkPad on 2017/7/6.
 */
@Controller
@RequestMapping("/login")
public class LoginController extends BaseController{

    @Resource
    private loginService loginService;

    @Resource
    private PartService partService;

    @RequestMapping("/login")
    public String login()
    {
        return "user/login";
    }

    @RequestMapping("/reg")
    public String reg()
    {
        return "user/register";
    }

    @RequestMapping("/admin")
    public String admin()
    {
        return "admin/alogin";
    }

    //改!
    @RequestMapping(value = "/ton" /*, method = RequestMethod.POST*/)//tel or name
    public String login(@RequestParam(value = "username") String username, @RequestParam(value = "password") String password , Model model,HttpSession session)
    {
        User user=new User();
        user=loginService.login(username,password);
        if(user!=null)
        {
            //model.addAttribute("User",user);
            session.setAttribute("User",user);
            //取消主页异步请求，改为跳转前获取数据。
            //获取板块-代表
            List<Map<String, String>> allinfo=partService.getAllInfo();
            model.addAttribute("parts",allinfo);

            return "user/shophome";//改跳转到Controller 获取商品，用户信息
        }
        model.addAttribute("message","登录失败!");
        return "user/login";
    }

    //对于游客  //改!
    @RequestMapping("/view")
    public String view(Model model)
    {
        List<Map<String, String>> allinfo=partService.getAllInfo();
        model.addAttribute("parts",allinfo);
        return "user/shophome";
    }

    /**
     * 管理员登录
     * @param admin
     * @param pass
     * @param request
     * @param model
     * @return
     */
    @AdminLogin
    @RequestMapping(value = "/alogin" , method = RequestMethod.POST)
    public String adminlogin(@RequestParam(value = "admin") String admin, @RequestParam(value = "pass") String pass , HttpServletRequest request,Model model)
    {

        Admin a=new Admin();
        a=loginService.alogin(admin,pass);
        if(a!=null)
        {
            //
            HttpSession session=request.getSession();
            session.setAttribute("admin",a);
            return "redirect:/admin/tohome";
        }
        model.addAttribute("message","登录失败");
        return "admin/alogin";
    }
}
