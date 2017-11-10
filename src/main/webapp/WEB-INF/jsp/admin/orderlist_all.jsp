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
    <meta charset="UTF-8">
    <%--<link rel="stylesheet" href="<%=basePath%>css/pagination.css">--%>
    <%--<script src="http://cdn.static.runoob.com/libs/jquery/1.10.2/jquery.min.js">--%>
    <!--<script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.js"></script>-->
    <script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>

    <script>
        $(function(){
            $("#sub").click(function () {
                var uuid=$("#uuid").val();
                var status=$("#status").val();
                var begin=$("#begin").val();
                var end=$("#end").val();

                var pageNo=null;
                var pageSize=null;

                var date='{"uuid":"'+uuid+'","strtus":"'+status+'","begin":"'+begin+'","end":"'+end+
                    '","pageNo":"'+pageNo+'","pageSize":"'+pageSize+'"}';
                //console.log(uuid+"/"+status+"/"+begin+"/"+end);
                $.ajax({
                    url:"../order/getQuery",
                    contentType : 'application/json',
                    data:date,
                    type:"post",
                    dataType:"json",
                    success:function(data){
                        //console.log(data);
                        dealJson(data);
                        afterLoad();
                    },
                    error:function(){
                        alert("fail");
                    }
                });

            })


        });

        //绑定事件
        function afterLoad()
        {
            $(function() {
                var uuid=$("#uuid").val();
                var status=$("#status").val();
                var begin=$("#begin").val();
                var end=$("#end").val();

                var pageNo=$("#pageNo").val();
                var pageSize=$("#pageSize").val();
                var pages=$("#pages").val();
                var total=$("#total").val();
                $(".select-page").click(function () {
                    //name
                    pageNo=$(this).attr("name");
                    //alert(pageNo);

                    var date='{"uuid":"'+uuid+'","strtus":"'+status+'","begin":"'+begin+'","end":"'+end+
                        '","pageNo":"'+pageNo+'","pageSize":"'+pageSize+'"}';
                    //alert(date);

                    $.ajax({
                        url:"../order/getQuery",
                        contentType : 'application/json',
                        data:date,
                        type:"post",
                        dataType:"json",
                        success:function(data){
                            //console.log(data);
                            dealJson(data);
                            afterLoad();
                        },
                        error:function(){
                            alert("fail");
                        }
                    });
                });

                $(".previous").click(function () {
                    if(pageNo>=2)
                    {
                        pageNo=parseInt(pageNo)-1;
                    }
                    else
                    {
                        return false;
                    }
                    //alert(pageNo);

                    var date='{"uuid":"'+uuid+'","strtus":"'+status+'","begin":"'+begin+'","end":"'+end+
                        '","pageNo":"'+pageNo+'","pageSize":"'+pageSize+'"}';
                    //alert(date);

                    $.ajax({
                        url:"../order/getQuery",
                        contentType : 'application/json',
                        data:date,
                        type:"post",
                        dataType:"json",
                        success:function(data){
                            //console.log(data);
                            dealJson(data);
                            afterLoad();
                        },
                        error:function(){
                            alert("fail");
                        }
                    });

                });

                $(".next").click(function () {
                    if(pages>pageNo)
                    {
                        pageNo=parseInt(pageNo)+1;
                    }
                    else
                    {
                        return false;
                    }
                    //alert(pageNo);

                    var date='{"uuid":"'+uuid+'","strtus":"'+status+'","begin":"'+begin+'","end":"'+end+
                        '","pageNo":"'+pageNo+'","pageSize":"'+pageSize+'"}';
                    //alert(date);

                    $.ajax({
                        url:"../order/getQuery",
                        contentType : 'application/json',
                        data:date,
                        type:"post",
                        dataType:"json",
                        success:function(data){
                            //console.log(data);
                            dealJson(data);
                            afterLoad();
                        },
                        error:function(){
                            alert("fail");
                        }
                    });
                });

            });
        }

        function dealJson(data) {
            var table=$("#tb1 tbody");
            $(table).empty();
            var MBox=$("#M-box");
            $(MBox).empty();
            if(data != null){
                $.each(data.dataList,function(i,row){
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
                $(MBox).append('<a class="previous" href="javascript:void(0);"><</a>');
                for(var i=1;eval(data).pages >= i ; i++ )
                {
                    if( i==eval(data).pageNo )
                    {
                        $(MBox).append('<a class="active select-page" name="'+i+'" cla href="javascript:void(0);">'+i+'</a>');
                    }
                    else
                    {
                        $(MBox).append('<a class="select-page" name="'+i+'" href="javascript:void(0);">'+i+'</a>');
                    }
                }
                $(MBox).append('<a class="next" href="javascript:void(0);">></a>');
                $(MBox).append('<input type="hidden" id="pageNo" name="pageNo" value="'+eval(data).pageNo+'">');
                $(MBox).append('<input type="hidden" id="pageSize" name="pageSize" value="'+eval(data).pageSize+'">');
                $(MBox).append('<input type="hidden" id="pages" name="pages" value="'+eval(data).pages+'">');
                $(MBox).append('<input type="hidden" id="total" name="total" value="'+eval(data).total+'">');
            }
        }

    </script>

    <style>
        .input {
            border:1px solid #390;
            width:200px;
            height:24px;
            font-size:16px;
            font-weight:bold;
            line-height:1.6;
            text-align: center;
        }
        /*#div1 a{*/
            /*margin: 5px;*/
            /*border: 1px solid #999;*/
            /*text-decoration: none;*/
        /*}*/
        .M-box{
            position: relative;
            text-align: center;
            zoom: 1;
        }

        .M-box .active{
            float: left;
            margin:0 5px;
            width: 38px;
            height: 38px;
            line-height: 38px;
            background: #390;
            color: #fff;
            font-size: 14px;
            border: 1px solid #390;
        }
        .M-box a{
            float: left;
            margin:0 5px;
            width: 38px;
            height: 38px;
            line-height: 38px;
            background: #fff;
            border: 1px solid #390;
            color: #bdbdbd;
            font-size: 14px;
            text-decoration: none;
        }
        .M-box a:hover{
            color:#fff;
            background: #390;

            text-decoration: none;
        }
        .M-box .next,.M-box .prev{
            font-family: "Simsun";
            font-size: 16px;
            font-weight: bold;
        }

        .M-box input{
            float: left;
            margin:0 5px;
            width: 38px;
            height: 38px;
            line-height: 38px;
            text-align: center;
            background: #fff;
            border: 1px solid #390;
            outline: none;
            color: #390;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div style="border:1px;solid:#F00;font-size: medium">
    <h2 style="font-weight: bold;color: #00C17E;font-size: 23px;">订单统计</h2>
    <%--<jsp:include page="orderlist_all_count.jsp"></jsp:include>--%>
    <div id="detail"><table width="450px" align="center" border="1">
        <tr>
            <td>
                <div>
                    <table width="400px">
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

                    <table width="400px">
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

            </td>
        </tr>
        <tr>
            <td>

                    <table width="400px" style="border:1px solid red">
                        <tr align="center">
                            <td colspan="2">对比</td>
                        </tr>
                        <tr>
                            <td>未付款增长率:</td>
                            <td>
                                <c:if test="${empty info.get(2).get('nopay')}" >
                                    ------
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
                                    ------
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
                                    ------
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

            </td>
            <td>

                    <table width="400px" style="border:1px solid blue">
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

            </td>
        </tr>
    </table>
</div>
</div>
<br><br>
<div style="border:1px;font-size: medium">
    <h2 style="font-weight: bold;color: #00C17E;font-size: 23px;">订单查询</h2>
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

        日期:<input type="text" name="begin" id="begin" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" class="input"/>
        到<input type="text" name="end" id="end" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" class="input"/>
        <input type="button" name="sub" id="sub" value="提交">
    </div>
    <div>
        <!-- table -->
        <table id="tb1" width="1000px">
            <thead>
            <tr id="tr1">
                <td width="350px">订单号</td>
                <td width="230px">下单时间</td>
                <td width="210px">状态</td>
                <td width="210px">总价</td>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
        <!-- 分页 -->
        <div class="M-box" id="M-box">
            <a class="active"  href=""><</a>
            <a  href="">1</a>
            <a  href="">2</a>
            <a  href="">3</a>
            <a  href="">></a>

            <input type="text" value="">
            <a href="">确定</a>
        </div>
    </div>
</div>

<%--<script src="<%=basePath%>js/jquery.pagination.js"></script>--%>
<%--<script>--%>
    <%--$(function(){--%>

        <%--$('.M-box').pagination({--%>
            <%--pageCount:50,--%>
            <%--jump:true,--%>
            <%--coping:true,--%>
            <%--homePage:'首页',--%>
            <%--endPage:'末页',--%>
            <%--prevContent:'上页',--%>
            <%--nextContent:'下页'--%>
        <%--});--%>


        <%--$('.M-box').pagination({--%>
            <%--pageCount: 50,--%>
            <%--jump: true,--%>
            <%--callback:function(api){--%>
                <%--var data = {--%>
                    <%--page: api.getCurrent(),--%>
                    <%--name: 'mss',--%>
                    <%--say: 'oh'--%>
                <%--};--%>
                <%--$.getJSON('../order/getQuery',data,function(json){--%>
                    <%--console.log(json);--%>
                <%--});--%>
            <%--}--%>
        <%--});--%>

    <%--});--%>
<%--</script>--%>
</body>
</html>
