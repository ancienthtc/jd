<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>购物车结算</title>
<style>
.head{width:100%; height:100px; background:#996;}
.h_left{ height:100px; margin-left:50px; float:left;}
.h_left a{color:#000; font-size:16px; text-decoration:none;}
.h_left a:hover{color:#999; font-size:18px;}
.h_right{margin-right:150px; margin-top:-5px;  height:100px;}
.h_right ul{ float:right;}
.h_right ul li{ float:left; list-style:none; font-size:16px; margin-left:35px;}
.h_right ul li a{font-size:16px; text-decoration:none; color:#000;}
.h_right ul li a:hover{font-size:18px; color:#999;}
<!--搜索框开始-->
form { 
margin-top:20px; 
} 
#search_box {
margin-top:-42px;
margin-left:950px; 
width: 201px; 
height: 31px; 
background: url(http://files.jb51.net/demoimg/200912/bg_search_box.gif); 
} 
#search_box #s { 
float: left; 
padding: 0; 
margin: 6px 0 0 6px; 
border: 0; 
width: 159px; 
background: none; 
font-size: .8em; 
} 
#search_box #go { 
float: right; 
margin: 3px 4px 0 0; 
} 
<!--选择收货地址开始-->
.choose{ width:100%;}
.choose .table1 { border:1px solid #999; text-align:center; line-height:25px;}
.choose .table1 td{border-top:1px solid #0CF;}
.plus{
 border: 1px solid; border-radius:10px; width:80px; height:35px;
 color:#FFF; font-weight: bold; background:#3CF;
 }

<!--底部版权开始-->
.footer{width:100%;clear:both;text-align:center;padding:10px 0;line-height:25px;color:#666;border-top:#ddd 1px solid;}
.footer{ background-color:#999; height:100px; position: fixed;}
.footer a{margin-top:50px;color:#666; padding-top:30px; margin-left:15px;}
.footer a:hover{color:#000;text-decoration:underline;}
.footer p{ text-align:center; line-height:25px;}
</style>
</head>

<body>
<div class="head">
<div class="h_left"><p>欢迎光临***&nbsp;&nbsp; <a href="">退出</a></p></div>
<div class="h_right">
<ul>
<li><a href="">****</a></li>
<li><a href="">用户管理</a></li>
<li><a href="">购&nbsp;&nbsp;物&nbsp;&nbsp;车</a></li>
</ul>
</div>
</div>
<!--搜索框开始-->
<div id="search_box"> 
<form id="search_form" method="post" action="#"> 
<input type="text" id="s" value="Search" class="swap_value" /> 
<input type="image" src="http://files.jb51.net/demoimg/200912/btn_search_box.gif" width="27" height="24" id="go" alt="Search" title="Search" /> 
</form> 
</div> 
<!--选择收货地址开始-->
<div class="choose">
<h2>选择收货地址</h2>
<table class="table1" width="92%" border="0" cellpadding="0" cellspacing="0">
  <tr style=" background-color:#CCC;">
    <th scope="col">收货人</th>
    <th scope="col">区域</th>
    <th scope="col">详细地址</th>
    <th scope="col">邮编</th>
    <th scope="col">手机</th>
    <th scope="col">选择</th>
  </tr>
  <c:forEach var="address" items="${addresses}">
    <tr>
      <td>${address.recipient}</td>
      <td>${address.area}</td>
      <td>${address.detail}</td>
      <td>${address.zip}</td>
      <td>${address.tel}</td>
      <td><input type="radio" name="choice"></td>
    </tr>
  </c:forEach>
  <%--<tr>--%>
    <%--<td>王晓</td>--%>
    <%--<td>上海</td>--%>
    <%--<td>上海浦东区川沙</td>--%>
    <%--<td>230014</td>--%>
    <%--<td>188********</td>--%>
    <%--<td><input type="radio" name="choice"></td>--%>
  <%--</tr>--%>
  <%--<tr>--%>
    <%--<td>黎明</td>--%>
    <%--<td>广东</td>--%>
    <%--<td>广东省</td>--%>
    <%--<td>562310</td>--%>
    <%--<td>156********</td>--%>
    <%--<td><input type="radio" name="choice"></td>--%>
  <%--</tr>--%>
</table><br>
<a href="#"><input type="button" value="添加" name="add" class="plus"></a><br><br>
<table class="table2" border="0">
<tr>
<td>运 &nbsp;费：</td><td>￥10</td>
</tr>
<tr>
<td>商品总价：</td><td>22.22</td>
</tr>
<tr>
<td>总&nbsp;计：</td><td>32.22</td>
</tr>
</table><br>
</div>

<!--底部版权开始-->
<div class="footer"  style=" width:100%;">
<P>
<a href="#" rel="nofollow">关于我们</a> &nbsp;|<a href="#" rel="nofollow">联系我们</a>&nbsp;|<a href="#" rel="nofollow"><a href='http://www.veryhuo.com/z/falvapp/' target='_blank'><b>法律</b>声明</a>&nbsp;|<a href="#" rel="nofollow">网站地图</a>&nbsp;|<a target="_blank" href="#">版权声明</a>&nbsp;|<a href="#" rel="nofollow">帮助中心</a><br />
***商城 版权所有　© 2005-2020　京ICP备********号</P>
</div>			
</body>
</html>

