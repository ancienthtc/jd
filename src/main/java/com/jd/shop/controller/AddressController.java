package com.jd.shop.controller;

import com.jd.shop.model.Address;
import com.jd.shop.model.User;
import com.jd.shop.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
}
