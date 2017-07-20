package com.jd.shop.service;

/**
 * Created by ThinkPad on 2017/7/7.
 */
public interface PictureService {

    //处理picture
    /*
     *  商品图片
     *  1.传入goodsid,查询图片标题(goodsid)是否存在
     *  2.不存在，创建。存在，传入图片参数，放入图片集
     *  3.更新商品属性，(图片集-商品)
     */

    /**
     * @param goodsid:商品id,作为图片集名称 listname
     * @param title:图片标题，是上传图片的名称
     * @param filename:图片路径,是实际地址
     * @param server:图片所在服务器
     * @return
     */
    boolean goodsAndpicture(String goodsid,String title,String filename,String server);

    boolean deleteGoodsPic(String imageid);
}
