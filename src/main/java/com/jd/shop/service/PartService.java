package com.jd.shop.service;

import com.jd.shop.model.Goods;
import com.jd.shop.model.Image;
import com.jd.shop.model.Part;
import com.jd.shop.util.PagedResult;

import java.util.List;
import java.util.Map;

/**
 * Created by ThinkPad on 2017/7/11.
 */

public interface PartService {
    List<Part> getAll();

    int partadd(Part part);

    List<Map<String,String>> getAllInfo();

    List<Goods> partGoods(Integer id);

    PagedResult<Part> queryByPage(Integer pageNo, Integer pageSize);

    int partAlter(Part part);

    Part selectByPrimaryKey(Integer id);

    boolean partDel(Integer id,String ServerPath);

    List<Image> getAllPic(Integer pid);

    List<Map<String,String>> getGoodsByPart(Integer pid);

    //新需求
    List<Part> getIndexParts();
}
