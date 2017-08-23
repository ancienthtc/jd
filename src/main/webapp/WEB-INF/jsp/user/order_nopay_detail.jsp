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
<title>确认收货地址和商品信息</title>
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
</table>

</div>
<div class="confirm_goods">
<h2>商品</h2>
  <c:forEach var="item" items="${info}">
    <table width="550" border="0" cellpadding="5" height="150">
      <tr>
        <td rowspan="2"><img class="confirm_goods_img" src="<%=basePath%>picture/show?pic=${item.get("title")}"></td>
        <td>商品名称</td>
        <td>数量</td>
        <td>总价</td>
      </tr>
      <tr>
        <td>${item.get("goodsname")}</td>
        <td>${item.get("amount")}</td>
        <td>${item.get("price")}</td>
      </tr>
    </table>

  </c:forEach>
<%--<table width="550" border="0" cellpadding="5">--%>
  <%--<tr>--%>
    <%--<td rowspan="2"><img class="confirm_goods_img" src="img/a1.png"></td>--%>
    <%--<td>商品名称</td>--%>
    <%--<td>数量</td>--%>
    <%--<td>总价</td>--%>
  <%--</tr>--%>
  <%--<tr>--%>
    <%--<td>夏季女裙</td>--%>
    <%--<td>*1</td>--%>
    <%--<td>￥98</td>--%>
  <%--</tr>--%>
<%--</table>--%>
</div>
</div>
</body>
</html>
