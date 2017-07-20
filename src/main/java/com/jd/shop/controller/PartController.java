package com.jd.shop.controller;

import com.alibaba.fastjson.JSON;
import com.jd.shop.model.Goods;
import com.jd.shop.model.Part;
import com.jd.shop.service.PartService;
import com.jd.shop.util.PagedResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ThinkPad on 2017/7/12.
 */

@Controller
@RequestMapping("/part")
public class PartController {

    @Autowired
    private PartService partService;

    //查询所有板块后跳转
//    @RequestMapping("/list")
//    public String getPartlist(Model model) {
//        List<Part> parts = partService.getAll();
//        model.addAttribute("parts", parts);
//        return "admin/partlist";
//    }

    //分页查询所有板块 分页
    @RequestMapping("/list")        //应该前端解决分页
    public String selectPartList(Integer pageNumber,Integer pageSize ,Model model,String t,Integer p)
    {
        if(t != null)   //分页验证--前端解决
        {
            if(t.equals("a"))
            {
                if(pageNumber<=1)
                {
                    pageNumber=1;
                }
                else
                {
                    pageNumber = pageNumber - 1;
                }
            }
            else if(t.equals("b"))
            {
                if(pageNumber>=p)
                {
                    pageNumber=p;
                }
                else
                {
                    pageNumber = pageNumber + 1;
                }
            }
        }

        PagedResult<Part> parts=partService.queryByPage(pageNumber,pageSize);

        model.addAttribute("pageParts",parts);
        //System.out.print(parts);
        return "admin/partlist";
    }

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


}
