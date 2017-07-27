package com.jd.shop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jd.shop.model.Goods;
import com.jd.shop.model.Image;
import com.jd.shop.model.Part;
import com.jd.shop.service.GoodsService;
import com.jd.shop.service.PartService;
import com.jd.shop.service.PictureService;
import com.jd.shop.util.PagedResult;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.*;

/**
 * Created by ThinkPad on 2017/7/7.
 */

@Controller
@RequestMapping("/goods")
public class GoodsController extends BaseController{

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private HttpServletRequest request;

    @Autowired
    private PictureService pictureService;

    @Autowired
    private PartService partService;

    //添加商品
    @RequestMapping(value = "/add" , method = RequestMethod.POST  /*, produces = "application/json"*/ )
    @ResponseBody
    public Map<String,String> addGoods(@RequestBody Goods goods)
    {
        Map<String ,String> map=new HashMap<String, String>();
        if(goods.getName()==null || goods.getPrice()==null || goods.getParameter1()==null)
        {
            return null;
        }
        if(goodsService.addGoods(goods) > 0)
        {
            map.put("success","true");
            return map;//true
        }
        else
        {
            return null;
        }
    }

    //进入商品修改
    @RequestMapping("/goodsalter/{goodsid}")
    public String goGoodsAlter(@PathVariable Integer goodsid , Model model)
    {
        Goods goods=new Goods();
        //获取商品信息
        goods=goodsService.getGoods(goodsid);
        model.addAttribute("goods",goods);
        //获取板块信息
        List<Part> parts=partService.getAll();
        model.addAttribute("parts",parts);
        return "admin/goodsalter";
    }

    //商品修改(ajax)
    @RequestMapping(value = "/update" , method = RequestMethod.POST  )
    @ResponseBody
    public Map<String,String> updateGoods(@RequestBody Goods goods)
    {
        Map<String ,String> map=new HashMap<String, String>();
        System.out.println(goods);
        if(goods.getName()==null || goods.getPrice()==null || goods.getParameter1()==null)
        {
            return null;
        }
        if(goodsService.goodsAlter(goods) > 0)
        {
            map.put("success","true");
            return map;//true
        }
        else
        {
            return null;
        }
    }

    //获取所有商品列表
    @RequestMapping("/listpage")
    public String getgoddslist(Model model)
    {
       /*List<Goods> goodslist=goodsService.getAll();
        model.addAttribute("goodslist",goodslist);*/

        return "admin/goodslist";
    }

    //获取所有商品列表，分页
    @RequestMapping("/goodslist")
    @ResponseBody
    public String getListPage(Integer pageNumber,Integer pageSize ,Model model)
    {
        PagedResult<Goods> goodslist=goodsService.queryByPage(pageNumber,pageSize);
        model.addAttribute("goodslist",goodslist);
        String json = JSON.toJSONString(goodslist);
        return json;
    }

    //获取板块商品



    //进入商品上架
    @RequestMapping("/goodsload/{goodsid}")
    public String togoodsload(@PathVariable Integer goodsid,Model model)
    {
        Goods goods=new Goods();
        //获取商品信息
        goods=goodsService.getGoods(goodsid);
        model.addAttribute("goods",goods);
        //获取板块信息
        List<Part> parts=partService.getAll();
        model.addAttribute("parts",parts);
        return "admin/goodsload";
    }

    //商品上架
    @RequestMapping(value = "/goodsload" , method = RequestMethod.POST)
    public String goodsload(HttpServletRequest request,Model model)
    {
        Goods goods=new Goods();
        goods.setId( Integer.parseInt(request.getParameter("goodsid")) );
        goods.setStock( Double.valueOf(request.getParameter("stock")) );
        goods.setPartGoods( Integer.parseInt(request.getParameter("partid")) );

        if(goods.getId()==null || goods.getStock()==null || goods.getPartGoods()==null)
        {
            model.addAttribute("message","上架失败,不能为空");
        }
        else
        {
            //save
            if(goodsService.goodsLoad(goods)>0)
            {
                model.addAttribute("message","上架成功");
            }
            else
            {
                model.addAttribute("message","上架失败,数值错误");
            }
        }
        return "redirect:/goods/goodslist";
    }

    //商品下架  (shelf)
    @RequestMapping("/under/{goodsid}")
    public String goodsunder(@PathVariable Integer goodsid,Model model)
    {
        if(goodsService.goodsunder(goodsid) > 0 )
        {
            model.addAttribute("message","下架完成");
        }
        else
        {
            model.addAttribute("message","下架失败");
        }
        return "redirect:/goods/goodslist";
    }


    //商品删除
    @RequestMapping("goodsdel")
    @ResponseBody
    public String goodsdel(Integer id)
    {
        if(goodsService.goodsDel(id) > 0) {
            return "Success";
        }
        else
            return "Fail";
    }

    //获取图片地址
    @RequestMapping("getGoodsPic/{goodsid}")
    public String getPic(@PathVariable Integer goodsid , Model model)
    {
        List<Image> list=goodsService.getGoodsPic(goodsid);
        model.addAttribute("piclist",list);//图片列表
        model.addAttribute("goodsid",goodsid);//商品号
        return "admin/goodspic";
    }

    //选择商品上传图片(跳转)
    @RequestMapping("/idupload")
    public String gouploadpic(HttpServletRequest request,Model model,String id)
    {
        //String id=request.getParameter("id");//商品id
        model.addAttribute("goodsid",id);
        return "admin/goodsupload";
    }

    //商品图片上传
    @RequestMapping("/goodsUpload/{goodsid}")
    public String goodsUpload(@PathVariable String goodsid , @RequestParam("file") MultipartFile file) {
        // 判断文件是否为空
        String filePath=null;
        //System.out.println(goodsid);
        Calendar now = Calendar.getInstance();//日期
        String uuid = UUID.randomUUID().toString();//UUID

        String title=uuid +"."+file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);

        if (!file.isEmpty()) {
            try {
                // 文件保存路径
                filePath = request.getSession().getServletContext().getRealPath("/") + "upload/" + //file.getOriginalFilename();
                /*now.getTimeInMillis()*/ title;
                // 转存文件
                file.transferTo(new File(filePath));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        //处理id 和 路径
        //存储图片路径 filePath,图片标题 file.getOriginalFilename() , 服务器地址 request.getSession().getServletContext().getRealPath("/")+"upload"
        //创建图片集 名称 goodsid
        // pictureservice --> insert 图集  insert 图片
        String serverPath=request.getSession().getServletContext().getRealPath("/") + "upload";
        boolean isSuccess=pictureService.goodsAndpicture(goodsid,title,filePath,serverPath);
        request.setAttribute("upmessage",isSuccess);

        // 重定向
        return "redirect:/goods/list";
    }

    /***
     * 读取上传文件中得所有文件并返回
     * @return
     */
    @RequestMapping("list")
    public ModelAndView list() {
        String filePath = request.getSession().getServletContext().getRealPath("/") + "upload/";
        ModelAndView mav = new ModelAndView("redirect:/goods/goodslist");
        File uploadDest = new File(filePath);
        String[] fileNames = uploadDest.list();
        for (int i = 0; i < fileNames.length; i++) {
            //打印出文件名
            System.out.println(fileNames[i]);
        }
        return mav;
    }
    //商品图片上传 ^^^^^^


    //商品图片删除   (ajax)//刷新问题
    @RequestMapping("/deletepic_json")   //goodsid?
    //@ResponseBody
    public String deletePic(@RequestBody String json,Model model)
    {
        JSONObject date=new JSONObject( JSONObject.parseObject(json)  );
        String imageid=date.getString("id");
        String goodsid=date.getString("goodsid");

        String absolutePath=request.getSession().getServletContext().getRealPath("/")+ "upload/";

        if(pictureService.deleteGoodsPic(imageid,absolutePath))
        {

            return "goods/getGoodsPic/"+goodsid;
        }
        else
        {
            return "admin/goodsupload";
        }
    }

    @RequestMapping("/deletepic")   //goodsid?
    //@ResponseBody
    public String deletePic(String goodsid,String imageid,Model model)
    {

        String absolutePath=request.getSession().getServletContext().getRealPath("/")+ "upload/";

        if(pictureService.deleteGoodsPic(imageid,absolutePath))
        {

            return "goods/getGoodsPic/"+goodsid;
        }
        else
        {
            return "admin/goodsupload";
        }
    }

    /**
     * 页面部分刷新,使用<a></a>标签
     * @param req
     * @param session
     * @return
     */
    @RequestMapping("/toGoodsList")
    public ModelAndView toGoodsList(HttpServletRequest req,HttpSession session){
        Map<String,Integer> data = new HashMap<String, Integer>();
        data.put("goods",1);
        ModelAndView mav = new ModelAndView("admin/aindex",data);
        return mav;
    }

    /**
     * 页面部分刷新,使用ajax
     * @param req
     * @param session
     * @return
     */
    @RequestMapping("/toGoodsList2")
    public String toGoodsList2(HttpServletRequest req,HttpSession session){

        return "admin/goodslist";
    }

}
