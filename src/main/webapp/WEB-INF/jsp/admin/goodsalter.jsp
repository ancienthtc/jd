<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/7/12
  Time: 9:29
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
    <title>商品修改</title>

    <script src="<%=basePath%>/js/jquery-3.1.1.js"></script>

    <script type="text/javascript">
        $(document).ready(function(){

            $("#submit").click(function() {
                var Object = $('#form').serializeObject();
                var goods = JSON.stringify(Object);
                jQuery.ajax( {
                    type : 'POST',
                    contentType : 'application/json',
                    url : '<%=basePath%>/goods/update',
                    data : goods,
                    dataType : 'json',
                    success : function(data) {
                        alert("保存成功！");
                    },
                    error : function(data) {
                        alert("保存失败!")
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
        <h2>${goods.id} 号商品修改</h2>
    </div>

    <div>
        <form  id="form" action="update" method="post">
            <input type="hidden" name="id" value="${goods.id}">
            <table>

                <tr>
                    <th>商品名*</th>
                    <td id="name">
                        <div>
                            <input type="text" name="name" value="${goods.name}">
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>单价*</th>
                    <td id="price">
                        <div>
                            <input type="number" name="price" value="${goods.price}" >
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>单位</th>
                    <td id="gclass">
                        <div>
                            <input type="text" name="gclass" value="${goods.gclass}">
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>参数/规格1*</th>
                    <td id="parameter1">
                        <div>
                            <input type="text" name="parameter1" value="${goods.parameter1}">
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>参数/规格2</th>
                    <td id="parameter2">
                        <div>
                            <input type="text" name="parameter2" value="${goods.parameter2}">
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>参数/规格3</th>
                    <td id="parameter3">
                        <div>
                            <input type="text" name="parameter3" value="${goods.parameter3}">
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>运费</th>
                    <td id="freight">
                        <div>
                            <input type="number" name="freight" value="${goods.freight}">
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>商品详情</th>
                    <td id="detail">
                        <div>
                            <textarea name="detail" rows="3" cols="20" >${goods.detail}</textarea>
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>库存</th>
                    <td id="stock">
                        <div>
                            <input type="number" name="stock" value="${goods.stock}">
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>板块</th>
                    <td id="partGoods">
                        <div>
                            <select name="partGoods">
                                    <option value="">无分类</option>
                                <c:forEach var="item" items="${parts}">
                                    <option value="${item.id}">${item.pname}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"> <input type="button" value="保存" id="submit" /></td>

                </tr>
            </table>
        </form>
    </div>
    <div>
        <input type="button" onclick="window.location.href='<%=basePath%>/admin/tohome'" value="返回">
    </div>

</body>
</html>
