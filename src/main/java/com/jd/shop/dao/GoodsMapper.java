package com.jd.shop.dao;

import com.jd.shop.model.Goods;
import com.jd.shop.model.Image;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GoodsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Goods record);

    int insertSelective(Goods record);

    Goods selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Goods record);

    int updateByPrimaryKey(Goods record);

    //new
    List<Goods> getAll();

    List<Image> getgoodspic(@Param("goodsid")Integer goodsid);

    int goodsunder(@Param("goodsid")Integer goodsid);

    List<Goods> getOther();
}