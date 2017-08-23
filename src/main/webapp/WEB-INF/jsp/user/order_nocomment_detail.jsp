<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/8/18
  Time: 16:45
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
    <!-- JQuery -->
    <script type="text/javascript" src="<%=basePath%>js/jquery-1.8.3.min.js" ></script>
    <!-- 提示框的js -->
    <script src="../static/libs/messenger/js/messenger.min.js"></script>
    <script src="../static/util/imessenger.js"></script>
    <!-- 确认框的js -->
    <script src="../static/libs/jquery-confirm/jquery-confirm.js"></script>
    <!-- layer -->
    <script type="text/javascript" src="<%=basePath%>js/layer.js" ></script>


    <meta charset="utf-8">
    <title>商品评价</title>
    <style>
        body{ text-align:center;}
        h2{ text-align:left;}
        .confirm_address table { border:1px solid #CCC; border-collapse:collapse; text-align:left;}
        .confirm_address table tr { border:1px solid #CCC; }
        .confirm_goods table{border:1px solid #CCC; border-collapse:collapse; margin-bottom:5px; text-align:left;}
        .confirm_goods_img{ width:60px; height:60px;}
    </style>

    <script type="text/javascript">
        $(document).ready(function(){
            $("#getComm").click(function(){
                var goodsid=$(this).parent().attr("value");
                //alert(goodsid);

                $.ajax( {
                    type : 'POST',
                    contentType : 'application/json',
                    url : '<%=basePath%>order/detailComment',
                    data : goodsid,
                    dataType : 'html',
                    success : function(data) {
                        //alert("新增成功！");
                        $("#place").html(data);
                    },
                    error : function(data) {
                        alert("error")
                    }
                });
            });

        })
    </script>

</head>
<body>
<div class="confirm_message">
    <div class="confirm_goods">
        <h2>商品</h2>
        <c:forEach var="item" items="${info}">
            <table width="550" border="0" cellpadding="5" height="150">
                <tr>
                    <td rowspan="2"><img class="confirm_goods_img" src="<%=basePath%>picture/show?pic=${item.get("title")}"></td>
                    <td>商品名称</td>
                    <td>数量</td>
                    <td>总价</td>
                    <td rowspan="2" value="${item.get("goodsid")}">
                        <!-- 获取标识 判断是否显示评价 -->
                        <c:if test="${item.get('isComment')=='false' }">
                            <a id="getComm" class="button blue" href="javascript:void(0)">点击评价</a>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <td>${item.get("goodsname")}</td>
                    <td>${item.get("amount")}</td>
                    <td>${item.get("price")}</td>
                </tr>
            </table>
        </c:forEach>
    </div>
    <div id="place"></div><!-- 评价 -->
</div>
</body>
</html>
