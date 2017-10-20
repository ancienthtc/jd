package com.jd.shop.controller;

import com.jd.shop.annotation.UserLogin;
import com.jd.shop.model.Address;
import com.jd.shop.model.User;
import com.jd.shop.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 10593 on 2017/8/8.
 */
@UserLogin
@Controller
@RequestMapping("/address")
public class AddressController {
    @Autowired
    private AddressService addressService;

    /*跳转至收货地址页面*/
    @RequestMapping("/toAddressManager")
    public String toAddressManager(HttpSession session, HttpServletRequest req){
        User user = (User)session.getAttribute("user");
        if(user==null){
            return "login/login";
        }
        List<Address> addresses = addressService.findAddressByUserId(user.getId());
        req.setAttribute("addr",addresses);
        return "user/addressManager";
    }

    /*添加收货地址*/
    @RequestMapping(value="/saveAddress",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> saveAddress(HttpSession session,Address address){
        Map<String,String> map = new HashMap<String, String>();
        /*查询出原来的默认地址*/
        Address add = addressService.findByIsmain(1);
        User user = (User)session.getAttribute("user");
        if(user==null){
            map.put("msg","用户未登录");
            return map;
        }
        address.setUserId(user.getId());
        int num = addressService.saveAddress(address);
        if(num==0){
            map.put("msg","添加收货地址失败");
            return map;
        }
        /*设置默认*/
        if(address.getIsmain()==1&&add!=null){
            add.setIsmain(0);
            int number = addressService.updateByPrimaryKeySelective(add);
            if(number==0){
                map.put("msg","默认地址设置有误");
                return map;
            }
        }
        map.put("msg","success");
        return map;
    }

    /*设置默认收货地址*/
    @RequestMapping(value="/setDefault")
    @ResponseBody
    public Map<String,String> setDefault(Integer id){
        Map<String,String> map = new HashMap<String, String>();
        if(id==null){
            map.put("msg","id不能为空");
            return map;
        }
        Address add = addressService.findByIsmain(1);
        if(add!=null){
            add.setIsmain(0);
            int number = addressService.updateByPrimaryKeySelective(add);
            if(number==0){
                map.put("msg","默认地址设置有误");
                return map;
            }
        }
        Address address = new Address();
        address.setId(id);
        address.setIsmain(1);
        int num = addressService.updateByPrimaryKeySelective(address);
        if(num==0){
            map.put("msg","默认地址设置失败");
            return map;
        }
        map.put("msg","success");
        return map;
    }

    /*删除收货地址*/
    @RequestMapping(value="/deleteAddress")
    @ResponseBody
    public Map<String,String> deleteAddress(Integer id,HttpSession session){
        Map<String,String> map = new HashMap<String, String>();
        if(id==null){
            map.put("msg","收货地址id为空");
            return map;
        }
        Address address = addressService.findById(id);
        if(address==null){
            map.put("msg","无此地址");
            return map;
        }
        if(address.getIsmain()==1){
            map.put("msg","默认地址无法删除,请重新设定默认地址");
            return map;
        }
        //查询是否有该地址订单未发货
        if( addressService.candel(id) )
        {
            int num = addressService.deleteAddress(id);
            if(num==0){
                map.put("msg","地址删除失败");
                return map;
            }
            map.put("msg","success");
            return map;
        }
        map.put("msg","地址正在使用,删除失败");
        return map;
    }

    /**
     * 根据地址id查询地址信息
     * @param id
     * @return
     */
    @RequestMapping(value="/findById")
    @ResponseBody
    public Map<String,Object> findById(Integer id){
        Map<String,Object> map = new HashMap<String, Object>();
        if(id==null){
            map.put("msg","error");
            return map;
        }
        Address address = addressService.findById(id);
        if(address==null){
            map.put("msg","error");
            return map;
        }
        map.put("msg",address);
        return map;
    }

    /**
     * 修改地址
     * @param address
     * @return
     */
    @RequestMapping(value="/updateAddr",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> updateAddr(Address address){
        Map<String,String> map = new HashMap<String, String>();
        if(address==null||address.getId()==null){
            map.put("msg","地址为空");
            return map;
        }
        int num = addressService.updateByPrimaryKeySelective(address);
        if(num==0){
            map.put("msg","地址修改失败");
            return map;
        }
        map.put("msg","success");
        return map;
    }

    /**
     * 新需求
     */

    //地址修改页面
    @RequestMapping("/AddressEdit")
    public String toEditAddress(HttpSession session,Model model)
    {
        User user = (User)session.getAttribute("user");
        if(user==null){
            return "redirect:/login_register";
        }
        model.addAttribute("main",addressService.getDefault(user.getId()));
        model.addAttribute("other",addressService.getNotDefault(user.getId()));

        return "user/member_add_list";
    }

    //增加地址
    @RequestMapping(value="/addNew")
    @ResponseBody
    public String addNew(Address address,HttpSession session)
    {
        User user = (User)session.getAttribute("user");
        if(user==null){
            return "false";
        }
        if( addressService.addAddress(address,user.getId()) )
        {
            return "true";
        }
        else
        {
            return "false";
        }
    }

    //layer 弹出 form
    @RequestMapping("/getAddressForm")
    public String getAddressForm()
    {
        return "user/address_form";
    }

    //layer 弹出 form 编辑
    @RequestMapping("/getEditAddressForm/{id}")
    public String getEditAddressForm(@PathVariable Integer id,Model model)
    {
        model.addAttribute("address",addressService.findById(id) );
        return "user/address_form";
    }

    //执行编辑
    @RequestMapping("/editAddressForm")
    @ResponseBody
    public String editAddressForm(Address address)
    {
        if (addressService.updateByPrimaryKeySelective(address) >0)
        {
            return "true";
        }
        return "false";
    }

    //设置默认
    @RequestMapping("/setDefault/{aid}")
    @ResponseBody
    public String setDefault(@PathVariable Integer aid,HttpSession session)
    {
        User user = (User)session.getAttribute("user");
        if(user==null){
            return "false";
        }
        if( addressService.setDefault(aid,user.getId() ) )
        {
            return "true";
        }
        return "false";
    }



}
