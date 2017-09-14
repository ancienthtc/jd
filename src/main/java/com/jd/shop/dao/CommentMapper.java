package com.jd.shop.dao;

import com.jd.shop.model.Comment;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Comment record);

    int insertSelective(Comment record);

    Comment selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Comment record);

    int updateByPrimaryKey(Comment record);

    /*根据用户id查询*/
    List<Comment> findByUserId(@Param("userId") Integer userId);

    //new
    //全部评论
    List<Comment> getAll();

    //获取商品评论
    List<Comment> getGoodsComment(@Param("gid") Integer gid);

}