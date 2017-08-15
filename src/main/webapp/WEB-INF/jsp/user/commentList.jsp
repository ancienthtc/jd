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
    <title>评价列表</title>
    <meta charset="UTF-8">

   <%-- <link rel="stylesheet" href="https://terryz.github.io/lib/bootstrap/3.3.7/css/bootstrap.min.css" />--%>
    <!-- bootstrap样式 -->
    <link rel="stylesheet" href="<%=basePath%>css/page/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css">
    <link rel="stylesheet" href="<%=basePath%>css/page/b.page.bootstrap3.css" type="text/css">
    <link rel="stylesheet" href="../static/libs/messenger/css/messenger.css" />
    <link rel="stylesheet" href="../static/libs/messenger/css/messenger-theme-future.css" />
    <style type="text/css">



    </style>


    <script type="text/javascript">

    </script>
</head>
<body >
<h2>评价管理</h2>
<div class="row-fluid">
    <div id="pageJsonContent" <%--style="width:1000px;"--%>>
        <table id="dataGridTableJson" <%--style="width: 1000px;"--%> class="table table-striped table-bordered table-hover table-condensed">
            <thead>

            <tr>
                <th class="selectColumn">评分</th>
                <th>评价内容</th>
                <th>商品名称</th>
                <th>评价日期</th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
    <div id="page3" <%--style="width:800px;margin-top:30px"--%>></div>
</div>
<%--分页插件--%>
<script type="text/javascript" src="<%=basePath%>js/page/b.page.js" ></script>
<script type="text/javascript" src="<%=basePath%>js/page/commentList.js" ></script>

<!-- 提示框的js -->
<script src="../static/libs/messenger/js/messenger.min.js"></script>
<script src="../static/util/imessenger.js"></script>
<!-- 确认框的js -->
<script src="../static/libs/jquery-confirm/jquery-confirm.js"></script>



</body>

</html>

<script type="text/javascript">
var cpro_id = "u1879755";</script>