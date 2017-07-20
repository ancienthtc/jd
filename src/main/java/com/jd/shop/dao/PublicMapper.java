package com.jd.shop.dao;

import com.jd.shop.model.Public;

public interface PublicMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Public record);

    int insertSelective(Public record);

    Public selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Public record);

    int updateByPrimaryKey(Public record);
}