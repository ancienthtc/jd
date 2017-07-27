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

    <script type="text/javascript">

    </script>
</head>
<body>
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
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div id="page3"></div>


    <div class="modal fade messageModal">
        <input type="hidden" id="messageId" />
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5>通知详情</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="" id="messageForm">
                        <p class="title" name="title">提醒发货</p>
                        <p class="time" name="createTimeStr">2017-10-09</p>
                        <div class="desGroup">
                            <p name="content" class="content"></p>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

<div>${message}</div>

<script src="<%=basePath%>js/jquery-3.1.1.js" type="text/javascript"></script>

<script src="<%=basePath%>js/public.js" type="text/javascript"></script>

<%--分页插件--%>
<script type="text/javascript" src="<%=basePath%>js/page/b.page.js" ></script>
<script type="text/javascript" src="<%=basePath%>js/page/goodslist.js" ></script>



</body>

</html>

<script type="text/javascript">
var cpro_id = "u1879755";</script>