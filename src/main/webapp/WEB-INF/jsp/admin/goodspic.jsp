<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/7/10
  Time: 10:59
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
    <title>pic show</title>
    <script src="<%=basePath%>/js/jquery-3.1.1.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){

            $("#del").click(function() {    //刷新问题
                var id = $('#del').attr("imageid");
                var goodsid=$('#del').attr("goodsid");
                var date="{id:'"+id+"',goodsid:'"+goodsid+"'}";
                jQuery.ajax( {
                    type : 'POST',
                    contentType : 'application/json',
                    url : '<%=basePath%>/goods/deletepic_json',
                    data : date,
                    dataType : 'json',
                    success : function(data) {
                        //alert("正确");
                        //window.location.reload(true);
                        window.location.href="<%=basePath%>goods/getGoodsPic/"+goodsid;
                    },
                    error : function(data) {
                        //alert("错误");
                        window.location.reload(true);
                    }
                });
            });
        });

    </script>

</head>
<body>
    <!-- 获取商品图片 -->
    <div>
        <c:forEach var="list" items="${piclist}">
            <div>
                <p>path=${list.filename}</p>    <br>
                <img src="<%=basePath%>/picture/show?pic=${list.title}" width="40px" height="40px"><br>
                <input type="button" id="del" value="删除" imageid="${list.id}" goodsid="${goodsid}">
                <a href="">删除</a>
            </div>
        </c:forEach>
    </div>
    <!--
    <img src="<%=basePath%>/upload/1499654882098.jpg" width="40px" height="40px"><br>
    <img src="<%=basePath%>target/jdshop/upload/1499654882098.jpg" width="40px" height="40px"><br>
    <img src="F:\IntelliJ\JDWebShop\target\jdshop\upload\music_logo.jpg" width="40px" height="40px"><br>
    -->
    <br><br>
    <!--
    <img src="<%=basePath%>/picture/show?pic=music_logo.jpg" width="40px" height="40px"/><br>
    <img src="<%=basePath%>/picture/show?pic=1499654882098.jpg" width="40px" height="40px"/><br>
    <img src="<%=basePath%>/picture/show?pic=b.jpg" width="40px" height="40px"/><br>
    <img src="<%=basePath%>/picture/show?pic=search.png" width="200px" height="150px"><br>
    <img src="<%=basePath%>/picture/show" width="200px" height="150px">
    -->
</body>
</html>
