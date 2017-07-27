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
    <title>商品列表</title>
    <meta charset="UTF-8">

    <link rel="stylesheet" href="https://terryz.github.io/lib/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css">
    <link rel="stylesheet" href="<%=basePath%>css/page/b.page.bootstrap3.css" type="text/css">

    <script type="text/javascript">

    </script>
</head>
<body>
<div class="row-fluid">
    <div id="pageJsonContent">
        <table id="dataGridTableJson" class="table table-striped table-bordered table-hover table-condensed">
            <thead>
            <tr>
                <th class="selectColumn">商品名称</th>
                <th>单价</th>
                <td>量</td>
                <th>参数1</th>
                <th>参数2</th>
                <th>参数3</th>
                <th>运费</th>
                <th>详情</th>
                <th>销量</th>
                <th>库存</th>
                <th>上架日期</th>
                <th>修改</th>
                <th>删除</th>
               <%-- <th class="selectColumn" >选择</th>
                <th>板块名称</th>
                <th>价格</th>
                <th>量词</th>
                <th>优先级</th>
                <th>--</th>
                <th>--</th>--%>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div id="page3"></div>

<%--<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

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
    <td>商品名称</td>
    <td>单价</td>
    <td>量</td>
    <td>参数1</td>
	<td>参数2</td>
	<td>参数3</td>
	<td>运费</td>
	<td>详情</td>
	<td>销量</td>
	<td>库存</td>
	<td>上架日期</td>
    <td>修改</td>
	<td>删除</td>
  </tr>
   &lt;%&ndash; <c:forEach var="item" items="${goodslist.dataList}">
        <tr class="hang2">
            <td>${item.name}</td>
			<td>${item.price}</td>
			<td>${item.gclass}</td>
			<td>${item.parameter1}</td>
			<td>${item.parameter2}</td>
			<td>${item.parameter3}</td>
			<td>${item.freight}</td>
			<td>${item.detail}</td>
			<td>${item.sales}</td>
			<td>${item.stock}</td>
			<td>${item.shelf}</td>
            <td><a href="<%=basePath%>goods/goodsalter/${item.id}">修改</a></td>
			<td>----</td>
        </tr>
    </c:forEach>&ndash;%&gt;

</table>
<div id="page3"></div>--%>
<!--下一页--->
<%--<div class="wrap" style="margin-top:150px;">

    <div class="fenye">
    	<ul>
        	<li id="first">首页</li>

            <li id="top" onclick="topclick()"><a href="<%=basePath%>   ">上一页</a></li>

            <li class="xifenye" id="xifenye">

            	<a id="xiye">${pageParts.pageNo}</a>/<a id="mo">${pageParts.pages}</a>

                <div class="xab" id="xab" style="display:none">

                	<ul id="uljia">

                    </ul>

                </div>

            </li>

            <li id="down" onclick="downclick()"><a href="<%=basePath%>  ">下一页</a></li>

            <li id="last">末页</li>

        </ul>

    </div>

</div>--%>

<div>${message}</div>

<script src="<%=basePath%>js/jquery-3.1.1.js" type="text/javascript"></script>

<script src="<%=basePath%>js/public.js" type="text/javascript"></script>

<%--分页插件--%>
<%--<script type="text/javascript" src="<%=basePath%>js/page/b.page.js" ></script>
<script type="text/javascript" src="<%=basePath%>js/page/goodslist.js" ></script>--%>



</body>

</html>

<script type="text/javascript">
var cpro_id = "u1879755";</script>