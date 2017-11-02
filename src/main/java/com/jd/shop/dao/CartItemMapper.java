package com.jd.shop.dao;

import com.jd.shop.model.CartItem;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CartItemMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CartItem record);

    int insertSelective(CartItem record);

    CartItem selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CartItem record);

    int updateByPrimaryKey(CartItem record);

    //new
    List<CartItem> queryItemsByCartID(Integer id);

    CartItem queryByGoods(@Param("gid") Integer gid);

    CartItem queryByGoodsWithUserNormal(@Param("gid") Integer gid,@Param("uid") Integer uid);

    CartItem queryByGoodsWithUserFormat(@Param("gid") Integer gid,@Param("uid") Integer uid,@Param("fid") Integer fid);

    int updateCountOfItem(@Param("gid") Integer gid,@Param("count")Double count,@Param("uid") Integer uid,@Param("fid") Integer fid);

}