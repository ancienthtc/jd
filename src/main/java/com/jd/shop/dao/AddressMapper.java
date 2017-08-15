package com.jd.shop.dao;

import com.jd.shop.model.Address;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AddressMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Address record);

    int insertSelective(Address record);

    Address selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Address record);

    int updateByPrimaryKey(Address record);

    /*通过用户id查询地址信息*/
    List<Address> findAddressByUserId(@Param("userId") Integer userId);

    /*查询出默认地址*/
    Address findByIsmain(@Param("ismain") Integer ismain);
}