package com.jd.shop.dao;

import com.jd.shop.model.Format;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FormatMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Format record);

    int insertSelective(Format record);

    Format selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Format record);

    int updateByPrimaryKey(Format record);

    List<Format> getGoodsFormat(@Param("gid") Integer gid);

    int updateStock(@Param("amount") Double amount,@Param("gid") Integer gid );

    int updateSales(@Param("amount") Double amount,@Param("gid") Integer gid);
}