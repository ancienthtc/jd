package com.jd.shop.service;

import com.jd.shop.model.Comment;
import com.jd.shop.util.PagedResult;

import java.util.List;

/**
 * Created by 10593 on 2017/8/10.
 */
public interface CommentService {
    List<Comment> findByUserId(Integer userId);

    /*f根据用户id分页查询*/
    PagedResult<Comment> queryByPage(Integer pageNo, Integer pageSize,Integer userId);
}
