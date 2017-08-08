package com.jd.shop.dao;

import com.jd.shop.model.Goods;
import com.jd.shop.model.Image;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

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

    List<Map<String,String>> getGoodsByPart(@Param("pid")Integer pid);

    //删除该商品全部信息(多表关联删除)
    int deleteGoodsAll(@Param("id")Integer id);
}