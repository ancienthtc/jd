package com.jd.shop.dao;

import com.jd.shop.model.Image;
import com.jd.shop.model.PicList;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

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

    //返回一个图片集下所有图片
    List<Image> getImagesList(@Param("listid") Integer id);
}