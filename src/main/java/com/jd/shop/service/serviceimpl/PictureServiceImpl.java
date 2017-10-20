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
import com.mysql.jdbc.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

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

    /**
     * 字节输出流
     */
    private static FileOutputStream fos = null;

    /**
     * 字节输入流
     */
    private static FileInputStream fis = null;

    /**
     * 复制图片
     * @param path 原始路径
     */
    public  boolean copyImg(String path,String newPath) {
        if(StringUtils.isNullOrEmpty(path)||StringUtils.isNullOrEmpty(newPath)){
            throw new RuntimeException("参数不能为空");
        }
        try {
            fos = new FileOutputStream(newPath);//复制文件
            fis = new FileInputStream(path);//源文件
            byte[] buf = new byte[1024];//缓冲区
            int len = 0;
            while ((len = fis.read(buf)) != -1) {
                fos.write(buf, 0, len);//复制
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (fis != null)
                    fis.close();
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }
            try {
                if (fos != null)
                    fos.close();
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }
        }


    }
    





    //给商品添加图片
    public Image goodsAndpicture(String goodsid, String title, String filename, String server) {

        if(filename.equals("")||filename==null || goodsid==null || goodsid.equals(""))
        {
            return null;
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
        //获取id
        image.getId();

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
            return image;
        }
        else
        {
            return null;
        }
    }

    //删除该商品的一张图片,并删除项目路径下的图片
    public boolean deleteGoodsPic(String imageid,String absolutePath) {
        Image image=imageMapper.selectByPrimaryKey( Integer.valueOf(imageid) );
        absolutePath=absolutePath+image.getTitle();
        fileDel(absolutePath);

        if(imageMapper.deleteByPrimaryKey( Integer.parseInt(imageid) ) > 0)
        {
            return true;
        }
        return false;
    }

    //板块添加图片
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
        if( picListMapper.iscreate( picList.getListname() )==null )
        {
            int i=picListMapper.insertSelective(picList);
            if (i<=0)//验证
                x=false;
        }

        Part part=partMapper.selectByPrimaryKey(pid);
        int listid=picListMapper.getid(picList.getListname());//通过图片集名称，获取图片集id

        //检查piclist_part,没有则更新
        if(part.getPiclistPart()==null)
        {
            part.setPiclistPart(listid);
            int i=partMapper.updateByPrimaryKeySelective(part);
            if(i<=0)//验证
                x=false;
        }

        //查看该板块是否已存在图片,已存在就删除
        partPicdel(pid,image.getServer());

        //添加图片数据，(image_list)
        image.setImageList(listid);
        if(imageMapper.insertSelective(image) <=0 )
        {
            x=false;
        }

        return x;
    }

    //板块图片删除
    public boolean partPicdel(Integer pid,String ServerPath)
    {
        //1查找
        Part part=partMapper.selectByPrimaryKey(pid);
        Integer listid=part.getPiclistPart();
        //2所有图片,删除
        List<Image> images=picListMapper.getImagesList(listid);
        if(images.isEmpty())//没有图片删除
        {
            return false;
        }
        for(Image i:images)
        {
            if(  fileDel(ServerPath+i.getTitle())   )//先删文件
            {
                imageMapper.deleteByPrimaryKey(i.getId());//再删数据库
            }
        }
        //最后删集合
        picListMapper.deleteByPrimaryKey(listid);
        return true;
    }

    //项目图片删除
    public boolean fileDel(String absolutePath) {
        //imagePath = request.getSession().getServletContext().getRealPath("/")+ "upload/" + pic;
        File file = new File(absolutePath);
        if (file.exists()){
            return file.delete();
        }else{
            return false;
        }
    }

    @Override
    public boolean goodsDel(Integer gid,String ServerPath) {
        Goods goods=goodsMapper.selectByPrimaryKey(gid);
        Integer goods_list=goods.getPiclistGoods();
        if(goods_list != null)
        {
            List<Image> images=picListMapper.getImagesList(goods_list);
            if(images.isEmpty())//没有图片删除
            {
                return false;
            }
            for(Image i:images)
            {
                if(  fileDel(ServerPath+i.getTitle())   )//先删文件
                {
                    imageMapper.deleteByPrimaryKey(i.getId());//再删数据库
                }
            }
            //最后删集合
            picListMapper.deleteByPrimaryKey(goods_list);
            return true;
        }
        return false;
    }

}
