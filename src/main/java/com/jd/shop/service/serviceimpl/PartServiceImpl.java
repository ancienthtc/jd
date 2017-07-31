package com.jd.shop.service.serviceimpl;

import com.github.pagehelper.PageHelper;
import com.jd.shop.dao.PartMapper;
import com.jd.shop.dao.PicListMapper;
import com.jd.shop.model.Goods;
import com.jd.shop.model.Image;
import com.jd.shop.model.Part;
import com.jd.shop.service.PartService;
import com.jd.shop.service.PictureService;
import com.jd.shop.util.BeanUtil;
import com.jd.shop.util.PagedResult;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by ThinkPad on 2017/7/11.
 */

@Service
public class PartServiceImpl implements PartService{

    @Resource
    private PartMapper partMapper;

    @Resource
    private PictureService pictureService;

    @Resource
    private PicListMapper picListMapper;

    //所有板块
    public List<Part> getAll() {
        return partMapper.getAll();
    }

    //板块添加
    public int partadd(Part part) {
        //return partMapper.insertSelective(part);
        return partMapper.addpart(part.getPname(),part.getType(),part.getPriority(),part.getDescribe());
    }

    //首页板块/商品图片
    public List<Map<String, String>> getAllInfo() {
        return partMapper.shophome();
    }

    //板块下所有商品
    public List<Goods> partGoods(Integer id) {
        return partMapper.getPartGoods(id);
    }

    //板块分页查询所有
    public PagedResult<Part> queryByPage(Integer pageNo, Integer pageSize) {
        pageNo = pageNo == null?1:pageNo;
        pageSize = pageSize == null?10:pageSize;
        PageHelper.startPage(pageNo,pageSize);  //startPage是告诉拦截器说我要开始分页了。分页参数是这两个。

        return BeanUtil.toPagedResult(partMapper.getAll());
    }

    public int partAlter(Part part) {
        if(part.getPriority()>10 || part.getPriority()<0)
        {
            part.setPriority(0);
        }
        return partMapper.updateByPrimaryKeySelective(part);
    }

    public Part selectByPrimaryKey(Integer id) {
        return partMapper.selectByPrimaryKey(id);
    }


    //删除板块(并删除图片)
    public boolean partDel(Integer id,String ServerPath)
    {
        pictureService.partPicdel(id,ServerPath);//删图片
        //删图片集
        picListMapper.deleteByPrimaryKey( partMapper.selectByPrimaryKey(id).getPiclistPart() );
        if(partMapper.deleteByPrimaryKey(id) >0)//删板块
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    //获取板块所有图片
    public List<Image> getAllPic(Integer pid) {
        List<Image> image=partMapper.getPartPic(pid);
        return image;
    }

}
