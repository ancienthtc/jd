<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/8/21
  Time: 12:03
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
    <title>等待发货</title>

    <link rel="stylesheet" href="<%=basePath%>css/page/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css">
    <link rel="stylesheet" href="<%=basePath%>css/page/b.page.bootstrap3.css" type="text/css">
    <link rel="stylesheet" href="../static/libs/messenger/css/messenger.css" />
    <link rel="stylesheet" href="../static/libs/messenger/css/messenger-theme-future.css" />
    <link rel="stylesheet" href="https://terryz.github.io/lib/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../static/libs/iconfont/platform/iconfont.css" />
</head>
<body>
<div class="row-fluid">
    <div id="pageJsonContent">
        <table id="dataGridTableJson" class="table table-striped table-bordered table-hover table-condensed">
            <thead>
                <tr>
                    <th>订单号</th>
                    <th>下单日期</th>
                    <th>购买状态</th>
                    <th>付款状态</th>
                    <th>支付总额</th>
                    <th>运单号填写</th>
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
<script type="text/javascript" src="<%=basePath%>js/page/order_log.js" ></script>

<!-- 提示框的js -->
<script src="../static/libs/messenger/js/messenger.min.js"></script>
<script src="../static/util/imessenger.js"></script>
<!-- 确认框的js -->
<script src="../static/libs/jquery-confirm/jquery-confirm.js"></script>
<!-- layer -->
<script type="text/javascript" src="<%=basePath%>js/layer.js" ></script>
</html>
