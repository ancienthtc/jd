package com.jd.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

/**
 * Created by ThinkPad on 2017/7/10.
 */
@Controller
@RequestMapping("/picture")
public class ImageController {

    @ResponseBody
    @RequestMapping(value = "/show")
    public void showPicture(HttpServletRequest request,
                            HttpServletResponse response, String imagePath,String pic) throws IOException
    {
        //如果没有图片显示默认图片
//        if(imagePath == null || imagePath.equals("")){
//            imagePath = request.getSession().getServletContext().getRealPath("/")+ "upload/"+"music_logo.jpg";
//        }
//        if(pic != null && imagePath==null)
//        {
//            imagePath=request.getSession().getServletContext().getRealPath("/")+ "upload/" + pic;
//        }
        if(pic != null)
        {
            if(pic.equals("undefined") || pic.equals("") || pic.equals("null")) //默认图片
            {
                imagePath = request.getSession().getServletContext().getRealPath("/")+ "image/" + "not.png";
            }
            else
            {
                imagePath = request.getSession().getServletContext().getRealPath("/")+ "upload/" + pic;
            }
        }
        else//默认图片
        {
            imagePath = request.getSession().getServletContext().getRealPath("/")+ "image/" + "stop.png";
        }
        //System.out.println(imagePath);

        FileInputStream in;
        response.setContentType("application/octet-stream;charset=UTF-8");
        try {
            // 图片读取路径
            in = new FileInputStream(imagePath);
            int i = in.available();
            byte[] data = new byte[i];
            in.read(data);
            in.close();

            // 写图片
            OutputStream outputStream = new BufferedOutputStream(
                    response.getOutputStream());
            outputStream.write(data);
            outputStream.flush();
            outputStream.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }



}
