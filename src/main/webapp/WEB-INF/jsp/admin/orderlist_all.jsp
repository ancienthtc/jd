<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/8/29
  Time: 17:26
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
    <title>订单统计</title>
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.js"></script>
    <script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>

    <script>
        $(function(){
            $("#sub").click(function () {
                var uuid=$("#uuid").val();
                var status=$("#status").val();
                var begin=$("#begin").val();
                var end=$("#end").val();
                var date='{"uuid":"'+uuid+'","strtus":"'+status+'","begin":"'+begin+'","end":"'+end+'"}';
                //console.log(uuid+"/"+status+"/"+begin+"/"+end);
                $.ajax({
                    url:"../order/getQuery",
                    contentType : 'application/json',
                    data:date,
                    type:"post",
                    dataType:"json",
                    success:function(data){
                        console.log(data);
                        var table=$("#tb1 tbody");
                        $(table).empty();
                        if(data != null){
                            $.each(data,function(i,row){
                                var show="";
                                //判断
                                if (row.ordertime != "" && row.ordertime != undefined) {
                                    /*将时间字符串转化为日期*/
                                    var time = new Date(row.time);
                                    row.ordertime = time.getFullYear() + "-" + (time.getMonth() + 1) + "-" + time.getDate();
                                } else {
                                    row.ordertime = "";
                                }
                                //判断
                                if(row.paystatus==0 && row.shopstatus==0)
                                {
                                    show="待付款";
                                }
                                else if(row.paystatus==1 && row.shopstatus==0)
                                {
                                    show="待发货";
                                }
                                else if(row.paystatus==1 && row.shopstatus==1)
                                {
                                    show="待收货";
                                }
                                else if(row.paystatus==1 && row.shopstatus==2)
                                {
                                    show="待评价";
                                }
                                else if(row.paystatus==1 && row.shopstatus==3)
                                {
                                    show="已完成";
                                }
                                else if(row.paystatus==2 && row.shopstatus==0)
                                {
                                    show="已取消";
                                }

                                var tr = $('<tr>');
                                tr.append("<td>"+row.uuid+"</td>");
                                tr.append("<td>"+row.ordertime2+"</td>");
                                tr.append("<td>"+show+"</td>");
                                tr.append("<td>"+row.allprice+"</td>");
                                $(tr).append('</tr>');
                                $(table).append(tr);
                            });
                        }
                    },
                    error:function(){
                        alert("fail");
                    }
                });

            })
        });
    </script>

    <style>
        .input {
            border:2px solid #390;
            width:200px;
            height:24px;
            font-size:16px;
            font-weight:bold;
            line-height:1.6;
            text-align: center;
        }
    </style>
</head>
<body>
<div style="border:1px;solid:#F00;font-size: medium">
    <h3>订单统计</h3>
    <%--<jsp:include page="orderlist_all_count.jsp"></jsp:include>--%>
    <div id="detail"><table width="450px" align="center">
        <tr>
            <td>
                <div>
                    <table width="600px">
                        <tr align="center">
                            <td colspan="2">上月订单</td>
                        </tr>
                        <tr>
                            <td>未付款订单:</td>
                            <td>${info.get(0).get("nopay")}</td>
                        </tr>
                        <tr>
                            <td>已付款订单:</td>
                            <td>${info.get(0).get("pay")}</td>
                        </tr>
                        <tr>
                            <td>完成订单:</td>
                            <td>${info.get(0).get("finish")}</td>
                        </tr>
                        <tr>
                            <td>成交价:</td>
                            <td>${info.get(0).get("all")}</td>
                        </tr>
                    </table>
                </div>
            </td>
            <td>
                <div style="border:1px;solid:#F00">
                    <table width="200px">
                        <tr align="center">
                            <td colspan="2">本月订单</td>
                        </tr>
                        <tr>
                            <td>未付款订单:</td>
                            <td>${info.get(1).get("nopay")}</td>
                        </tr>
                        <tr>
                            <td>已付款订单:</td>
                            <td>${info.get(1).get("pay")}</td>
                        </tr>
                        <tr>
                            <td>完成订单:</td>
                            <td>${info.get(1).get("finish")}</td>
                        </tr>
                        <tr>
                            <td>成交价:</td>
                            <td>${info.get(1).get("all")}</td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div style="border:1px;solid:#F00">
                    <table width="200px">
                        <tr align="center">
                            <td colspan="2">对比</td>
                        </tr>
                        <tr>
                            <td>未付款增长率:</td>
                            <td>
                                <c:if test="${empty info.get(2).get('nopay')}" >
                                    --
                                </c:if>
                                <c:if test="${not empty info.get(2).get('nopay')}" >
                                    ${info.get(2).get('nopay')}
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <td>已付款增长率:</td>
                            <td>
                                <c:if test="${empty info.get(2).get('pay')}" >
                                    --
                                </c:if>
                                <c:if test="${not empty info.get(2).get('pay')}" >
                                    ${info.get(2).get('pay')}
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <td>完成增长率:</td>
                            <td>
                                <c:if test="${empty info.get(2).get('finish')}" >
                                    --
                                </c:if>
                                <c:if test="${not empty info.get(2).get('finish')}" >
                                    ${info.get(2).get('finish')}
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <td>成交价增长率</td>
                            <td>
                                <c:if test="${empty info.get(2).get('all')}" >
                                    --
                                </c:if>
                                <c:if test="${not empty info.get(2).get('all')}" >
                                    ${info.get(2).get('all')}
                                </c:if>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td>
                <div style="border:1px;solid:#F00">
                    <table width="200px">
                        <tr align="center">
                            <td colspan="2">历史订单</td>
                        </tr>
                        <tr>
                            <td>未付款订单:</td>
                            <td>${info.get(3).get("nopay")}</td>
                        </tr>
                        <tr>
                            <td>已付款订单:</td>
                            <td>${info.get(3).get("pay")}</td>
                        </tr>
                        <tr>
                            <td>完成订单:</td>
                            <td>${info.get(3).get("finish")}</td>
                        </tr>
                        <tr>
                            <td>成交价:</td>
                            <td>${info.get(3).get("all")}</td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
</div>
</div>
<br><br>
<div style="border:1px;solid:#F00;font-size: medium">
    <h3>订单查询</h3>
    <div>
        <!-- select -->
        订单号:<input type="text" name="uuid" id="uuid" value="" class="input"> &nbsp;
        <select id="status" name="status">
            <option value="1">待付款</option>
            <option value="2">待发货</option>
            <option value="3">待收货</option>
            <option value="4">待评价</option>
            <option value="5">已评价</option>
            <option value="6">已取消</option>
        </select>
        <br>
        日期:<input type="text" name="begin" id="begin" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" class="input"/>
        到<input type="text" name="end" id="end" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" class="input"/>
        <input type="button" name="sub" id="sub" value="提交">
    </div>
    <div>
        <!-- table -->
        <table id="tb1" width="600px">
            <thead>
            <tr id="tr1">
                <td>订单号</td>
                <td>下单时间</td>
                <td>状态</td>
                <td>总价</td>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
        <!-- 分页 -->
    </div>
</div>

</body>
</html>
