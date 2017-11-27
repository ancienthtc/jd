package com.jd.shop.controller;

import com.alibaba.fastjson.JSON;
import com.jd.shop.annotation.AdminLogin;
import com.jd.shop.annotation.UserLogin;
import com.jd.shop.model.Address;
import com.jd.shop.model.Order;
import com.jd.shop.model.User;
import com.jd.shop.service.AddressService;
import com.jd.shop.service.OrderService;
import com.jd.shop.service.PartService;
import com.jd.shop.service.UserService;
import com.jd.shop.util.DateUtil;
import com.jd.shop.util.PagedResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ThinkPad on 2017/7/6.
 */

@Controller
@RequestMapping("/user")
public class UserController extends BaseController{

    @Autowired
    private UserService userService;

    @Autowired
    private PartService partService;

    @Autowired
    private AddressService addressService;

    @Autowired
    private OrderService orderService;


    //用户注册
    @RequestMapping(value = "register" , method = RequestMethod.POST)
    @ResponseBody
    public String register( User user, HttpServletRequest request , Model model) throws Exception
    {
        //impleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
//        String nickname=request.getParameter("nickname");//昵称(not null)
//        String tel=request.getParameter("tel");//手机(not null)
//        String birth=request.getParameter("birth"); //生日
//        String sex=request.getParameter("sex");//性别
//        String live=request.getParameter("live");//居住地
//        String pass=request.getParameter("pass");//密码(not null)
        String nickname=user.getNickname();
        String tel=user.getTel();
        Date birth=user.getBirth();
        String sex=user.getSex();
        String live=user.getLive();
        String pass=user.getPass();

        if(nickname.length()>10 && nickname.length()<=3 || tel==null || tel.equals("") || pass==null || pass.equals(""))
        {
            model.addAttribute("message","注册失败");
            //return "user/login";
            return "0";
        }
        int i=userService.insertSelective(user);
        if(i > 0 )
        {
            model.addAttribute("message","注册成功");
            return "1";
        }
        else if(i < 0)
        {
            model.addAttribute("message","用户名已存在");
            return "-1";
        }
        else
        {
            model.addAttribute("message","注册失败");
            return "0";
        }
        //return "user/login";
    }

    //进入用户列表
    @AdminLogin
    @RequestMapping("/tolist")
    public String toUserlist()
    {
        return "admin/userlist";
    }

    //分页 获取用户列表(json)
    @AdminLogin
    @RequestMapping("/list_get")
    @ResponseBody
    public String selectUserList(Integer pageNo, Integer pageSize )
    {
        PagedResult<User> parts=userService.queryByPage(pageNo,pageSize);

        String json= JSON.toJSONString(parts);
        return json;
    }


    /**
     * 跳转至用户个人中心页面
     * @return
     */
    @UserLogin
    @RequestMapping("/toShopCenter")
    public String toShopCenter(HttpSession session,HttpServletRequest req){
        User user = (User)session.getAttribute("user");
        req.setAttribute("user",user);
        String loginDate = DateUtil.getStringDate(user.getLogin(),2);
        req.setAttribute("loginDate",loginDate);
        String birth = DateUtil.getStringDate(user.getBirth(),1);
        req.setAttribute("birth",birth);
        return "user/shopCenter";
    }

    /**
     * 跳转到主页
     * @return
     */
    @UserLogin
    @RequestMapping("/toShopHome")
    public String toShopHome(HttpSession session,HttpServletRequest req,Model model)
    {
        User user = (User)session.getAttribute("user");
        if(user==null){
            return "user/login";
        }
        else
        {
            model.addAttribute("user",user);
            List<Map<String, String>> allinfo=partService.getAllInfo();
            model.addAttribute("parts",allinfo);
            session.setAttribute("user",user);
            return "user/shophome";//改跳转到Controller 获取商品，用户信息
        }
    }

    /**
     * 用户修改个人信息
     * @param user
     * @param birth
     * @param session
     * @return
     */
    @UserLogin
    @RequestMapping(value="/updatePersonalInfo",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> updatePersonalInfo(User user,String birth,HttpSession session){
        Map<String,String> map = new HashMap<String,String>();
        if(birth==null){
            map.put("msg","生日不能为空");
            return map;
        }
        User use = (User)session.getAttribute("user");
        user.setId(use.getId());
        SimpleDateFormat sdf=  new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        try {
            date = sdf.parse(birth);
        } catch (ParseException e) {
            e.printStackTrace();
            map.put("msg","生日转换失败");
            return map;
        }
        user.setBirth(date);
        int num = userService.updatePersonalInfo(user);
        if(num!=1){
            map.put("msg","修改用户信息失败");
            return map;
        }
        map.put("msg","success");
        /*重置session*/
        use.setNickname(user.getNickname());
        use.setBirth(date);
        use.setLive(user.getLive());
        use.setSex(user.getSex());
        use.setTellogin(user.getTellogin());
        session.setAttribute("user",use);
        return map;
    }

    /**
     * 用户退出
     */
    @RequestMapping("/userExit")
    public String userExit(HttpSession session){
        session.invalidate();
        return "redirect:/login/view";
    }

    /**
     * 新需求
     */
    @RequestMapping("/toMember_index")
    public String toMember_index(HttpSession session,Model model)
    {
        User user = (User)session.getAttribute("user");
        if(user==null){
            return "redirect:/login/view";
        }
        //地址（修改，显示4条）
        List<Address> addresses=addressService.AddressByUidLimit(user.getId(),4);
        model.addAttribute("address",addresses);

        //用户所有订单（修改，显示6条）
        List<Order> orders=orderService.getLimitOrder(user.getId(),5);
        model.addAttribute("orders",orders);

        return "user/member_index";
    }

    @RequestMapping(value = "/delete/{uid}/{status}" , method = RequestMethod.POST)
    @ResponseBody
    public String user_del(@PathVariable Integer uid,@PathVariable Integer status)
    {
        //status=0 普通删除 , status=1 强制删除

        return userService.userDel(uid,status);
    }

}
