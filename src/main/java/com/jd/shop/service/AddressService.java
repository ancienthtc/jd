package com.jd.shop.service;

import com.jd.shop.model.Address;

import java.util.List;

/**
 * Created by ThinkPad on 2017/7/18.
 */
public interface AddressService {
    List<Address> findAddressByUserId(Integer userId);
}
