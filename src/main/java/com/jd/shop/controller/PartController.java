package com.jd.shop.controller;

import com.alibaba.fastjson.JSON;
import com.jd.shop.model.Goods;
import com.jd.shop.model.Image;
import com.jd.shop.model.Part;
import com.jd.shop.service.PartService;
import com.jd.shop.service.PictureService;
import com.jd.shop.util.PagedResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.*;

/**
 * Created by ThinkPad on 2017/7/12.
 */

@Controller
@RequestMapping("/part")
public class PartController {

    @Autowired
    private PartService partService;

    @Autowired
    private PictureService pictureService;

    @Autowired
    private HttpServletRequest request;

    //查询所有板块后跳转
    @RequestMapping("/list")
    public String getPartlist(Model model) {
//        List<Part> parts = partService.getAll();
//        model.addAttribute("parts", parts);
        return "admin/partlist";
    }

    //分页查询所有板块 分页
    @RequestMapping("/list_get")
    @ResponseBody
    public String selectPartList(Integer pageNo, Integer pageSize , Model model)
    {
        PagedResult<Part> parts=partService.queryByPage(pageNo,pageSize);

        model.addAttribute("pageParts",parts);
        //System.out.print(parts);
        //return "admin/partlist2";
        String json= JSON.toJSONString(parts);
        return json;
    }

//    @RequestMapping("/list2")
//    public String tolist2()
//    {
//        return "admin/partlist2";
//    }
//
//    //
//    @RequestMapping("/list2_json")        //测试新分页
//    @ResponseBody
//    public String selectPartList(Integer pageNo, Integer pageSize , Model model)
//    {
//
//        PagedResult<Part> parts=partService.queryByPage(pageNo,pageSize);
//
//        model.addAttribute("pageParts",parts);
//        //System.out.print(parts);
//        //return "admin/partlist2";
//        String json= JSON.toJSONString(parts);
//        return json;
//    }

    //板块添加
    @RequestMapping(value = "/add" , method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> addPart(@RequestBody Part part)
    {
        Map<String,String> map=new HashMap<String, String>();
        if(part.getPname()==null)
        {
            return null;
        }
        if(partService.partadd(part) > 0)
        {
            map.put("success","true");
            return map;
        }
        return null;
    }

    //进入板块修改
    @RequestMapping(value = "/alter" )
    public String toalter(Integer pid,Model model)
    {
        Part part=partService.selectByPrimaryKey(pid);
        model.addAttribute("part",part);
        return "admin/partalter";
    }

    //板块修改
    @RequestMapping(value = "/update" , method = RequestMethod.POST  )
    @ResponseBody
    public Map<String,String> alterPart(@RequestBody Part part)
    {
        Map<String ,String> map=new HashMap<String, String>();
        if(part.getPname()==null || part.getPriority()==null || part.getId()==null)
        {
            return null;
        }
        if(partService.partAlter(part) > 0)
        {
            map.put("success","true");
            return map;//true
        }
        else
        {
            return null;
        }
    }

    //首页获得板块和商品
    //返回json串
    @RequestMapping("/all")
    @ResponseBody
    public String getinfo(HttpServletResponse response)
    {
        List<Map<String,String>> all=partService.getAllInfo();
        String json= JSON.toJSONString(all);
        return json;
    }


    //板块界面浏览
    @RequestMapping("/view/{pid}")
    public String getgoods(@PathVariable Integer pid, Model model)
    {
        //查询板块下所有商品
        List<Goods> allgoods=partService.partGoods(pid);
        model.addAttribute("all",allgoods);


        return "shoppart";
    }

    //板块图片删除
    @RequestMapping("/picdel")
    @ResponseBody
    public boolean partPicDel(Integer pid)
    {
        String ServerPath=request.getSession().getServletContext().getRealPath("/")+ "upload/";
        if(pictureService.partPicdel(pid,ServerPath))
        {
            return true;
        }
        return false;
    }

    //板块删除(异步)
    @RequestMapping("/partdel")
    @ResponseBody
    public boolean deletePart(Integer pid)
    {
        String absolutePath=request.getSession().getServletContext().getRealPath("/")+ "upload/";
        //先删图片再删图片集最后删图片
        return partService.partDel(pid,absolutePath);
    }



    //板块添加图片(添加1张)
    @RequestMapping("/picupload/{partid}")
    @ResponseBody
    public boolean partUploadPic(@PathVariable Integer partid , @RequestParam("file") MultipartFile file)
    {
        String filePath=null;
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
        String serverPath=request.getSession().getServletContext().getRealPath("/") + "upload";
        Image image=new Image();
        image.setFilename(filePath);
        image.setServer(serverPath);
        image.setTitle(title);

        //调用图片添加方法
        return pictureService.partPicdel(partid,serverPath);
    }

}
