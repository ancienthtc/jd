package com.jd.shop.dao;

import com.jd.shop.model.History;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HistoryMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(History record);

    int insertSelective(History record);

    History selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(History record);

    int updateByPrimaryKey(History record);

    List<History> findByUserId(@Param("userId") Integer userId);

    int deleteByUserId(@Param("userId")Integer userId);

}