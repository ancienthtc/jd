package com.jd.shop.controller;

import com.alibaba.fastjson.JSON;
import com.jd.shop.annotation.AdminLogin;
import com.jd.shop.annotation.UserLogin;
import com.jd.shop.model.Admin;
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
@RequestMapping("/comment")
public class CommentController {
    
    @Autowired
    private CommentService commentService;

    /*跳转至评价管理页面*/
    @UserLogin
    @RequestMapping("/toCommentList")
    public String toCommentList(){
        return "user/commentList";
    }

    //获取所有商品列表，分页
    @UserLogin
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

    //用户填写评论 遍历商品所在订单评论
    public String comment(String uuid,Integer uid,Integer gid)
    {
        //更新评论


        //遍历


        return "";
    }


    /*
     *  管理员
     */
    @AdminLogin
    @RequestMapping("/toCommentList2")
    public String toCommentList2()
    {
        return "admin/commentlist";
    }

    //获取所有
    @AdminLogin
    @RequestMapping("/getAll")
    @ResponseBody
    public String getAll(Integer pageNumber, Integer pagesize, HttpSession session)
    {
//        Admin a = (Admin) session.getAttribute("admin");
//        if(a==null){
//            return "";
//        }

        PagedResult<Comment> commentList=commentService.getAll(pageNumber,pagesize);
        String json = JSON.toJSONString(commentList);
        return json;
    }

    //删除
    @AdminLogin
    @RequestMapping("/del")
    @ResponseBody
    public String commentDel(Integer id)
    {
        if(commentService.CommentDel(id) > 0)
        {
            return "true";
        }

        return "false";
    }

}
