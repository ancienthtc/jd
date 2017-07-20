package com.jd.shop.service.serviceimpl;

import com.jd.shop.dao.GoodsMapper;
import com.jd.shop.dao.ImageMapper;
import com.jd.shop.dao.PicListMapper;
import com.jd.shop.model.Goods;
import com.jd.shop.model.Image;
import com.jd.shop.model.PicList;
import com.jd.shop.service.PictureService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by ThinkPad on 2017/7/7.
 */

@Service
public class PictureServiceImpl implements PictureService {

    @Resource
    private PicListMapper picListMapper;

    @Resource
    private ImageMapper imageMapper;

    @Resource
    private GoodsMapper goodsMapper;

    //给商品添加图片
    public boolean goodsAndpicture(String goodsid, String title, String filename, String server) {

        if(filename.equals("")||filename==null || goodsid==null || goodsid.equals(""))
        {
            return false;
        }

        PicList picList = new PicList();
        picList.setListname("goods"+goodsid);   //图片集:商品所对应的图片集的名称为goods+id 如goods1
        //int i=0;
        int j;
        //1.若不存在listname=goodsid,创建图片集 goodsid
        if(picListMapper.iscreate("goods"+goodsid) == null)//不存在
        {
            picListMapper.insertSelective(picList);
        }
        int piclist_id=picListMapper.getid("goods"+goodsid);//get id
        //2.创建image
        Image image=new Image();
        image.setTitle(title);
        image.setFilename(filename);
        image.setServer(server);
        image.setImageList(piclist_id);

        j=imageMapper.insertSelective(image);//添加到图片表

        //3.更新图片集-商品
        //判断商品是否有图片集 有--结束  ， 无--更新
        Goods goods=new Goods();
        //goods.setId( Integer.valueOf(goodsid) );
        goods=goodsMapper.selectByPrimaryKey(Integer.valueOf(goodsid));
        if(goods.getPiclistGoods()==null)
        {
            goods.setPiclistGoods(piclist_id);
            goodsMapper.updateByPrimaryKeySelective(goods);
        }

        if( j!=0 )
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    //删除该商品的一张图片
    public boolean deleteGoodsPic(String imageid) {
        if(imageMapper.deleteByPrimaryKey( Integer.parseInt(imageid) ) > 0)
        {
            return true;
        }
        return false;
    }
}
