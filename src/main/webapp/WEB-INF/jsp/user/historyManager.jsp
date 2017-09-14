<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/9/4
  Time: 14:35
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
    <title>历史记录管路</title>
</head>
<body>
    <div>
        <table>
            <tr>
                <th><a href="javascript:void(0)" onclick="">全部记录</a></th>
                <th><a href="javascript:void(0)" onclick="">当月记录</a></th>
                <th><a href="javascript:void(0)" onclick="">上月记录</a></th>
                <th><a href="javascript:void(0)" onclick="">清空记录</a></th>
            </tr>
        </table>
    </div>

    <div>
        <c:if test="${not empty history}">
            <c:forEach var="one" items="${history}">
                <div>
                    <a href="<%=basePath%>goods/getGoods/${one.goodsHistory}">
                        <img src="<%=basePath%>picture/show?pic=${one.title}" width="150px" height="150px">
                        <br>
                        ${one.name} &nbsp;/&nbsp; ${one.price}
                    </a>
                    <br>
                    <a href="<%=basePath%>history/del/${one.id}">
                        删除
                    </a>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty history}">
            暂无历史
        </c:if>
    </div>
</body>
</html>
