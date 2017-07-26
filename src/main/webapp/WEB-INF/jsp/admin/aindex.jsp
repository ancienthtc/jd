<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<%--<html lang="en" xmlns:th="http://www.thymeleaf.org">--%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="UTF-8" />
    <title>飞食科技后台-首页</title>
    <!-- bootstrap样式 -->
    <link rel="stylesheet" href="../static/libs/bootstrap/bootstrap.min.css" />
    <!-- 头像上传样式 -->
    <link rel="stylesheet" href="../static/libs/h5-imgUpload/css/cropper.min.css" />
    <link rel="stylesheet" href="../static/libs/h5-imgUpload/css/sitelogo.css" />
    <!-- iconfont样式 -->
    <link rel="stylesheet" href="../static/libs/iconfont/merchant/iconfont.css" />
    <!-- 富文本编译器样式 -->
    <link rel="stylesheet" href="../static/libs/wangedit/wangEditor.min.css" />
    <!-- 时间选择器样式 -->
    <link rel="stylesheet" href="../static/libs/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" />
    <!-- jquery-UI -->
    <link rel="stylesheet" href="../static/libs/jquery-ui/themes/smoothness/jquery-ui.css" />
    <!-- 确认框的样式引入 -->
    <link rel="stylesheet" href="../static/libs/jquery-confirm/jquery-confirm.css" />
    <!-- 提示框的样式引入 -->
    <link rel="stylesheet" href="../static/libs/messenger/css/messenger.css" />
    <link rel="stylesheet" href="../static/libs/messenger/css/messenger-theme-future.css" />
    <!--公共样式引入-->
    <link rel="stylesheet" href="../static/css/merchant/public/reset.css" />
    <link rel="stylesheet" href="../static/css/merchant/resetbootstrap.css" />
    <!--首页样式引入-->
    <link rel="stylesheet" href="../static/css/merchant/index.css" />
    <link rel="stylesheet" href="../static/css/merchant/mainBox.css" />
</head>

<body>
    <div class="mainBox">
        <!--左边侧边栏部分-->
        <div class="leftBox">
            <!--logo-->
            <div class="logo"><p>后台模板管理系统</p></div>
            <!--左边导航栏列表开始-->
            <div class="slideBarBox">
                <ul>
                    <!-- 板块管理 -->
                    <li class="default">
                        <p id="part"><span class="iconfont icon-comm"></span>板块管理<i class="iconfont icon-right arrow"></i></p>
                      <!--  <ul class="secondNav">
                            <li id="part"><a href="javascript:void(0);">板块管理</a></li>
                            <li ><a href="javascript:void(0);">xxx</a></li>

                        </ul>-->
                    </li>
                    <!-- 商品管理 -->
                    <li class="default" >
                        <p><span class="iconfont icon-products"></span>商品管理<i class="iconfont icon-right arrow"></i></p>
                       <!-- <ul class="secondNav">
                            <li id="good"><a href="javascript:void(0);">商品列表</a></li>
                            <li ><a href="javascript:void(0);">xxx</a></li>

                        </ul>-->
                    </li>
                    <!-- 用户管理 -->
                    <li class="default" >
                        <p><span class="iconfont icon-manage"></span>用户管理<i class="iconfont icon-right arrow"></i></p>
                       <!-- <ul class="secondNav">
                            <li id="admin"><a href="javascript:void(0);">用户列表</a></li>
                            <li ><a href="javascript:void(0);">xxx</a></li>

                        </ul>-->
                    </li>
                    <!-- 订单管理 -->
                    <li class="default" >
                        <p><span class="iconfont icon-hidecase"></span>订单管理<i class="iconfont icon-right arrow"></i></p>
                        <ul class="secondNav">
                            <li id="order"><a href="javascript:void(0);">订单列表</a></li>
                            <li ><a href="javascript:void(0);">xxx</a></li>
                        </ul>
                    </li>
                    <!-- 评价管理 -->
                    <li class="default" >
                        <p><span class="iconfont icon-edit"></span>评价管理<i class="iconfont icon-right arrow"></i></p>
                        <ul class="secondNav">
                            <li id="evaluate"><a href="javascript:void(0);">评价列表</a></li>
                            <li ><a href="javascript:void(0);">xxx</a></li>
                        </ul>
                    </li>
                    <!-- 公告管理 -->
                    <li class="default" >
                        <p><span class="iconfont icon-msg"></span>公告管理<i class="iconfont icon-right arrow"></i></p>
                        <ul class="secondNav">
                            <li id="message"><a href="javascript:void(0);">公告列表</a></li>
                            <li ><a href="javascript:void(0);">xxx</a></li>
                        </ul>
                    </li>

                </ul>
            </div>
        </div>
        <!--右边部分-->
        <div class="rightBox">
            <div class="topNav">
                <!--个人设置和退出登录-->
                <!-- <a href="javascript:void(0);" class="logout">
          <div class="userImg"><img src="../../../static/img/platform/icon.png" alt="用户头像" width="44" height="44"/></div>
          <span class="userName">Admin</span>
          <div class="logoutBox">
            <span>个人中心</span>
            <span>退出登录</span>
          </div>
        </a>
        <a href="javascript:void(0);" id="topMsg" class="msgBox"><i class="iconfont icon-msg"></i> <span class="msgNum">3</span></a> -->
            </div>
            <div class="contentBox" id="contentBoxId"></div>
        </div>
    </div>
   <!--<input type="hidden" th:value="${session.indexPoin}" id="indexPoin" />-->
 
    <!-- 公共插件引入 -->
    <script src="../static/libs/jquery/jquery.min.js"></script>
    <!-- 排序   -->
    <script src="../static/libs/jquery-ui/jquery-ui.min.js"></script>
    <script src="../static/libs/bootstrap/tether.min.js"></script>
    <script src="../static/libs/bootstrap/bootstrap.min.js"></script>
    <!-- 确认框的js -->
    <script src="../static/libs/jquery-confirm/jquery-confirm.js"></script>
    <!-- 提示框的js -->
    <script src="../static/libs/messenger/js/messenger.min.js"></script>
    <script src="../static/util/imessenger.js"></script>
    <!-- 公共js -->
    <script src="../static/js/merchant/public/public.js"></script>
    <script src="../static/util/iform.js"></script>
    <script src="../static/util/iverify.js"></script>
    <script src="../static/util/icheck.js"></script>

    <script src="../static/js/merchant/public/index.js"></script>
    
</body>
<!--<script th:inline="javascript">
    /*<![CDATA[*/
    ctx = [[${application.get('ctx')}]];
    /*]]>*/
  </script>-->

</html>
