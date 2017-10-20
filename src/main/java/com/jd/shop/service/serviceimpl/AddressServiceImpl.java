package com.jd.shop.service.serviceimpl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jd.shop.dao.AddressMapper;
import com.jd.shop.dao.OrderMapper;
import com.jd.shop.model.Address;
import com.jd.shop.model.Order;
import com.jd.shop.service.AddressService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 10593 on 2017/8/8.
 */
@Service
public class AddressServiceImpl implements AddressService {

    @Resource
    private AddressMapper addressMapper;

    @Resource
    private OrderMapper orderMapper;

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

    /*删除地址*/
    public int deleteAddress(Integer id) {
        return addressMapper.deleteByPrimaryKey(id);
    }

    public Address findById(Integer id) {
        return addressMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Address> AddressByUidLimit(Integer uid, Integer count) {
        return addressMapper.AddressByUserIdLimit(uid,count);
    }

    @Override
    public List<Address> FirstMainByUser(Integer userId) {
        return addressMapper.FirstMainByUser(userId);
    }

    @Override
    public boolean candel(Integer aid) {
        Address address=addressMapper.selectByPrimaryKey(aid);
        //查找该用户所有 未发货/未收货 的订单
        List<Order> maybeList=orderMapper.getNoSend(address.getUserId());
        for (Order o:maybeList)
        {
            JSONObject object= JSON.parseObject(o.getDetail());
            if( object.get("aid") == aid.toString() )
            {
                return false;
            }
        }
        return true;
    }

    //默认
    @Override
    public Address getDefault(Integer userId) {
        return addressMapper.getDeafult(userId);
    }

    //非默认
    @Override
    public List<Address> getNotDefault(Integer userId) {
        return addressMapper.getNotDefault(userId);
    }

    @Override
    public boolean addAddress(Address address, Integer uid) {
        int count=addressMapper.getAddressCount(uid);
        //查找用户地址数量  <1 设默认  >1 <6  可增加
        if(count <1)
        {
            address.setIsmain(1);
            address.setUserId(uid);
            if(addressMapper.insertSelective(address) > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        else if( count <6 && count>=1 )
        {
            address.setIsmain(0);
            address.setUserId(uid);
            if(addressMapper.insertSelective(address) > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        return false;
    }

    @Override
    @Transactional
    public boolean setDefault(Integer aid, Integer uid) {
        if( addressMapper.setMainToNot(uid)>0 && addressMapper.setMain(aid)>0)
        {
            return true;
        }
        return false;
    }
}
