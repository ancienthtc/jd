<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/7/7
  Time: 12:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>后台登录界面</title>
    <style type="text/css">
        * html,* html body{background-image:url(about:blank);background-attachment:fixed;}
        html{color:#000;background-color:#F2F2F2;}
        body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,form,fieldset,input,textarea,p,blockquote,th,td{margin:0;padding:0;}
        table {border-collapse:collapse;border-spacing:0;}
        img,button,input {vertical-align:middle;border:none;}
        label{font-size:12px;color:#666;cursor:pointer;}
        a,span{color:#666;font-size:12px;text-decoration:none;}
        a:hover{text-decoration:underline;}
        address,caption,cite,code,dfn,em,strong,th,var{font-style:normal;font-weight:normal;}
        ol,ul,li{list-style:none;list-style-type: none;}
        h1,h2,h3,h4,h5,h6{font-size:100%;overflow:hidden;}

        header {width:660px;margin:0 auto;font-size:28px;font-weight:bold;margin-top:20px;color:#ccc;text-shadow:1px 1px 1px #fff;font-family: 'revolt',georgia,'Microsoft yahei';}
        .content {width:350px;margin:90px auto auto;padding:30px 40px;border:2px solid #ccc;border-radius:10px;box-shadow:0 0 30px #ccc;}
        .ipt {border:1px solid #ddd;padding:10px 5px;width: 240px;outline:none;border-radius:3px;background-color:#fff;font-family: 'revolt',georgia,'Microsoft yahei';}
        .ipt:focus {background-color:#fefefe;box-shadow:0 0 3px #aaa;}
        .thead {font-weight:bold;font-size:20px;padding-bottom:20px!important;text-shadow:1px 1px 1px #fff;}
        .content th {color:#666;font-size:12px;font-weight:bold;text-shadow: 1px 1px 1px #fff;}
        .content td {padding:5px 0;}
        .submit_btn {background-color:#4797ED;border:none;border-radius:10px;box-shadow:0 0 3px #aaa;width:98px;height:41px;line-height:41px;color:#fff;font-size:18px;font-weight:bold;cursor:pointer;margin-right:20px;display:block;outline:none;text-shadow:0 1px 1px #777;float:left;}
        .submit_btn:hover {background-color:#d8d8d8;color:#666;text-shadow:1px 1px 1px #fff;}
        .line {float:left;margin-top:10px;}
        .pd15 {padding-top:15px!important;}
        .red {color:red;}
    </style>


</head>
<body>
    <header> &gt;&gt; 商城后台登录系统</header>
    <div class="content">
        <form name="form1" action="<%=basePath %>login/alogin " method="post" >
            <table width="100%" border="0" align="center">
                <thead>
                <td colspan="2" class="thead">后台管理员登录</td>
                </thead>
                <tr>
                    <td><em class="red">*</em>用户名:</td>
                    <td><input type="text" name="admin" class="email ipt">
                    </td>
                </tr>
                <tr>
                    <td><em class="red">*</em>密码:</td>
                    <td><input  type="password" name="pass" class="password ipt"/>
                    </td>
                </tr>
                <tr>
                    <th class="pd15"></th>
                    <td class="pd15">
                        <button class="submit_btn" type="button" name="submit" >登录</button>
                        <p class="line"><input type="checkbox" id="remember" value=""> <label for="remember">记住我</label></p>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div>
        ${message}
    </div>
</body>
</html>
