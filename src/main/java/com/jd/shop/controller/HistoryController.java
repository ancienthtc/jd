package com.jd.shop.controller;

import com.alibaba.fastjson.JSON;
import com.jd.shop.model.History;
import com.jd.shop.model.History;
import com.jd.shop.model.User;
import com.jd.shop.service.HistoryService;
import com.jd.shop.util.PagedResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 10593 on 2017/8/16.
 */
@Controller
@RequestMapping("/hitory")
public class HistoryController {

    @Autowired
    private HistoryService historyService;

    /**
     * 跳转至用户历史记录页面(根据用户id查找其历史记录)
     * @param session
     * @return
     */
    @RequestMapping("/toHistoryPage")
    public String toHistoryPage(HttpSession session){
        User user = (User)session.getAttribute("user");
        if(user==null){
            return "redirect:/user/view";
        }
        return "此处放历史页面的jsp";
    }


    /**
     * 跳转至用户历史记录页面  分页  (根据用户id查找其历史记录)
     * @param session
     * @return
     */
    @RequestMapping("/historyList")
    @ResponseBody
    public String historyList(Integer pageNumber, Integer pageSize, HttpSession session)
    {
        User user = (User)session.getAttribute("user");
        if(user==null){
            return "";
        }
        PagedResult<History> historyList=historyService.queryByPage(pageNumber,pageSize,user.getId());
        String json = JSON.toJSONString(historyList);
        return json;
    }

    /**
     * 删除历史记录
     * @param historyId
     * @return
     */
    @RequestMapping("/deleteByPrimaryKey")
    @ResponseBody
    public Map<String,String> deleteByPrimaryKey(Integer historyId){
        Map<String,String> map = new HashMap<String, String>();
        if(historyId==null){
            map.put("msg","历史记录id为空");
            return map;
        }
        int num = historyService.deleteByPrimaryKey(historyId);
        if(num==0){
            map.put("msg","删除历史记录失败");
            return map;
        }
        map.put("msg","success");//页面判断msg是否为"success"
        return map;
    }

    /**
     * 删除该用户所有历史记录
     * @param session
     * @return
     */
    @RequestMapping("/deleteByUserId")
    @ResponseBody
    public Map<String,String> deleteByUserId(HttpSession session){
        Map<String,String> map = new HashMap<String, String>();
        User user = (User)session.getAttribute("user");
        if(user==null){
            map.put("msg","请重新登录");
            return map;
        }
        int num = historyService.deleteByUserId(user.getId());
        if(num==0){
            map.put("msg","删除历史记录失败");
            return map;
        }
        map.put("msg","success");//页面判断msg是否为"success"
        return map;
    }




}
