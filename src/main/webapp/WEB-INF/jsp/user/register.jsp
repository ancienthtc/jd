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

    <div id="user">
        <form id="userForm">
            <div class="btGroup">
                <label>用户名</label>
                <input type="text" class="form-control" name="nickname" id="nickname"/>
                <span class="tips"></span>
            </div>
            <div class="btGroup">
                <label>密码</label>
                <input type="password" class="form-control" name="pass" id="pass"/>
                <span class="tips"></span>
            </div>

            <div class="btGroup">
                <label>确认密码</label>
                <input type="password" class="form-control" id="repass"/>
                <span class="tips"></span>
            </div>

            <div class="btGroup">
                <label>手机</label>
                <input type="text" class="form-control" name="tel" />
                <span class="tips"></span>
            </div>

            <div id="cover" class="btGroup">
                <label>生日:</label>
                <input type="text" class="form-control" name="birth" id="datetimepicker"/>
            </div>

            <div class="btGroup">
                <label>性别</label>
                <select class="form-control" name="sex">
                    <option value="男" selected="selected">男</option>
                    <option value="女" >女</option>
                </select>
            </div>

            <div class="btGroup">
                <label>居住地</label>
                <input type="text" class="form-control" name="live"/>
                <span class="tips"></span>
            </div>

            <!-- 添加产品 -->
            <p class="text-center">
                <a href="javascript:void(0);" class="btnGreen" data-btn="Save">保存</a>
            </p>
        </form>
    </div>


    <%--<script src="<%=basePath%>js/jquery-3.1.1.js"></script>--%>
    <script src="../static/libs/jquery/jquery.min.js"></script>
    <!-- 时间选择器 -->
    <script src="../static/libs/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script src="../static/libs/bootstrap-datetimepicker-master/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="../static/libs/file/ajaxfileupload.js"></script>
    <!-- 提示框的js -->
    <script src="../static/libs/messenger/js/messenger.min.js"></script>
    <script src="../static/util/imessenger.js"></script>
    <!-- 确认框的js -->
    <script src="../static/libs/jquery-confirm/jquery-confirm.js"></script>
    <!-- 封装的iForm -->
    <script src="../static/util/iform.js"></script>

    <!-- layer -->
    <script type="text/javascript" src="<%=basePath%>js/layer.js" ></script>

    <script>
        $('#datetimepicker').datetimepicker({
            language: 'zh-CN', //显示中文
            format: 'yyyy-mm-dd', //显示格式
            minView: "month", //设置只显示到月份
            initialDate: new Date(), //初始化当前日期
            autoclose: true, //选中自动关闭
        });
    </script>

    <script type="text/javascript">

        $('[data-btn="Save"]').click(function(){
            var datas = iform.parseForm('userForm');
            datas.sex = $('#userForm').find("option:selected").attr("value");
            $.ajax({
                url:"../user/register",
                data:datas,
                type:"post",
                dataType:"json",
                success:function(data){
                    if(data=="0")
                    {
                        alert("注册失败!");
                    }
                    else if(data=="-1")
                    {
                        alert("用户名已存在!");
                    }
                    else if(data=="1")
                    {
                        alert("注册成功!");
                        window.location.href="<%=basePath%>login/login";
                    }
                },
                error:function () {
                    alert("请求失败");
                }
            })
        })
    </script>

</body>
</html>
