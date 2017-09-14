<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/8/30
  Time: 15:43
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
    <title>include</title>

    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.js"></script>

    <script>
        $(function(){

        });
    </script>

</head>
<body>

</body>
</html>
