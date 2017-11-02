package com.jd.shop.service.serviceimpl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jd.shop.dao.FormatMapper;
import com.jd.shop.model.Format;
import com.jd.shop.service.FormatService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by ThinkPad on 2017/10/25.
 */
@Service
public class FormatServiceImpl implements FormatService{

    @Resource
    private FormatMapper formatMapper;

    @Override
    public int FormatAdd(Format format) {
        return formatMapper.insertSelective(format);
    }

    @Override
    public List<Format> getGoodsFormat(Integer gid) {
        return formatMapper.getGoodsFormat(gid);
    }

    @Override
    public Format getFormat(Integer fid) {
        return formatMapper.selectByPrimaryKey(fid);
    }

    @Override
    public int delFormat(Integer fid) {
        return formatMapper.deleteByPrimaryKey(fid);
    }

    @Override
    @Transactional
    public int addFormat(String json) {
        JSONObject object = JSON.parseObject(json);
        String goodsFormat=object.getString("goodsFormat");
        String fname=object.getString("fname");
        String fprice=object.getString("fprice");
        String fstock=object.getString("fstock");
        Format format=new Format();
        format.setGoodsFormat( Integer.parseInt(goodsFormat) );
        format.setFname(fname);
        format.setFprice( Double.parseDouble(fprice) );
        format.setFstock( Double.parseDouble(fstock) );
        return formatMapper.insertSelective(format);
    }

    @Override
    public int alterFormat(String json) {
        JSONObject object = JSON.parseObject(json);
        String id=object.getString("id");
        String fname=object.getString("fname");
        String fprice=object.getString("fprice");
        String fstock=object.getString("fstock");
        Format format=new Format();
        format.setId( Integer.parseInt(id) );
        format.setFname(fname);
        format.setFprice( Double.parseDouble(fprice) );
        format.setFstock( Double.parseDouble(fstock) );

        return formatMapper.updateByPrimaryKeySelective(format);
    }

}
