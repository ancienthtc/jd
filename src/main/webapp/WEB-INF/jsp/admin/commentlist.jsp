<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/8/23
  Time: 16:58
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
    <title>评论管理</title>

    <link rel="stylesheet" href="<%=basePath%>css/page/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css">
    <link rel="stylesheet" href="<%=basePath%>css/page/b.page.bootstrap3.css" type="text/css">
    <link rel="stylesheet" href="../static/libs/messenger/css/messenger.css" />
    <link rel="stylesheet" href="../static/libs/messenger/css/messenger-theme-future.css" />
    <link rel="stylesheet" href="https://terryz.github.io/lib/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../static/libs/iconfont/platform/iconfont.css" />
</head>
<body>
<h2>评论管理</h2>
<div class="row-fluid">
    <div id="pageJsonContent">
        <table id="dataGridTableJson" class="table table-striped table-bordered table-hover table-condensed">
            <thead>

            <tr>
                <th>星级</th>
                <th>评论日期</th>
                <th>内容查看</th>
                <th>商品</th>
                <th>用户</th>
                <th>删除</th>
            </tr>

            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
    <div id="page3"></div>
</div>

</body>

<%--分页插件--%>
<script type="text/javascript" src="<%=basePath%>js/page/b.page.js" ></script>
<!-- 数据源js -->
<script type="text/javascript" src="<%=basePath%>js/page/commentlist_admin.js" ></script>

<!-- 提示框的js -->
<script src="../static/libs/messenger/js/messenger.min.js"></script>
<script src="../static/util/imessenger.js"></script>
<!-- 确认框的js -->
<script src="../static/libs/jquery-confirm/jquery-confirm.js"></script>
<!-- layer -->
<script type="text/javascript" src="<%=basePath%>js/layer.js" ></script>

</html>
