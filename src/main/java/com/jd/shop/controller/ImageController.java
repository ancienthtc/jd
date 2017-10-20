package com.jd.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

/**
 * Created by ThinkPad on 2017/7/10.
 */
@Controller
@RequestMapping("/image")
public class ImageController {

    @ResponseBody
    @RequestMapping(value = "/show")
    public void showPicture(HttpServletRequest request,
                            HttpServletResponse response, String imagePath,String pic) throws IOException
    {

        if(pic != null)
        {
            if(pic.equals("undefined") || pic.equals("") || pic.equals("null")) //默认图片
            {
                imagePath = request.getSession().getServletContext().getRealPath("/")+ "images/" + "not.png";
            }
            else
            {
                imagePath = request.getSession().getServletContext().getRealPath("/")+ "upload/" + pic;
            }
        }
        else//默认图片
        {
            imagePath = request.getSession().getServletContext().getRealPath("/")+ "images/" + "stop.png";
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
        }
        catch (FileNotFoundException e)
        {
            imagePath = request.getSession().getServletContext().getRealPath("/")+ "images/" + "not.png";
            OutPutAgain(imagePath,request,response);
        }
        catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    private void OutPutAgain(String path,HttpServletRequest request, HttpServletResponse response)
    {
        FileInputStream in;
        response.setContentType("application/octet-stream;charset=UTF-8");
        try {
            // 图片读取路径
            in = new FileInputStream(path);
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
        }catch (Exception e)
        {
            e.printStackTrace();
        }


    }

}
