package com.jd.shop.service;

import com.jd.shop.model.Address;
import com.jd.shop.model.User;

import java.util.List;

/**
 * Created by ThinkPad on 2017/7/18.
 */
public interface AddressService {
    List<Address> findAddressByUserId(Integer userId);

    List<Address> AddressByUidLimit(Integer uid,Integer count);

    int saveAddress(Address address);

    Address findByIsmain(Integer inmain);

    int updateByPrimaryKeySelective(Address address);

    /*删除地址*/
    int deleteAddress(Integer id);

    Address findById(Integer id);

    //首位地址是默认地址
    List<Address> FirstMainByUser(Integer userId);

    boolean candel(Integer aid);

    //默认
    Address getDefault(Integer userId);
    //非默认
    List<Address> getNotDefault(Integer userId);
    //新增地址
    boolean addAddress(Address address, Integer uid);
    //设置默认地址
    boolean setDefault(Integer aid,Integer uid);

}
