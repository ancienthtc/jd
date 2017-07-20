<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/7/7
  Time: 16:01
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
    <title>商品添加</title>

    <script src="<%=basePath%>/js/jquery-3.1.1.js"></script>

    <script src="<%=basePath%>/js/date.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function(){

            $('#bt1').click(function(){
                //alert("xx");
                window.location="<%=basePath%>/goods/goodslist";
            });

            $("#submit").click(function() {
                var Object = $('#form').serializeObject();
                var addGoods = JSON.stringify(Object);
                jQuery.ajax( {
                    type : 'POST',
                    contentType : 'application/json',
                    url : '<%=basePath%>/goods/add',
                    data : addGoods,
                    dataType : 'json',
                    success : function(data) {
                        alert("新增成功！");
                    },
                    error : function(data) {
                        alert("error")
                    }
                });
            });

        });

    </script>

    <script type="text/javascript">
        (function($) {
            $.fn.extend({
                serializeObject : function() {
                    var o = {};
                    var a = this.serializeArray();
                    $.each(a, function() {
                        if (o[this.name]) {
                            if (!o[this.name].push) {
                                o[this.name] = [ o[this.name] ];
                            }
                            o[this.name].push(this.value || '');
                        } else {
                            o[this.name] = this.value || '';
                        }
                    });
                    return o;
                }
            });

        })(jQuery)
    </script>

</head>
<body>
    <div>
        <form id="form" action="add" method="post">
        <table>

            <tr>
                <th>商品名*</th>
                <td id="name">
                    <div>
                        <input type="text" name="name" >
                    </div>
                </td>
            </tr>

            <tr>
                <th>单价*</th>
                <td id="price">
                    <div>
                        <input type="number" name="price"  >
                    </div>
                </td>
            </tr>

            <tr>
                <th>单位*</th>
                <td id="gclass">
                    <div>
                        <input type="text" name="gclass" >
                    </div>
                </td>
            </tr>

            <tr>
                <th>参数/规格1*</th>
                <td id="parameter1">
                    <div>
                        <input type="text" name="parameter1" >
                    </div>
                </td>
            </tr>

            <tr>
                <th>参数/规格2</th>
                <td id="parameter2">
                    <div>
                        <input type="text" name="parameter2" >
                    </div>
                </td>
            </tr>

            <tr>
                <th>参数/规格3</th>
                <td id="parameter3">
                    <div>
                        <input type="text" name="parameter3" >
                    </div>
                </td>
            </tr>

            <tr>
                <th>运费</th>
                <td id="freight">
                    <div>
                        <input type="number" name="freight" >
                    </div>
                </td>
            </tr>

            <tr>
                <th>商品详情</th>
                <td id="detail">
                    <div>
                        <textarea name="detail" rows="3" cols="20"></textarea>
                    </div>
                </td>
            </tr>

            <tr>
                <td >
                    <div>
                        <%--<input id="bt" type="button" value="提交" >--%>
                        <input type="button" value="提交" id="submit" />
                    </div>
                </td>
            </tr>
        </table>
        </form>
    </div>

    <div>
        <input type="button" onclick="window.location.href='<%=basePath%>/admin/tohome'" value="返回">
    </div>
    <%--<div>--%>
        <%--<button id="bt1" value="xx">ccc</button><br>--%>
        <%--<input type="text" name="xx" onfocus="HS_setDate(this)">--%>
    <%--</div>--%>

</body>
</html>
