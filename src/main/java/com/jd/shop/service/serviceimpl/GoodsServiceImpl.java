package com.jd.shop.service.serviceimpl;

import com.github.pagehelper.PageHelper;
import com.jd.shop.dao.GoodsMapper;
import com.jd.shop.model.Goods;
import com.jd.shop.model.Image;
import com.jd.shop.service.GoodsService;
import com.jd.shop.util.BeanUtil;
import com.jd.shop.util.PagedResult;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Calendar;
import java.util.List;

/**
 * Created by ThinkPad on 2017/7/7.
 */
@Service
public class GoodsServiceImpl implements GoodsService {

    @Resource
    private GoodsMapper goodsMapper;

    //全部商品
    public List<Goods> getAll()
    {
        return goodsMapper.getAll();
    }

    //全部商品 分页

    //分页
    public PagedResult<Goods> queryByPage(Integer pageNo, Integer pageSize) {
        pageNo = pageNo == null?1:pageNo;
        pageSize = pageSize == null?10:pageSize;
        PageHelper.startPage(pageNo,pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。
        return BeanUtil.toPagedResult(goodsMapper.getAll());
    }

    //获取某个商品的所有图片
    public List<Image> getGoodsPic(int goodsid) {
        return goodsMapper.getgoodspic(goodsid);
    }


    //添加商品(未上架，把销量设为0)
    public int addGoods(Goods goods) {
        goods.setSales(0.0);
        return goodsMapper.insertSelective(goods);
    }

    //获得某商品所有信息
    public Goods getGoods(int goodsid) {
        return goodsMapper.selectByPrimaryKey(goodsid);
    }

    //商品上架
    public int goodsLoad(Goods goods) {
        Calendar calendar = Calendar.getInstance();
        java.util.Date date =calendar.getTime();
        goods.setShelf(date);
        return goodsMapper.updateByPrimaryKeySelective(goods);
    }

    //商品修改
    public int goodsAlter(Goods goods) {
        if(goods.getShelf() != null  )
        {
            if (goods.getStock() <= 0)
            {
                goods.setStock(0.0);
            }
        }

        return goodsMapper.updateByPrimaryKeySelective(goods);
    }

    //商品下架
    public int goodsunder(int goodsid) {
        return goodsMapper.goodsunder(goodsid);
    }

    //商品删除(listname:"goods"+id)
    public int goodsDel(Integer goodsid) {
        return goodsMapper.deleteGoodsAll(goodsid);
    }

}
