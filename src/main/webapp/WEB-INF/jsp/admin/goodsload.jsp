<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/7/11
  Time: 16:03
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
    <title>商品上架</title>

    <script type="text/javascript">
        //添加用户
        function loadGoods() {
            var form = document.forms[0];
            form.action = "${pageContext.request.contextPath}/goods/goodsload";
            form.method = "post";
            form.submit();
        }
    </script>
</head>
<body>
    <div>
        <h2>当前商品:${goods.name}</h2>
    </div>
    <div>
        <form >
            <input type="hidden" name="goodsid" value="${goods.id}">
            <table>
                <tr>
                    <th>库存量*</th>
                    <td><input type="number" name="stock" /></td>
                </tr>
                <tr>
                    <th>选择板块*</th>
                    <td><select id="part" name="partid" >
                            <c:forEach var="part" items="${parts}">
                                <option value="${part.id}" >${part.pname}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>&nbsp;</th>
                    <td>
                        <input type="button" value="提交" onclick="loadGoods()">
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <div>
        <input type="button" value="返回" onclick="window.location.href='<%=basePath%>/goods/goodslist'">
    </div>

</body>
</html>
