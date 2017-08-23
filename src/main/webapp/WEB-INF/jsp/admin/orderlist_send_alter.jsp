<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/8/22
  Time: 10:30
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
    <title>物流详情</title>
    <!-- 时间选择器 -->
    <script src="../static/libs/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script src="../static/libs/bootstrap-datetimepicker-master/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="../static/libs/file/ajaxfileupload.js"></script>
    <!-- 提示框的js -->
    <script src="../static/libs/messenger/js/messenger.min.js"></script>
    <script src="../static/util/imessenger.js"></script>
    <!-- 确认框的js -->
    <script src="../static/libs/jquery-confirm/jquery-confirm.js"></script>
    <!-- 封装的iForm -->
    <script src="../static/util/iform.js"></script>

    <link rel="stylesheet" type="text/css" href="../css/button.css" />

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

    <script type="application/javascript">
        $('[data-btn="backProduct"]').on('click', function(){
            $.ajax({
                url:"../order/toListSend",
                type:"get",
                dataType:"html",
                success:function(data){
                    $("#contentBoxId").html(data);
                },
                error:function(){
                    alert("页面出错");
                }
            });
        });

        $(document).ready(function() {

            $("#sub").click(function () {
                var uuid = $("#uuid").text();
                var log = $("#log").val();
                if(log.length<=1)
                {
                    alert("请填写运单信息!");
                    return;
                }
                //console.log(uuid+"//"+log);
                //alert(id);
                $.confirm({
                    title: '确认修改?',
                    content: '确认修改?',
                    confirm: function(){
                        //$.alert('Confirmed!');
                        $.ajax({
                            url: "../order/AlterLog",
                            contentType : 'application/json',
                            data: '{"id":"'+ uuid+'","log":"'+log+'"}',
                            type: "post",
                            dataType: "html",
                            success: function (data) {
                                $("#contentBoxId").html(data);
                            },
                            error: function () {
                                alert("请求失败");
                            }
                        });
                    },
                    cancel: function(){
                        //$.alert('Canceled!')
                    }
                });

            })
        })
    </script>

</head>
<body>

    <div>
        <h2>填写运单号</h2>
    </div>

    <div>
        <table style="font-size: 22px">
            <tr>
                <th>订单</th>
                <td id="uuid">${order.uuid}</td>
            </tr>

            <tr>
                <th>总价</th>
                <td>${order.allprice}</td>
            </tr>

            <tr>
                <th>运单信息</th>
                <td><input type="text" id="log" value="${log}" class="input"></td>
            </tr>
        </table>
        <input type="button" id="sub" value="发货" class="button black">
    </div>

    <div>
        <a href="javascript:void(0);" class="btnGreen addBtn" data-btn="backProduct">返回</a>
    </div>
</body>
</html>
