<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>分页</title>

<meta name="viewport" content="width=device-width" />



<style>
table{
	margin-left:19%;
	margin-top:10%;
	border:dashed 1px;
	}
.hang1{
	background-color:#CCC;
	height:30px;
	font-size:18px;
	font-family:"宋体";
	}
.hang1 td{
	text-align:center;
	margin-top:5px;}
	
.hang2 td{
	text-align:center;
	}

*{margin:0px; padding:0px;}

body{margin:0 auto; font-size:12px; color:#666; font-family:"微软雅黑", Simsun;}

li{list-style:none;}

img{border:none;}

a, a:visited{text-decoration:none;}



.tong{ background:url(../images/images/sy-toubjing_03.gif) repeat-x 0px -11px; width:100%; height:40px;}

.wrap{ width:auto; max-width:320px; margin-left:70%;}

.center{ width:103%; margin:0 auto;}



/***************分页******************/

.fenye{ float:left; margin-top:10px;}

.fenye ul{ float:left; margin-left:32px; }

.fenye ul li{ float:left; margin-left:5px;padding: 4px 6px; border:1px solid #ccc;  font-weight:bold; cursor:pointer; color:#999;}

.fenye ul li a{ color:#999;}

.fenye ul li.xifenye{ width:38px; text-align:center; float:left; position:relative;cursor: pointer;}

.fenye ul li .xab{ float:left; position:absolute; width:39px; border:1px solid #ccc; height:123px; overflow-y: auto;overflow-x: hidden;top:-125px; background-color: #fff; display:inline;left:-1px; width:50px;}

.fenye ul li .xab ul{ margin-left:0; padding-bottom:0;}

.fenye ul li .xab ul li{ border:0; padding:4px 0px; color:#999; width:34px; margin-left:0px; text-align:center;}

</style>

</head>

<body>
<table width="70%" cellpadding="1" cellspacing="1" height="50px;"> 
  <tr class="hang1">
    <td>板块名称</td>
    <td>价格</td>
    <td>量词</td>
    <td>优先级</td>
    <td>修改</td>
    <td>删除</td>
  </tr>
    <c:forEach var="item" items="${pageParts.dataList}">
        <tr class="hang2">
            <td>${item.pname}</td>
            <td>${item.type}</td>
            <td>${item.describe}</td>
            <td>${item.priority}</td>
            <td><a href="<%=basePath%>part/alter?pid=${item.id}">修改</a></td>
            <td>-----</td>
        </tr>
    </c:forEach>

</table>

<!--下一页--->
<div class="wrap" style="margin-top:150px;">

    <div class="fenye">
    	<ul>
        	<li id="first">首页</li>

            <li id="top" onclick="topclick()"><a href="<%=basePath%>part/list?pageNumber=${pageParts.pageNo}&&t=a&&p=${pageParts.pages}">上一页</a></li>

            <li class="xifenye" id="xifenye">

            	<a id="xiye">${pageParts.pageNo}</a>/<a id="mo">${pageParts.pages}</a>

                <div class="xab" id="xab" style="display:none">

                	<ul id="uljia">

                    </ul>

                </div>

            </li>

            <li id="down" onclick="downclick()"><a href="<%=basePath%>part/list?pageNumber=${pageParts.pageNo}&&t=b&&p=${pageParts.pages}">下一页</a></li>

            <li id="last">末页</li>

        </ul>

    </div>

</div>

<script src="<%=basePath%>js/jquery-3.1.1.js" type="text/javascript"></script>

<script src="<%=basePath%>js/public.js" type="text/javascript"></script>

<div align="center" style="clear:both;font-size:12px;color:#666;"><br><br><br><br>
</div>

</body>

</html>

<script type="text/javascript">
var cpro_id = "u1879755";</script>