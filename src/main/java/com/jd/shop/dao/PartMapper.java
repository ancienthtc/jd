package com.jd.shop.dao;

import com.jd.shop.model.Goods;
import com.jd.shop.model.Image;
import com.jd.shop.model.Part;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface PartMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Part record);

    int insertSelective(Part record);

    Part selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Part record);

    int updateByPrimaryKey(Part record);

    //new
    List<Part> getAll();
    
    int addpart(@Param("pname")String pname , @Param("type")String type, @Param("priority")int priority, @Param("describe")String describe);

    List<Map<String,String>> shophome();

    List<Goods> getPartGoods(Integer id);

    List<Image> getPartPic(@Param("id")Integer pid);
}