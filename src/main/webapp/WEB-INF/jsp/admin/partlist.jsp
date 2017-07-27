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

<%--<table class="table table-striped table-bordered table-hover table-condensed">--%>
<%--<thead>--%>
<%--<tr>--%>
<%--<th class="selectColumn" >选择</th>--%>
<%--<th>板块名称</th>--%>
<%--<th>价格</th>--%>
<%--<th>量词</th>--%>
<%--<th>优先级</th>--%>
<%--<th>修改</th>--%>
<%--<th>删除</th>--%>
<%--</tr>--%>
<%--</thead>--%>
<%--<tbody>--%>
<%--<c:if test="${pageParts.dataList != null}">--%>
<%--<c:forEach var="item" items="${pageParts.dataList}">--%>
<%--<tr>--%>
<%--<td class="selectColumn"><input type="radio" name="goodsSelect" value="${item.id}" /></td>--%>
<%--<td>${item.pname}</td>--%>
<%--<td>${item.type}</td>--%>
<%--<td>${item.describe}</td>--%>
<%--<td>${item.priority}</td>--%>

<%--<td>--</td>--%>
<%--<td>--</td>--%>
<%--</tr>--%>
<%--</c:forEach>--%>
<%--</c:if>--%>
<%--</tbody>--%>
<%--</table>--%>
<%--<!-- 生成分页数据内容，必须设置 -->--%>
<%--<c:if test="${pageParts != null}">--%>
<%--<input type="hidden" id="pageNumber" value="${pageParts.pageNo}">--%>
<%--<input type="hidden" id="pageSize" value="${pageParts.pageSize}">--%>
<%--<input type="hidden" id="totalPage" value="${pageParts.pages}">--%>
<%--<input type="hidden" id="totalRow" value="${pageParts.total}">--%>
<%--</c:if>--%>

<%--<!-- 分页栏 -->--%>
<%--<div id="page1"></div>--%>

<div class="row-fluid">
    <div id="pageJsonContent">
        <table id="dataGridTableJson" class="table table-striped table-bordered table-hover table-condensed">
            <thead>
            <tr>
                <th class="selectColumn" >选择</th>
                <th>板块名称</th>
                <th>价格</th>
                <th>量词</th>
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

    <%--<div id="select_page" class="pagination bPage bPageRight">--%>
    <%--<ul>--%>
    <%--<li id="bPageList" class="disabled bPageList"><a>每页 <select id="bPageDropList"></select> 条</a></li>--%>
    <%--<li id="bPageInfo" class="disabled bPageInfo"><a>&nbsp;</a></li>--%>
    <%--<li id="bPageFirstPage" class="bPageControlButton"><a href="<%=basePath%>part/list2_json">首页</a></li>--%>
    <%--<li id="bPagePreviousPage" class="bPageControlButton"><a href="javascript:void(0);">«</a></li>--%>
    <%--<li id="bPageNextPage" class="bPageControlButton"><a href="javascript:void(0);">»</a></li>--%>
    <%--<li id="bPageLastPage" class="bPageControlButton"><a href="javascript:void(0);">尾页</a></li>--%>
    <%--</ul>--%>
    <%--</div>--%>


    <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/page/b.page.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/page/partlist.js" ></script>


    <script type="text/javascript">
        $(function(){
            SyntaxHighlighter.all();
        });
    </script>
</body>
</html>
