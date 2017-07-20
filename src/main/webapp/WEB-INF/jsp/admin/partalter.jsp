<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/7/19
  Time: 16:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%!
    int n;
%>
<html>
<head>
    <title>板块修改</title>
</head>

        <script src="<%=basePath%>/js/jquery-3.1.1.js"></script>
        <script src="<%=basePath%>/js/jquery_add.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#submit").click(function() {
                    var Object = $('#form').serializeObject();
                    var part = JSON.stringify(Object);
                    jQuery.ajax( {
                        type : 'POST',
                        contentType : 'application/json',
                        url : '<%=basePath%>/part/update',
                        data : part,
                        dataType : 'json',
                        success : function(data) {
                            alert("新增成功！");
                        },
                        error : function(data) {
                            alert("新增失败！")
                        }
                    });
                });
            });

        </script>
<body>
<div>
    <h2>板块修改</h2>
</div>
<div>
    <form id="form" method="post">
        <input type="hidden" name="id" value="${part.id}">
        <table>
            <tr>
                <th>板块名称</th>
                <td><input type="text" name="pname" value="${part.pname}"></td>
            </tr>

            <tr>
                <th>板块类型</th>
                <td><input type="text" name="type" value="${part.type}"></td>
            </tr>

            <tr>
                <th>优先级</th>
                <td>
                    <select name="priority" >
                        <option value="${part.priority}"> ${part.priority} </option>
                        <%
                            for (n=0;n<=10;n++)
                            {
                                //if (n != Integer.valueOf(request.getAttribute("priority").toString()))
                                {
                                    out.print("<option value=" + n + ">" + n + "</option>");
                                }
                            }
                        %>
                    </select>
                </td>
            </tr>

            <tr>
                <th>板块描述</th>
                <td><input type="text" name="describe" value="${part.describe}"></td>
            </tr>

            <tr>
                <td colspan="2"> <input type="button" value="修改" id="submit" /></td>
            </tr>
        </table>
    </form>
</div>
<div>
    <input type="button" onclick="window.location.href='<%=basePath%>part/list'" value="返回">
</div>
</body>
</html>
