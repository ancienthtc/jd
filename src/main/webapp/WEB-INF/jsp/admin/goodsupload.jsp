<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/7/7
  Time: 17:43
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
    <title>上传</title>
</head>
<body>
    <%

    %>
    <div>
        <h2>文件上传</h2>
    </div>
    <did>
        上传 &nbsp; ${goodsid} &nbsp; 号商品图片<br>
        <form action="<%=basePath%>/goods/goodsUpload/${goodsid}" method="post" enctype="multipart/form-data">
            选择文件:<input type="file" name="file">
            <input type="submit" value="提交">
        </form>
    </did>
</body>
</html>
