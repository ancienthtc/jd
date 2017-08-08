package com.jd.shop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jd.shop.annotation.AdminLogin;
import com.jd.shop.model.Goods;
import com.jd.shop.model.Image;
import com.jd.shop.model.Part;
import com.jd.shop.service.GoodsService;
import com.jd.shop.service.PartService;
import com.jd.shop.service.PictureService;
import com.jd.shop.util.PagedResult;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.SimpleDateFormat;
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

    /**
     * 商品保存时先做图片本地上传,返回图片名
     * @param file
     * @return
     */
    @AdminLogin
    @RequestMapping(value = "/addImg" , method = RequestMethod.POST  /*, produces = "application/json"*/ )
    @ResponseBody
    public String addGoods(@RequestParam("file") MultipartFile file){
            String filePath=null;
            Calendar now = Calendar.getInstance();//日期
            String uuid = UUID.randomUUID().toString();//UUID
            String title=uuid +"."+file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
            if (!file.isEmpty()) {
                try {
                    // 文件保存路径
                    filePath = request.getSession().getServletContext().getRealPath("/") + "cacheForImg/" + title;
                    // 转存文件
                    file.transferTo(new File(filePath));

                    return title;
                } catch (Exception e) {
                    e.printStackTrace();
                    return null;
                }
            }else{
                return null;
            }


        /*Map<String ,String> map=new HashMap<String, String>();
        if(goods.getName()==null || goods.getPrice()==null || goods.getParameter1()==null){
            return null;
        }
        Goods good = goodsService.addGoods(goods);
        good = goodsService.getGoods(good.getId());
        if(good !=null){
            map.put("success","true");
            return map;
        }else{
            return null;
        }*/

    }
    //添加商品
    @AdminLogin
    @RequestMapping(value = "/add" , method = RequestMethod.POST  , produces = "application/json" )
    @ResponseBody
    public Map<String,String> addGoods(Goods goods,String imgName){
        Map<String ,String> map=new HashMap<String, String>();
        if(goods.getName()==null || goods.getPrice()==null || goods.getParameter1()==null){
            return null;
        }
        Goods good = goodsService.addGoods(goods);
        good = goodsService.getGoods(good.getId());
        if(good !=null){
            boolean flag = true;
            if(!StringUtils.isBlank(imgName)){
                String[] str = imgName.split(",");
                for (String s:str) {
                    //将缓存区的图片复制到图片区
                    String path = request.getSession().getServletContext().getRealPath("/") + "cacheForImg/"+s;
                    String newPath = request.getSession().getServletContext().getRealPath("/") + "upload/"+s;
                    boolean boo = pictureService.copyImg(path,newPath);
                    if(boo==false){
                        return null;
                    }
                    String serverPath=request.getSession().getServletContext().getRealPath("/") + "upload";
                    Image image=pictureService.goodsAndpicture(String.valueOf(good.getId()),s,newPath,serverPath);
                    if(image==null){
                        flag=false;
                    }
                }
            }
            if(flag==true){
                map.put("success","true");
                return map;//true
            }else{
                return null;
            }
        }else{
            return null;
        }



    }

    /**
     * 跳转至添加商品页面
     * @param req
     * @return
     */
    @AdminLogin
    @RequestMapping("/toGoodAdd")
    public String toGoodAdd(HttpServletRequest req){
        /*获取所有板块*/
        List<Part> parts  = partService.getAll();
        req.setAttribute("parts",parts);
        return "admin/goodAdd";
    }

    //进入商品修改
    @AdminLogin
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
    @AdminLogin
    @RequestMapping(value = "/update" , method = RequestMethod.POST  )
    @ResponseBody
    public Map<String,String> updateGoods(Goods goods)
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
    @AdminLogin
    @RequestMapping("/listpage")
    public String getgoddslist(Model model)
    {
       /*List<Goods> goodslist=goodsService.getAll();
        model.addAttribute("goodslist",goodslist);*/

        return "admin/goodslist";
    }

    //获取所有商品列表，分页
    @AdminLogin
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
    @AdminLogin
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
    @AdminLogin
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
    @AdminLogin
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
    @AdminLogin
    @Transactional(rollbackFor = Exception.class)
    @RequestMapping("goodsdel")
    @ResponseBody
    public String goodsdel(Integer id)

    {
        if(id==null){
            throw new RuntimeException("id不能为空");
        }
        if(goodsService.goodsDel(id) > 0) {
            return "true";
        }
        else
            return "false";
    }

    //获取图片地址
    @AdminLogin
    @RequestMapping("getGoodsPic/{goodsid}")
    public String getPic(@PathVariable Integer goodsid , Model model)
    {
        List<Image> list=goodsService.getGoodsPic(goodsid);
        model.addAttribute("piclist",list);//图片列表
        model.addAttribute("goodsid",goodsid);//商品号
        return "admin/goodspic";
    }

    //选择商品上传图片(跳转)
    @AdminLogin
    @RequestMapping("/idupload")
    public String gouploadpic(HttpServletRequest request,Model model,String id)
    {
        //String id=request.getParameter("id");//商品id
        model.addAttribute("goodsid",id);
        return "admin/goodsupload";
    }

    //商品图片上传
    @AdminLogin
    @RequestMapping(value="/goodsUpload/{goodsid}",method = RequestMethod.POST)
    @ResponseBody
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
        Image image=pictureService.goodsAndpicture(goodsid,title,filePath,serverPath);
        request.setAttribute("image",image);
        String image_json = JSON.toJSONString(image);
        System.out.print(image_json);
        return image_json;
        // 重定向
       /* return "redirect:/goods/list";*/
    }

    /***
     * 读取上传文件中得所有文件并返回
     * @return
     */
    @AdminLogin
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
    @AdminLogin
    @RequestMapping("/deletepic_json")   //goodsid?
    //@ResponseBody
    public String deletePicForJson(@RequestBody String json,Model model)
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

    /**
     * 用于商品编辑时删除图片
     * @param imageid
     * @param model
     * @return
     */
    @AdminLogin
    @RequestMapping("/deletepic")   //goodsid?
    @ResponseBody
    public boolean deletePic(String imageid,Model model)
    {

        String absolutePath=request.getSession().getServletContext().getRealPath("/")+ "upload/";

        boolean flag =  pictureService.deleteGoodsPic(imageid,absolutePath);

        return flag;

    }

    /**
     * 用于商品添加时删除图片
     * @param imgName
     * @return
     */
    @AdminLogin
    @RequestMapping("/deletePicForAdd")   //goodsid?
    @ResponseBody
    public boolean deletePicForAdd(String imgName)
    {

        String absolutePath=request.getSession().getServletContext().getRealPath("/")+ "upload/"+imgName;

        boolean flag =  pictureService.fileDel(absolutePath);

        return flag;

    }

    /**
     * 页面部分刷新,使用<a></a>标签
     * @param req
     * @param session
     * @return
     */
    @AdminLogin
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
    @AdminLogin
    @RequestMapping("/toGoodsList2")
    public String toGoodsList2(HttpServletRequest req,HttpSession session){

        return "admin/goodslist";
    }

    @AdminLogin
    @RequestMapping("/toGoodDetail")
    public String toGoodsDetail(HttpServletRequest req,HttpSession session,Integer id){
        //判断参数合法性
        if(id==null){
            throw new RuntimeException("参数不合法");
        }
        Goods goods = goodsService.getGoods(id);
        req.setAttribute("goods",goods);
        Integer piclist_goods = goods.getPiclistGoods();
        /*获取商品轮播图*/
        List<Image> imgs = null;
        if(piclist_goods!=null){
           imgs = goodsService.getGoodsPic(id);
        }
        req.setAttribute("imgs",imgs);
        /*获取单个商品所属板块*/
        req.setAttribute("partid",goods.getPartGoods());
        /*获取所有板块*/
        List<Part> parts  = partService.getAll();
        req.setAttribute("parts",parts);

        if(goods.getShelf()!=null){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String shelf = sdf.format(goods.getShelf());
            req.setAttribute("shelf",shelf);
        }else{
            req.setAttribute("shelf","");
        }
        return "admin/goodDetail";
    }

    //获取商品详情
    @RequestMapping("/getGoods/{id}")
    public String getGoods(@PathVariable Integer id,Model model)
    {
        Goods goods=new Goods();
        //获取商品信息
        goods=goodsService.getGoods(id);
        model.addAttribute("goods",goods);
        List<Image> images=goodsService.getGoodsImgs(goods.getPiclistGoods());
        model.addAttribute("imgs",images);
        Image first=null;
        if(!images.isEmpty())
        {
            first= images.get(0);

        }
        model.addAttribute("first",first);
        return "user/shopbuy";
    }
}