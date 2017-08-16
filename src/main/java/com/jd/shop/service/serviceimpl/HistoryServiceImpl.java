package com.jd.shop.service.serviceimpl;

import com.github.pagehelper.PageHelper;
import com.jd.shop.dao.HistoryMapper;
import com.jd.shop.model.History;
import com.jd.shop.model.History;
import com.jd.shop.service.HistoryService;
import com.jd.shop.util.BeanUtil;
import com.jd.shop.util.PagedResult;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 10593 on 2017/8/16.
 */
@Service
public class HistoryServiceImpl implements HistoryService {

    @Resource
    private HistoryMapper historyMapper;

    public List<History> findByUserId(Integer userId) {
        return historyMapper.findByUserId(userId);
    }

    public void insertSelective(History history) {
        historyMapper.insertSelective(history);
    }

    public int deleteByPrimaryKey(Integer id) {
        return historyMapper.deleteByPrimaryKey(id);
    }

    public int deleteByUserId(Integer userId) {
        return historyMapper.deleteByUserId(userId);
    }

    //分页
    public PagedResult<History> queryByPage(Integer pageNo, Integer pageSize, Integer userId) {
        pageNo = pageNo == null ? 1 : pageNo;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNo, pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。
        return BeanUtil.toPagedResult(historyMapper.findByUserId(userId));
    }
}
