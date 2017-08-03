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
    <style type="text/css">
        *{margin:0;padding:0;list-style-type:none;}
        a,img{border:0;}
        body{font:16/180% Arial, Helvetica, sans-serif, "微软雅黑","黑体";background:#eee;text-align:center;}
        header{ font-size: 30px;  margin-top: 50px; margin-left: -360px;}
        table {border-collapse:collapse;border-spacing:0; margin-left: 500px; margin-top: 80px;}

        td,th {padding:0;}


        .clear {clear:both;}
        .clear:before,.clear:after {content:"";display:table;}
        .clear:after {clear:both;}

        /* form-div */
        .form-div{background-color:rgba(255,255,255,0.27); border-radius:10px; border:1px solid #aaa; width:424px; margin:0 auto;padding:30px 0 20px 0px; font-size:12px;box-shadow:inset 0px 0px 10px rgba(255,255,255,0.5),0px 0px 15px rgba(75,75,75,0.3); text-align:left;}

        .form-div input[type="text"], .form-div input[type="password"], .form-div input[type="email"]{width:268px; margin:10px; line-height:20px; font-size:16px;}
        .form-div input[type="checkbox"]{margin:20px 0 20px 10px;}
        .form-div input[type="button"],.form-div input[type="submit"]{margin:10px 20px 0 0;}

        .form-div table{margin:0 auto; text-align:right; color:rgba(64,64,64,1.00);}
        .form-div table img{vertical-align:middle; margin:0 0 5px 0;}
        .footer{color:rgba(64,64,64,1.00); font-size:12px; margin-top:30px;}
        .form-div .buttons{float:right;}

        input[type="text"], input[type="password"], input[type="email"] {
            border-radius:8px;
            box-shadow:inset 0 2px 5px #eee;
            padding:10px;
            border:1px solid #D4D4D4;
            color:#333333;
            margin-top:5px;
        }
        input[type="text"]:focus, input[type="password"]:focus, input[type="email"]:focus {
            border:1px solid #50afeb;
            outline:none;
        }
        input[type="button"], input[type="submit"] {
            padding:7px 15px;
            background-color:#3c6db0;
            text-align:center;
            border-radius:5px;
            overflow:hidden;
            min-width:80px;
            border:none;
            color:#FFF;
            box-shadow:1px 1px 1px rgba(75,75,75,0.3);
        }
        input[type="button"]:hover, input[type="submit"]:hover {
            background-color:#5a88c8;
        }
        input[type="button"]:active, input[type="submit"]:active {
            background-color:#5a88c8;
        }
    </style>
</head>
<body>
    <div>
        <header> &gt;&gt; **商城用户注册系统</header>

    </div>
    <div>
        <form  class="reg-form" action="" method="post"><!-- action="/JDWebShop/user/register" method="post" -->
            <table>
                <tr>
                    <td>用&nbsp;户&nbsp;名&nbsp;&nbsp;</td>
                    <td>
                        <input type="text" name="nickname"  class="uid"
                               easyform="length:4-16;char-normal;real-time;"
                               message="用户名必须为4—16位的英文字母或数字"
                               easytip="disappear:lost-focus;theme:blue;"
                               ajax-message="用户名已存在!">
                    </td>
                </tr>

                <tr>
                    <td>密&nbsp;&nbsp;&nbsp;&nbsp;码&nbsp;&nbsp;</td>
                    <td>
                        <input type="text" name="tel" class="psw1" easyform="length:6-16;"
                               message="密码必须为6—16位" easytip="disappear:lost-focus;theme:blue;">
                    </td>
                </tr>

                <tr>
                    <td>确认密码&nbsp;&nbsp;</td>
                    <td>
                        <input type="password" name="pass" class="psw2" easyform="length:6-16;equal:#psw1;"
                               message="两次密码输入要一致" easytip="disappear:lost-focus;theme:blue;">
                    </td>
                </tr>
                <tr>
                    <td>email</td>
                    <td><input name="email" type="text" class="email" easyform="email;real-time;" message="Email格式要正确" easytip="disappear:lost-focus;theme:blue;" ajax-message="这个Email地址已经被注册过，请换一个吧!"></td>
                </tr>
                <tr>
                    <td>生&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;</td>
                    <td>
                        <input type="text" name="birth" onfocus="HS_setDate(this)">
                    </td>
                </tr>

                <tr>
                    <td style="line-height: 30px;">性&nbsp;&nbsp;&nbsp;&nbsp;别&nbsp;&nbsp;</td>
                    <td>
                        &nbsp;&nbsp;男<input type="radio" name="sex" value="男" checked="checked">&nbsp;&nbsp;
                        女<input type="radio" name="sex" value="女">&nbsp;&nbsp;
                        保密<input type="radio" name="sex" value="保密">
                    </td>
                </tr>

                <tr>
                    <td>居&nbsp;住&nbsp;地&nbsp;&nbsp;</td>
                    <td>
                        <input type="text" name="live">
                    </td>
                </tr>

                <tr>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td style="padding: 30px;">
                        <input type="button" value="提交" onclick="addUser()">
                    </td>
                </tr>

            </table>
        </form>
    </div>
</body>
</html>
