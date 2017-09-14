package com.jd.shop.service.serviceimpl;

import com.github.pagehelper.PageHelper;
import com.jd.shop.dao.CommentMapper;
import com.jd.shop.model.Comment;
import com.jd.shop.service.CommentService;
import com.jd.shop.util.BeanUtil;
import com.jd.shop.util.PagedResult;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 10593 on 2017/8/10.
 */
@Service
public class CommentServiceImpl implements CommentService {

    @Resource
    private CommentMapper commentMapper;

    public List<Comment> findByUserId(Integer userId) {

        return commentMapper.findByUserId(userId);
    }


    //分页
    public PagedResult<Comment> queryByPage(Integer pageNo, Integer pageSize,Integer userId) {
        pageNo = pageNo == null ? 1 : pageNo;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNo, pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。
        return BeanUtil.toPagedResult(commentMapper.findByUserId(userId));
    }

    //获取所有
    @Override
    public PagedResult<Comment> getAll(Integer pageNo, Integer pageSize) {
        pageNo = pageNo == null ? 1 : pageNo;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNo, pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。
        List<Comment> comments=commentMapper.getAll();

        return BeanUtil.toPagedResult(comments);
    }

    @Override
    public int CommentDel(Integer id) {
        return commentMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<Comment> getGoodsComment(Integer gid) {
        return commentMapper.getGoodsComment(gid);
    }
}
