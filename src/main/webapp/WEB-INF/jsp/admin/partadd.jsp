<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/7/12
  Time: 16:50
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
    <title>板块添加</title>

    <script src="<%=basePath%>/js/jquery-3.1.1.js"></script>
    <script src="<%=basePath%>/js/jquery_add.js"></script>

    <!-- 确认框的js -->
    <script src="../static/libs/jquery-confirm/jquery-confirm.js"></script>

    <!-- 提示框的js -->
    <script src="../static/libs/messenger/js/messenger.min.js"></script>
    <script src="../static/util/imessenger.js"></script>

    <!-- layer -->
    <script type="text/javascript" src="<%=basePath%>js/layer.js" ></script>

    <script type="text/javascript">
        $(document).ready(function(){
            $("#submit").click(function() {
                var pname=$("input[name='pname']");
                if(pname.length<=0)
                {
                    alert("填写名称!");
                    return;
                }
                var Object = $('#form').serializeObject();
                var part = JSON.stringify(Object);
                jQuery.ajax( {
                    type : 'POST',
                    contentType : 'application/json',
                    url : '<%=basePath%>/part/add',
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
    <style>
        h2{text-align: center;}
        .biaoge{margin-left: 50px;}
        .biaoge th{font-size: 18px; font-family: "宋体";}
        input{border:1px solid #ddd;padding:10px 5px;width: 240px;height:30px;outline:none;
            border-radius:5px;background-color:#fff;margin-bottom: 15px;;
            font-family: 'revolt',georgia,'Microsoft yahei';}
        .youxianji{width: 90px;height:30px; margin-bottom: 15px;}
        #submit{background-color:#4797ED;border:none;border-radius:10px;
            box-shadow:0 0 3px #aaa;width:98px;height:31px;line-height:18px;
            color:#fff;font-size:18px;font-weight:bold;cursor:pointer;margin-left:90px;
            display:block;outline:none;text-shadow:0 1px 1px #777;float:left;
            margin-top: 10px;}
        #submit:hover {background-color:#d8d8d8;color:#666;text-shadow:1px 1px 1px #fff;}
    </style>
</head>
<body>

<div>
    <h2>板块添加</h2>
</div>
<div>
    <form id="form" method="post">
        <table class="biaoge">
            <tr>
                <th>板块名称&nbsp;</th>
                <td><input type="text" name="pname" ></td>
            </tr>

            <tr>
                <th>板块类型&nbsp;</th>
                <td><input type="text" name="type" ></td>
            </tr>

            <tr>
                <th>优先级&nbsp;</th>
                <td>
                    <select name="priority" class="youxianji">
                        <%
                            for (n=0;n<=10;n++)
                            {
                                out.print("<option value="+n+">"+n+"</option>");
                            }
                        %>
                    </select>
                </td>
            </tr>

            <tr>
                <th>板块描述&nbsp;</th>
                <td><input type="text" name="describe" ></td>
            </tr>

            <tr>
                <td colspan="2"> <input type="button" value="添加" id="submit" /></td>
            </tr>
        </table>
    </form>
</div>
<%--<div>--%>
<%--<input type="button" onclick="window.location.href='<%=basePath%>part/toPartList'" value="返回">--%>
<%--</div>--%>
</body>
</html>
