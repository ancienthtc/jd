package com.jd.shop.service.serviceimpl;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.jd.shop.dao.GoodsMapper;
import com.jd.shop.dao.PicListMapper;
import com.jd.shop.model.Goods;
import com.jd.shop.model.Image;
import com.jd.shop.service.GoodsService;
import com.jd.shop.service.PictureService;
import com.jd.shop.util.BeanUtil;
import com.jd.shop.util.PagedResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Calendar;
import java.util.List;

/**
 * Created by ThinkPad on 2017/7/7.
 */
@Service
public class GoodsServiceImpl implements GoodsService {

    @Autowired
    private PictureService pictureService;

    @Resource
    private GoodsMapper goodsMapper;

    @Resource
    private PicListMapper picListMapper;

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
    public Goods addGoods(Goods goods) {
        goods.setSales(0.0);
        goodsMapper.insertSelective(goods);

        return goods;
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
        //下架条件
        return goodsMapper.goodsunder(goodsid);
    }

    //商品删除(listname:"goods"+id)
    public int goodsDel(Integer goodsid,String ServerPath) {

        //删除条件:下架
        if( goodsMapper.select_under(goodsid) !=null )//已下架
        {
            //查询该商品的list  lisename: "goods"+id

            //删除该商品所有图片
            //转至PictureService处理
            pictureService.goodsDel(goodsid,ServerPath);//删图片

            //return goodsMapper.deleteGoodsAll(goodsid);
            return goodsMapper.deleteByPrimaryKey(goodsid);
        }

        return 0;
    }

    public List<Image> getGoodsImgs(Integer piclist) {
        return picListMapper.getImagesList(piclist);
    }

    @Override
    public List<Goods> getAllGoods() {
        return goodsMapper.getAllGoods(null);
    }

    @Override
    public List<Goods> search(String key) {
        //搜索优先
        //1.名称

        //2.参数

        //3.详情

        return goodsMapper.search_all(key);
    }

    /**
     * 以下新需求
     */
    //新商品
    @Override
    public List<Goods> new_goods(int index,int end) {
        //end>index true
        if(index>end)
        {
            index ^= end;
            end ^= index;
            index ^= end;
        }
        else if(index==end)
        {
            index=0;
            end=0;
        }

        return goodsMapper.new_goods(index,end);
    }

    //热销
    @Override
    public List<Goods> GoodSale() {
        return goodsMapper.hot_goods();
    }

    @Override
    public Goods getGoodsInfo(Integer goodsid) {
        return goodsMapper.getInfo(goodsid);
    }


    @Override
    public PagedResult<Goods> goodsByPage(Integer pageNo, Integer pageSize,String[] key) {
        pageNo = pageNo == null?1:pageNo;
        pageSize = pageSize == null?12:pageSize;
        PageHelper.startPage(pageNo,pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。
        return BeanUtil.toPagedResult(goodsMapper.getAllGoods(key));
    }

    /*
     * 前一页:     type(1) + pid + pageNo + pageSize(12) + pages + total + min + max + key   pageNo-1>1       min<max
     * 后一页:     type(2) + pid + pageNo + pageSize(12) + pages + total + min + max + key   pageNo+1<pages   min<max
     * 第 N 页:    type(3) + pid + pageNo + pageSize(12) + pages + total + min + max + key   pageNo=N         min<max
     * 直接帅选:   type(4) + pid + pageNo + pageSize(12) + pages + total + min + max   min<max
     * Sales :     type(5) + pid + pageNo + pageSize(12) + pages + total + min + max   排序             min<max
     * News  :     type(6) + pid + pageNo + pageSize(12) + pages + total + min + max   排序             min<max
     */
    @Override
    public PagedResult<Goods> goodsByPageSelect(JSONObject object) {
        String type=object.getString("type");
        String pid=object.getString("pid");
        Integer pageNo=Integer.parseInt( object.getString("pageNo") );
        Integer pageSize=Integer.parseInt(object.getString("pageSize") );
        Integer pages=Integer.parseInt(object.getString("pages") );
        Integer total=Integer.parseInt(object.getString("total") );
        String end=object.getString("max");
        String index=object.getString("min");

        String key=object.getString("key");
        String[] keys;
        if(key.equalsIgnoreCase("null") || key.length()<=0)
        {
            keys=null;
        }
        else
        {
            keys=key.split("\\s+");
        }

        Integer part;
        Double min=null;
        Double max=null;
        if(pid.equalsIgnoreCase("null") || pid.length()<=0 )
        {
            part=null;
        }
        else
        {
            part=Integer.parseInt(pid);
        }
        if(end.length()>0 && index.length()>0)
        {
            min=Double.parseDouble(index);
            max=Double.parseDouble(end);
            if( min > max )
            {
                double t=min;
                min=max;
                max=t;
            }
        }
        else if(end.length()>0 && index.length()<=0)
        {
            min=null;
            max=Double.parseDouble(end);
        }
        else if(end.length()<=0 && index.length()>0)
        {
            min=Double.parseDouble(index);
            max=null;
        }

        List<Goods> goodss;
        switch ( Integer.parseInt(type) )
        {
            case 1://前一页
                if(pageNo-1>=1)
                {
                    PageHelper.startPage(pageNo-1,pageSize);
                    return BeanUtil.toPagedResult(goodsMapper.GoodsShow(part,min,max,keys));
                }
                break;
            case 2://后一页
                if(pageNo+1<=pages)
                {
                    PageHelper.startPage(pageNo+1,pageSize);
                    return BeanUtil.toPagedResult(goodsMapper.GoodsShow(part,min,max,keys));
                }
                break;
            case 3://第n页
                PageHelper.startPage(pageNo,pageSize);
                return BeanUtil.toPagedResult(goodsMapper.GoodsShow(part,min,max,keys));

            case 4://直接帅选
                PageHelper.startPage(1,pageSize);
                return BeanUtil.toPagedResult(goodsMapper.GoodsShow(part,min,max,null));

            case 5://Sales

            case 6://News
        }

        return null;
    }



}
