package com.jd.shop.controller;

import com.jd.shop.annotation.AdminLogin;
import com.jd.shop.model.Admin;
import com.jd.shop.model.Goods;
import com.jd.shop.model.Part;
import com.jd.shop.model.User;
import com.jd.shop.service.GoodsService;
import com.jd.shop.service.PartService;
import com.jd.shop.service.loginService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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

    @Resource
    private GoodsService goodsService;

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
    @RequestMapping(value = "/ton" , method = RequestMethod.POST)//tel or name
    @ResponseBody
    public String login(@RequestParam(value = "username") String username, @RequestParam(value = "password") String password ,
                         String loginkeeping ,Model model,HttpSession session,User user){
        if(loginkeeping!=null)
        {
            user=loginService.login(username,password,true);
        }
        else if(loginkeeping == null)
        {
            user=loginService.login(username,password,false);
        }

        if(user!=null){
            model.addAttribute("user",user);

            //取消主页异步请求，改为跳转前获取数据。
            //获取板块-代表
            //List<Map<String, String>> allinfo=partService.getAllInfo();
            //model.addAttribute("parts",allinfo);
            session.setAttribute("user",user);
            model.addAttribute("message","登录成功");
            //return "user/shophome";//改跳转到Controller 获取商品，用户信息
            //return "redirect:/login/view";
            return "true";
        }
        if(session.getAttribute("user") !=null)
        {
            model.addAttribute("message","登录成功");
        }
        else
        {
            model.addAttribute("message","登录失败!");
        }

        //return "user/login";
        return "false";
        //return "user/login_register";
    }

    @RequestMapping(value = "/ton" , method = RequestMethod.GET)
    public String loginNone()
    {
        return "user/login_register";
    }

    //对于游客  //改!
    //新需求
    @RequestMapping("/view")
    public String view(Model model)
    {
        //List<Map<String, String>> allinfo=partService.getAllInfo();
        //model.addAttribute("parts",allinfo);
        //新需求
        //1.板块
        List<Part> parts=partService.getIndexParts();
        model.addAttribute("parts",parts);
        //2.新商品
        //第一页8个
        List<Goods> first_page=goodsService.new_goods(0,8);
        model.addAttribute("fp",first_page);
        //第二页8个
        List<Goods> second_page=goodsService.new_goods(9,16);
        model.addAttribute("sp",second_page);
        //第三页8个
        List<Goods> third_page=goodsService.new_goods(17,24);
        model.addAttribute("tp",third_page);
        //3.热销商品3个
        List<Goods> hot=goodsService.GoodSale();
        model.addAttribute("hot",hot);
        //return "user/shophome";
        return "user/index";
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


    /**
     * 新需求
     */
    @RequestMapping("/sign")
    public String signIn(String Email,String Password)
    {


        return "user/index";
    }

}
