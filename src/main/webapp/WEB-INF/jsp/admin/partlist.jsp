<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/7/24
  Time: 14:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
    //    Map<String,Object> info = (HashMap<String,Object>) pageContext.getAttribute("pageParts");
//    String totalpages=info.get("pages").toString();
%>
<html>
<head>
    <title>板块列表</title>
    <meta charset="UTF-8">

    <link rel="stylesheet" href="https://terryz.github.io/lib/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css">
    <link rel="stylesheet" href="<%=basePath%>css/page/b.page.bootstrap3.css" type="text/css">

    <script type="text/javascript">
    </script>
</head>
<body>


<div class="row-fluid">
    <div class="location">
        <span class="title">板块管理</span>
        <!-- 搜索 -->
        <form class="search form-inline">

            <%--<input type="text" class="form-control" id="inlineFormInput" placeholder="请输入需要查询的内容" />
            < a href=" " class="btnGreen">查询</ a>--%>
            <button href="javascript:void(0);" class="btnGreen" id="addPart" >
                <i class="iconfont icon-add" data-btn="add" data-toggle="tooltip" data-placement="bottom" data-original-title="添加">
                </i>
            </button>
        </form>
    </div>
    <%--<div><button id="addPart">板块添加</button><br></div>--%>
    <div id="pageJsonContent">
        <table id="dataGridTableJson" class="table table-striped table-bordered table-hover table-condensed">
            <thead>
            <tr>
                <%--<th class="selectColumn" >选择</th>--%>
                <th>板块名称</th>
                <th>类型</th>
                <th>描述</th>
                <th>优先级</th>
                <th>修改</th>
                <th>删除</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div id="page3"></div>




    <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/page/b.page.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/page/partlist.js" ></script>

    <!-- 确认框的js -->
    <script src="../static/libs/jquery-confirm/jquery-confirm.js"></script>

    <!-- 提示框的js -->
    <script src="../static/libs/messenger/js/messenger.min.js"></script>
    <script src="../static/util/imessenger.js"></script>

    <!-- layer -->
    <script type="text/javascript" src="<%=basePath%>js/layer.js" ></script>

    <%--解析表单数据--%>
    <script src="../static/util/iform.js"></script>

    <script type="text/javascript">
//        $(function(){
//            SyntaxHighlighter.all();
//        });
    </script>
</div>
</body>
</html>