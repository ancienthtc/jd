package com.jd.shop.service;

import com.jd.shop.model.Address;

import java.util.List;

/**
 * Created by ThinkPad on 2017/7/18.
 */
public interface AddressService {
    List<Address> findAddressByUserId(Integer userId);

    int saveAddress(Address address);

    Address findByIsmain(Integer inmain);

    int updateByPrimaryKeySelective(Address address);

    /*删除地址*/
    int deleteAddress(Integer id);

    Address findById(Integer id);
}
