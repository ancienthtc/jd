package com.jd.shop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jd.shop.annotation.AdminLogin;
import com.jd.shop.model.Format;
import com.jd.shop.model.Goods;
import com.jd.shop.service.FormatService;
import com.jd.shop.service.GoodsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

/**
 * Created by ThinkPad on 2017/10/24.
 */
@Controller
@RequestMapping("/format")
public class FormatController {
    private static final Logger log = LoggerFactory.getLogger(FormatController.class);

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private FormatService formatService;

    @AdminLogin
    @RequestMapping("/getGlist")
    public String getGoods(Model model)
    {
        model.addAttribute("glist",goodsService.getAll());

        return "admin/goodsFormat";
    }

    //添加
    @RequestMapping("/add")
    @ResponseBody
    public String AddFormat(@RequestBody String json)
    {
        if( formatService.addFormat(json) > 0 )
        {
            return "true";
        }
        else
        {
            return "false";
        }
    }

    //删除
    @RequestMapping("/del")
    @ResponseBody
    public String delFormat(String id)
    {
        if( formatService.delFormat( Integer.parseInt(id) ) > 0 )
        {
            return "true";
        }
        else
        {
            return "false";
        }
    }

    //修改
    @RequestMapping("/alter")
    @ResponseBody
    public String alterFormat(@RequestBody String dates)
    {
        if( formatService.alterFormat(dates) > 0 )
        {
            return "true";
        }
        else
        {
            return "false";
        }
    }

    //规格/价格
    @RequestMapping("/changePrice")
    @ResponseBody
    public String getPrice(@RequestBody String dates)
    {
        JSONObject object = JSON.parseObject(dates);
        String type=object.getString("type");
        String fid=object.getString("fid");
        Goods goods=null;
        Format format=null;
        if(type.equals("0"))//查默认   (fid=gid)
        {
            goods= goodsService.getGoods( Integer.parseInt(fid) );
        }
        else if(type.equals("1"))//查规格
        {
            format= formatService.getFormat( Integer.parseInt(fid) );
        }
        Map<String,Object> map=new HashMap<String,Object>();
        if(goods!=null)
        {
            map.put("id",goods.getId());
            map.put("price",goods.getPrice());
            map.put("stock",goods.getStock());
            map.put("sales",goods.getSales());
        }
        else if(format != null)
        {
            map.put("id",format.getGoodsFormat());
            map.put("price",format.getFprice());
            map.put("stock",format.getFstock());
            map.put("sales",format.getFsale());
        }
        JSON.toJSONString(map);
        return JSON.toJSONString(map);
    }

}
