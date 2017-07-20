<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/7/6
  Time: 14:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>注册</title>
    <script src="/JDWebShop/js/date.js" type="text/javascript"></script>
    <!--  -->
    <script type="text/javascript">
        //添加用户
        function addUser() {
            var form = document.forms[0];
            form.action = "${pageContext.request.contextPath}/user/register";
            form.method = "post";
            form.submit();
        }
    </script>

</head>
<body>
    <div>
        <h1>用户注册</h1>
        <img src="/JDWebShop/image/stop.png">
    </div>
    <div>
        <form  ><!-- action="/JDWebShop/user/register" method="post" -->
            <table>
                <tr>
                    <td>填写昵称*</td>
                    <td>
                        <input type="text" name="nickname">
                    </td>
                </tr>

                <tr>
                    <td>填写手机*</td>
                    <td>
                        <input type="text" name="tel">
                    </td>
                </tr>

                <tr>
                    <td>密码*</td>
                    <td>
                        <input type="password" name="pass">
                    </td>
                </tr>

                <tr>
                    <td>生日</td>
                    <td>
                        <input type="text" name="birth" onfocus="HS_setDate(this)">
                    </td>
                </tr>

                <tr>
                    <td>性别</td>
                    <td>
                        男<input type="radio" name="sex" value="男" checked="checked">
                        女<input type="radio" name="sex" value="女">
                        保密<input type="radio" name="sex" value="保密">
                    </td>
                </tr>

                <tr>
                    <td>居住地</td>
                    <td>
                        <input type="text" name="live">
                    </td>
                </tr>

                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <input type="button" value="提交" onclick="addUser()">
                    </td>
                </tr>

            </table>
        </form>
    </div>
</body>
</html>
