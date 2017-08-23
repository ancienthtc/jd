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
    <style>
        .login_btn_div a .sub_btn:hover{background: #2e8ded;}
    </style>

    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/style2.css" />
    <script src="<%=basePath%>js/jquery-3.1.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function() {
            $('#login').click(function() {
                var name_state = $('#name');
                var psd_state = $('#psd');
                var name = $('#name').val();
                var psd = $('#psd').val();
                if (name == '') {
                    name_state.parent().next().next().css("display", "block");
                    return false;
                } else if (psd == '') {
                    name_state.parent().next().next().css("display", "none");
                    psd_state.parent().next().next().css("display", "block");
                    return false;
                } else {
                    name_state.parent().next().next().css("display", "none");
                    psd_state.parent().next().next().css("display", "none");
                    $('.login').submit();
                }
            });

        })
        function ok_or_errorBylogin(l) {
            var content = $(l).val();
            if (content != "") {
                $(l).parent().next().next().css("display", "none");
            }
        }
        function ok_or_errorByRegister(r) {
            var affirm_psd = $("#affirm_psd");
            var psd_r = $("#psd_r");
            var affirm_psd_v = $("#affirm_psd").val();
            var psd_r_v = $("#psd_r").val();
            var content = $(r).val();
            if (content == "") {
                $(r).parent().next().next().css("display", "block");
                return false;
            } else {
                $(r).parent().next().css("display", "block");
                $(r).parent().next().next().css("display", "none");
                if (psd_r_v == "") {
                    $(psd_r).parent().next().css("display", "none");
                    $(psd_r).parent().next().next().css("display", "none");
                    $(psd_r).parent().next().next().css("display", "block");
                    return false;
                }
                if (affirm_psd_v == "") {
                    $(affirm_psd_v).parent().next().css("display", "none");
                    $(affirm_psd_v).parent().next().next().css("display", "none");
                    $(affirm_psd_v).parent().next().next().css("display", "block");
                    return false;
                }
                if (psd_r_v == affirm_psd_v) {
                    $(affirm_psd).parent().next().css("display", "none");
                    $(affirm_psd).parent().next().next().css("display", "none");
                    $(psd_r).parent().next().css("display", "none");
                    $(psd_r).parent().next().next().css("display", "none");
                    $(affirm_psd).parent().next().css("display", "block");
                    $(psd_r).parent().next().css("display", "block");
                } else {
                    $(affirm_psd).parent().next().css("display", "none");
                    $(affirm_psd).parent().next().next().css("display", "none");
                    $(psd_r).parent().next().css("display", "none");
                    $(psd_r).parent().next().next().css("display", "none");
                    $(psd_r).parent().next().css("display", "block");
                    $(affirm_psd).parent().next().next().css("display", "block");
                    return false;
                }
            }
        }
        function barter_btn(bb) {
            $(bb).parent().parent().fadeOut(1000);
            $(bb).parent().parent().siblings().fadeIn(2000);
        }
    </script>
</head>
<body class="login_body" style="background: url('<%=basePath%>image/login.jpg') no-repeat;background-size:cover;">
<div class="login_div">
    <div class="col-xs-12 login_title">登录</div>
        <form name="form1" action="<%=basePath %>login/ton " method="post" >
            <div class="nav">
                <div class="nav login_nav">
                    <div class="col-xs-4 login_username">
                        用户名:
                    </div>
                    <div class="col-xs-6 login_usernameInput">
                        <input type="text" name="username" id="name" value="" placeholder="&nbsp;&nbsp;用户名/手机号"  onblur="javascript:ok_or_errorBylogin(this)" />
                    </div>
                    <div class="col-xs-1 ok_gou">
                        √
                    </div>
                    <div class="col-xs-1 error_cuo">
                        ×
                    </div>
                </div>
                <div class="nav login_psdNav">
                    <div class="col-xs-4">
                        密&nbsp;&nbsp;&nbsp;码:
                    </div>
                    <div class="col-xs-6">
                        <input type="password" name="password" id="psd" value="" placeholder="&nbsp;&nbsp;密码" onBlur="javascript:ok_or_errorBylogin(this)" />
                    </div>
                    <div class="col-xs-1 ok_gou">
                        √
                    </div>
                    <div class="col-xs-1 error_cuo">
                        ×
                    </div>
                </div>
                <div class="col-xs-12 login_btn_div barter_btnDiv" >
                    <a href="#"><input type="submit" class="sub_btn barter_btn" id="login" value="登录"  style="margin-bottom: 150px; background: #6c6c6c; color: white;" /></a>
                </div>
            </div>
        </form>
    <div class="col-xs-12 barter_btnDiv">
        <a href="<%=basePath%>login/reg"><button class="barter_btn">没有账号?前往注册</button></a>
    </div>
    </div>
    <div>
        ${message}
    </div>


</body>
</html>
