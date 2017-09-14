package com.jd.shop.service;

import com.jd.shop.model.History;
import com.jd.shop.model.History;
import com.jd.shop.util.PagedResult;
import org.springframework.stereotype.Service;

import java.util.List;


/**
 * Created by 10593 on 2017/8/16.
 */

public interface HistoryService {
    List<History> findByUserId(Integer userId);
    void insertSelective(History history);
    int deleteByPrimaryKey(Integer id);
    int deleteByUserId(Integer userId);
    /*f根据用户id分页查询*/
    PagedResult<History> queryByPage(Integer pageNo, Integer pageSize, Integer userId);

    //添加到历史纪录
    int HistoryAdd(Integer uid,Integer gid);
}
