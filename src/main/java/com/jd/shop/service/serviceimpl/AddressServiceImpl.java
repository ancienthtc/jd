package com.jd.shop.service.serviceimpl;

import com.jd.shop.dao.AddressMapper;
import com.jd.shop.model.Address;
import com.jd.shop.service.AddressService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 10593 on 2017/8/8.
 */
@Service
public class AddressServiceImpl implements AddressService {

    @Resource
    private AddressMapper addressMapper;

    public List<Address> findAddressByUserId(Integer userId){

        return addressMapper.findAddressByUserId(userId);
    }

    public int saveAddress(Address address) {
        return addressMapper.insertSelective(address);
    }

    public Address findByIsmain(Integer ismain) {
        return addressMapper.findByIsmain(ismain);
    }

    public int updateByPrimaryKeySelective(Address address) {
        return addressMapper.updateByPrimaryKeySelective(address);
    }

}
