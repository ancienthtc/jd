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

    /*通过用户id查询地址信息*/
    List<Address> AddressByUserIdLimit(@Param("userId") Integer userId,@Param("count") Integer count);

    //通过用户查找地址，首位为默认
    List<Address> FirstMainByUser(@Param("userId") Integer userId);

    //查询非默认
    List<Address> getNotDefault(@Param("userId") Integer userId);

    //查询默认
    Address getDeafult(@Param("userId") Integer userId);

    //地址数目
    int getAddressCount(@Param("userId") Integer userId);

    int setMainToNot(@Param("userId") Integer userId);

    int setMain(@Param("AddressId") Integer addressId);

}