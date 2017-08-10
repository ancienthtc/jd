package com.jd.shop.controller;

import com.alibaba.fastjson.JSON;
import com.jd.shop.model.Comment;
import com.jd.shop.model.User;
import com.jd.shop.service.CommentService;
import com.jd.shop.util.PagedResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * Created by 10593 on 2017/8/10.
 */
@Controller
@RequestMapping("comment")
public class CommentController {
    
    @Autowired
    private CommentService commentService;

    /*跳转至评价管理页面*/
    @RequestMapping("/toCommentList")
    public String toCommentList(){
        return "user/commentList";
    }

    //获取所有商品列表，分页
    @RequestMapping("/commentList")
    @ResponseBody
    public String commentList(Integer pageNumber, Integer pageSize, HttpSession session)
    {
        User user = (User)session.getAttribute("user");
        if(user==null){
            return "";
        }
        PagedResult<Comment> commentList=commentService.queryByPage(pageNumber,pageSize,user.getId());
        String json = JSON.toJSONString(commentList);
        return json;
    }
    
    
}
