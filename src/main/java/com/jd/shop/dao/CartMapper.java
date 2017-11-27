package com.jd.shop.dao;

import com.jd.shop.model.Cart;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface CartMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Cart record);

    int insertSelective(Cart record);

    Cart selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Cart record);

    int updateByPrimaryKey(Cart record);

    //new
    //查询购物车
    Cart selectCartByUser(@Param("userid") Integer uid);

    int delCartByUserIsDel(@Param("userid") Integer uid);

    List<Map<String,Object>> cartitem(@Param("userid") Integer uid);

    //新需求
    //查询规格是否为空


    int clearCart(@Param("uid") Integer uid);
}