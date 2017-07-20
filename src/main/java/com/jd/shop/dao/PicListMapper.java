package com.jd.shop.dao;

import com.jd.shop.model.PicList;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface PicListMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(PicList record);

    int insertSelective(PicList record);

    PicList selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(PicList record);

    int updateByPrimaryKey(PicList record);

    //new
    String iscreate(@Param("listname")String litname);//返回1

    int getid(@Param("listname")String listname);//返回id

}