<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <title>商品列表</title>
    <meta charset="UTF-8">

    <link rel="stylesheet" href="https://terryz.github.io/lib/bootstrap/3.3.7/css/bootstrap.min.css" />

    <link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css">
    <link rel="stylesheet" href="<%=basePath%>css/page/b.page.bootstrap3.css" type="text/css">

    <!-- bootstrap样式 -->
    <link rel="stylesheet" href="../static/libs/bootstrap/bootstrap.min.css" />
    <!-- 头像上传样式 -->
    <link rel="stylesheet" href="../static/libs/h5-imgUpload/css/cropper.min.css" />
    <link rel="stylesheet" href="../static/libs/h5-imgUpload/css/sitelogo.css" />


    <!-- 时间选择器样式 -->
    <link rel="stylesheet" href="../static/libs/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" />
    <!-- jquery-UI -->
    <link rel="stylesheet" href="../static/libs/jquery-ui/themes/smoothness/jquery-ui.css" />
    <!-- 确认框的样式引入 -->
    <link rel="stylesheet" href="../static/libs/jquery-confirm/jquery-confirm.css" />
    <!-- 提示框的样式引入 -->
    <link rel="stylesheet" href="../static/libs/messenger/css/messenger.css" />
    <link rel="stylesheet" href="../static/libs/messenger/css/messenger-theme-future.css" />



    <script type="text/javascript">

    </script>
</head>
<body>
<div class="location">
    <span class="title">商品管理</span>
    <!-- 搜索 -->
    <form class="search form-inline">

        <%--<input type="text" class="form-control" id="inlineFormInput" placeholder="请输入需要查询的内容" />
        <a href="javascript:void(0);" class="btnGreen">查询</a>--%>
        <a href="javascript:void(0);" class="btnGreen" data-btn="addNew">添加</a>
    </form>
</div>
<div class="row-fluid">
    <div id="pageJsonContent">
        <table id="dataGridTableJson" class="table table-striped table-bordered table-hover table-condensed">
            <thead>

            <tr>
                <th class="selectColumn">商品名称</th>
                <th>单价</th>
                <td>量</td>
                <th>参数1</th>
                <th>参数2</th>
                <th>参数3</th>
                <th>运费</th>
                <th>详情</th>
                <th>销量</th>
                <th>库存</th>
                <th>上架日期</th>
                <th>修改</th>
                <th>删除</th>
                <th>上/下架</th>
               <%-- <th class="selectColumn" >选择</th>
                <th>板块名称</th>
                <th>价格</th>
                <th>量词</th>
                <th>优先级</th>
                <th>--</th>
                <th>--</th>--%>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
    <div id="page3"></div>


<div>${message}</div>

<script src="<%=basePath%>js/jquery-3.1.1.js" type="text/javascript"></script>
<script src="../static/libs/bootstrap/bootstrap.min.js"></script>
<script src="<%=basePath%>js/admin/public.js" type="text/javascript"></script>

<%--分页插件--%>
<script type="text/javascript" src="<%=basePath%>js/page/b.page.js" ></script>
<script type="text/javascript" src="<%=basePath%>js/page/goodslist.js" ></script>

<!-- 提示框的js -->
<script src="../static/libs/messenger/js/messenger.min.js"></script>
<script src="../static/util/imessenger.js"></script>
<!-- 确认框的js -->
<script src="../static/libs/jquery-confirm/jquery-confirm.js"></script>



</body>

</html>

<script type="text/javascript">
var cpro_id = "u1879755";</script>