<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style type="text/css">
#btn1{
	float:left;
    margin-top:1%;
	margin-left:5%;
	}
#head ul{
	float:right;
	margin-right:10%;
	
	}
#head ul li{
	float:left;
	list-style:none;
    font-size:16px;
	text-decoration:none;
	}
#head ul li a{
	text-decoration:none;
	
	}
 a { color: #4183c4; text-decoration: none; font-weight: bold; }
a:hover { text-decoration: underline; }

h3 { color: #666; }
ul { list-style: none; padding: 25px 0; }
li {
        display: inline;
        margin: 10px 50px 10px 0px;
      }
input[type=text],
input[type=password] {
        font-size: 13px;
        min-height: 32px;
        margin: 0;
        padding: 7px 8px;
        outline: none;
        color: #333;
        background-color: #fff;
        background-repeat: no-repeat;
        background-position: right center;
        border: 1px solid #ccc;
        border-radius: 3px;
        box-shadow: inset 0 1px 2px rgba(0,0,0,0.075);
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        transition: all 0.15s ease-in;
        -webkit-transition: all 0.15s ease-in 0;
        vertical-align: middle;
      }
.button {
        position: relative;
        display: inline-block;
        margin: 0;
        padding: 8px 15px;
        font-size: 13px;
        font-weight: bold;
        color: #333;
        text-shadow: 0 1px 0 rgba(255,255,255,0.9);
        white-space: nowrap;
        background-color: #eaeaea;
        background-image: -moz-linear-gradient(#fafafa, #eaeaea);
        background-image: -webkit-linear-gradient(#fafafa, #eaeaea);
        background-image: linear-gradient(#fafafa, #eaeaea);
        background-repeat: repeat-x;
        border-radius: 3px;
        border: 1px solid #ddd;
        border-bottom-color: #c5c5c5;
        box-shadow: 0 1px 3px rgba(0,0,0,.05);
        vertical-align: middle;
        cursor: pointer;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        -webkit-touch-callout: none;
        -webkit-user-select: none;
        -khtml-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
        -webkit-appearance: none;
      }
      .button:hover,
      .button:active {
        background-position: 0 -15px;
        border-color: #ccc #ccc #b5b5b5;
      }
      .button:active {
        background-color: #dadada;
        border-color: #b5b5b5;
        background-image: none;
        box-shadow: inset 0 3px 5px rgba(0,0,0,.15);
      }
      .button:focus,
      input[type=text]:focus,
      input[type=password]:focus {
        outline: none;
        border-color: #51a7e8;
        box-shadow: inset 0 1px 2px rgba(0,0,0,.075), 0 0 5px rgba(81,167,232,.5);
      }
     
label[for=search] {
        display: block;
        text-align: left;
      }
#search label {
        font-weight: 200;
        padding: 5px 0;
      }
#search input[type=text] {
        font-size: 18px;
        width: 805px;
		margin-left:5%;
		margin-top:1%;
      }
#search .button {
        padding: 10px;
        width: 90px;
		margin-top:1%;
      }

#bb1 img{
    width:150px;
    height:300px;
}
#bb1 a{
    float:left;
    margin-left:15%;
    margin-top: 5%;
}

</style>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

</head>

<body style="width:100%;">
<div>
<div id="head" style="background-image:url(/JDWebShop/image/1.jpg); width:100%; height:350px; background-repeat:no-repeat;">

	<c:if test="${not empty User.nickname}"><h3>欢迎登录 ${User.nickname}</h3></c:if>
	<c:if test="${empty User.nickname}"> <a href="<%=basePath%>login/login">您好！请登录</a> </c:if>
	
	<ul>
	<li><a href="index.html">商城首页</a></li>
	<li><a href="all.html">所有商品</a></li>
	<li><a href="new.html">新上商品</a></li>
	<li><a href="myself.html">个人中心</a></li>
	</ul>
</div>

	<div id="search">
	   
		<input type="text" name="q">
		<input class="button" type="submit" value="Search">
	</div>

	<div id="container" style="width:100%;">
		<div id="bb1">
			<c:forEach var="item" items="${parts}">
			<a href="">
                <img src="<%=basePath%>picture/show?pic=${item.get("title")}"/>
                </br>
                <p>${item.get("pname")}</p>
            </a>
			</c:forEach>
		</div>
	</div>

</div>
</body>
</html>
