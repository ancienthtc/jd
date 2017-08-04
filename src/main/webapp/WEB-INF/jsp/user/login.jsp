<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/7/6
  Time: 8:57
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
    <title>请登录</title>
</head>
<body>
    <div align="center">
        <h1>欢迎登录XX商城</h1>
    </div>
    <div align="center">
        <form name="form1" action="<%=basePath %>login/ton " method="post" >
            <table width="300" border="1" align="center">
                <tr>
                    <td colspan="2">登入窗口</td>
                </tr>
                <tr>
                    <td>用户名:</td>
                    <td><input type="text" name="username">
                    </td>
                </tr>
                <tr>
                    <td>密码:</td>
                    <td><input  type="password" name="password"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        <input type="submit" name="submit" value="登录"/>
                    </td>
                    <td>
                        <input type="button" value="注册" onclick="window.location.href='<%=basePath %>login/reg'">
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div>
        ${message}
    </div>


</body>
</html>
