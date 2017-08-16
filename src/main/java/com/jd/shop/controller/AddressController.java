package com.jd.shop.controller;

import com.jd.shop.model.Address;
import com.jd.shop.model.User;
import com.jd.shop.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
        int num = addressService.deleteAddress(id);
        if(num==0){
            map.put("msg","地址删除失败");
            return map;
        }
        map.put("msg","success");
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
}
