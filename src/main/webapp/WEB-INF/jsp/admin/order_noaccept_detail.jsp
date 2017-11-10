<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/8/21
  Time: 8:56
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
    <title>待收货</title>

    <style>
        body{ text-align:center;}
        h2{ text-align:left;}
        .confirm_address table { border:1px solid #CCC; border-collapse:collapse; text-align:left;}
        .confirm_address table tr { border:1px solid #CCC; }
        .confirm_goods table{border:1px solid #CCC; border-collapse:collapse; margin-bottom:5px; text-align:left;}
        .confirm_goods_img{ width:60px; height:60px;}
    </style>
</head>
<body>
<div class="confirm_message">
    <div class="confirm_address">
        <h2>收货地址</h2>
        <table width="550" border="0" cellpadding="5" height="150">
            <tr>
                <td>收&nbsp;货&nbsp;&nbsp;人:</td>
                <td>${address.recipient}</td>
                <td>邮编:</td>
                <td>${address.zip}</td>
            </tr>
            <tr>
                <td>所在地区:</td>
                <td colspan="3">${address.area}</td>
            </tr>
            <tr>
                <td>详细地址:</td>
                <td colspan="3">${address.detail}</td>
            </tr>
            <tr>
                <td>电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话:</td>
                <td>${address.phone}</td>
                <td>手机:</td>
                <td>${address.tel}</td>
            </tr>
            <!-- 运单信息 -->
            <td>运单信息:</td>
            <td colspan="3">${logistics}</td>
        </table>

    </div>

    <div class="confirm_goods">
        <h2>商品</h2>
        <c:forEach var="item" items="${info}">
            <table width="550" border="0" cellpadding="5" height="150">
                <tr>
                    <td rowspan="2"><img class="confirm_goods_img" src="<%=basePath%>image/show?pic=${item.get("title")}"></td>
                    <td>商品名称</td>
                    <td>商品规格</td>
                    <td>数量</td>
                    <td>总价</td>
                </tr>
                <tr>
                    <td>${item.get("goodsname")}</td>
                    <td>${item.get("fname")}</td>
                    <td>${item.get("amount")}</td>
                    <td>${item.get("price")}</td>
                </tr>
            </table>

        </c:forEach>
    </div>
</div>
</body>
</html>
