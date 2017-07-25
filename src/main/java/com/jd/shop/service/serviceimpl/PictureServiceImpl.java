package com.jd.shop.service.serviceimpl;

import com.jd.shop.dao.GoodsMapper;
import com.jd.shop.dao.ImageMapper;
import com.jd.shop.dao.PartMapper;
import com.jd.shop.dao.PicListMapper;
import com.jd.shop.model.Goods;
import com.jd.shop.model.Image;
import com.jd.shop.model.Part;
import com.jd.shop.model.PicList;
import com.jd.shop.service.PictureService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.File;

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

    @Resource
    private PartMapper partMapper;

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

    //删除该商品的一张图片,并删除项目路径下的图片
    public boolean deleteGoodsPic(String imageid,String absolutePath) {
        if(imageMapper.deleteByPrimaryKey( Integer.parseInt(imageid) ) > 0)
        {
            Image image=imageMapper.selectByPrimaryKey( Integer.valueOf(imageid) );
            absolutePath=absolutePath+image.getTitle();
            fileDel(absolutePath);
            return true;
        }
        return false;
    }

    public boolean partAndpicture(Integer pid, Image image) {
        boolean x=true;
        //检查图片参数
        if(image.getFilename()==null || image.getServer()==null || image.getTitle()==null)
        {
            return false;
        }

        PicList picList=new PicList();
        picList.setListname("part"+pid);

        //1.检查图片集 "part"+id,若不存在就创建
        if(picListMapper.iscreate(picList.getListname())==null)
        {
            int i=picListMapper.insertSelective(picList);
            if (i<=0)
                x=false;
        }

        Part part=partMapper.selectByPrimaryKey(pid);
        int listid=picListMapper.getid(picList.getListname());//通过图片集名称，获取图片集id

        //检查piclist_part,没有则更新
        if(part.getPiclistPart()==null)
        {
            part.setPiclistPart(listid);
            int i=partMapper.updateByPrimaryKeySelective(part);
            if(i<=0)
                x=false;
        }

        //添加图片数据，(image_list)
        image.setImageList(listid);
        if(imageMapper.insertSelective(image) <=0 )
        {
            x=false;
        }

        return x;
    }

    public void fileDel(String absolutePath) {
        //imagePath = request.getSession().getServletContext().getRealPath("/")+ "upload/" + pic;
        File file = new File(absolutePath);
        if (file.exists()) {
            file.delete();
        }
    }
}
