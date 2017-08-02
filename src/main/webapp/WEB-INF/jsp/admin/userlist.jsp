<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/7/27
  Time: 15:02
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
    <title>用户列表</title>
    <meta charset="UTF-8">

    <link rel="stylesheet" href="https://terryz.github.io/lib/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css">
    <link rel="stylesheet" href="<%=basePath%>css/page/b.page.bootstrap3.css" type="text/css">

</head>
<body>


<div class="row-fluid">
    <div id="pageJsonContent">
        <table id="dataGridTableJson" class="table table-striped table-bordered table-hover table-condensed">
            <thead>
            <tr>
                <%--<th class="selectColumn" >选择</th>--%>
                <th>用户名</th>
                <th>手机</th>
                <th>生日</th>
                <th>性别</th>
                <th>居住地</th>
                <th>上次登录时间</th>
                <th>积分</th>
                <th>修改</th>
                <th>删除</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div id="page"></div>



    <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/page/b.page.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/page/userlist.js" ></script>


    <script type="text/javascript">
        $(function(){
            SyntaxHighlighter.all();
        });
    </script>
</div>
</body>
</html>