<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <meta charset="utf-8">
    <title>收货地址管理</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <title>sc.chinaz.com</title>
    <!-- Mobile viewport optimized: h5bp.com/viewport -->
    <meta name="viewport" content="width=device-width"/>
    <!-- Style Sheet-->
    <link href='http://fonts.googleapis.com/css?family=Dosis:200,300,400,500,600,700,800' rel='stylesheet'
          type='text/css'/>
    <link rel="stylesheet" href="css/style.css"/>
    <!-- favicon -->
    <link rel="shortcut icon" href="/favicon.ico"/>
    <!--[if lt IE 9]>
    <script src="js/html5.js"></script>
    <![endif]-->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <style>
        .head {
            width: 100%;
            height: 100px;
            background: #996;
        }

        .h_left {
            height: 100px;
            margin-left: 50px;
            float: left;
        }

        .h_left a {
            color: #000;
            font-size: 16px;
            text-decoration: none;
        }

        .h_left a:hover {
            color: #999;
            font-size: 18px;
        }

        .h_right {
            margin-right: 150px;
            margin-top: -5px;
            height: 100px;
        }

        .h_right ul {
            float: right;
        }

        .h_right ul li {
            float: left;
            list-style: none;
            font-size: 16px;
            margin-left: 35px;
        }

        .h_right ul li a {
            font-size: 16px;
            text-decoration: none;
            color: #000;
        }

        .h_right ul li a:hover {
            font-size: 18px;
            color: #999;
        }

        <!--
        搜索框开始-- >
        form {
            margin-top: 20px;
        }

        #search_box {
            margin-top: -42px;
            margin-left: 950px;
            width: 201px;
            height: 31px;
            background: url(http://files.jb51.net/demoimg/200912/bg_search_box.gif);
        }

        #search_box #s {
            float: left;
            padding: 0;
            margin: 6px 0 0 6px;
            border: 0;
            width: 159px;
            background: none;
            font-size: .8em;
        }

        #search_box #go {
            float: right;
            margin: 3px 4px 0 0;
        }

        <!--
        main开始-- >
        .main {
            margin-top: 35px;
            width: 150px;
            height: 850px;
            background-color: #993;
        }

        .main_l ul li {
            list-style: none;
            margin-top: 36px;
        }

        .main_l ul li a {
            text-decoration: none;
            margin-bottom: 30px;
            color: #000;
            font-family: "微软雅黑";
            font-size: 16px;
        }

        .main_l ul li a:hover {
            color: #000;
            font-size: 18px;
        }

        .main_r {
            width: 900px;
            height: 300px;
            float: right;
            margin-right: 180px;
            margin-top: -220px;
        }

        .main_r ul {
            overflow: hidden;
            height: 300px;
        }

        .main_r ul li {
            list-style: none;
            float: left;
            margin-left: 30px;
            margin-top: 20px;
        }

        .main_r img {
            width: 180px;
            height: auto;
        }

        <!--
        底部版权开始-- >
        .bottom {
            width: 100%;
            clear: both;
            text-align: center;
            padding: 10px 0;
            line-height: 25px;
            color: #666;
            border-top: #ddd 1px solid;
        }

       /* .footer {
            background-color: #999;
            height: 50px;
            margin-top: 260px;
        }*/

        .bottom a {
            margin-top: 50px;
            color: #666;
            padding-top: 30px;
            margin-left: 15px;
        }

        .bottom a:hover {
            color: #000;
            text-decoration: underline;
        }

        .bottom p {
            text-align: center;
            line-height: 25px;
        }

        .adress_left {
            width: 300px;
            float: left;
        }

        .adress_right {
            width: 660px;
            float: right;
            margin-left: 980px;
        }

        .adress_right ul li {
            list-style: none;
            line-height: 40px;
            margin-left: -35px;
        }

        .adress_right input[type=number] {
            width: 50px;
        }

        .table_list table td {
            border: 1px solid #999;
            margin-top: 20px;
        }

        <!--
        底部版权开始-- >
        .bottom {
            width: 100%;
            clear: both;
            text-align: center;
            padding: 10px 0;
            line-height: 25px;
            color: #666;
            border-top: #ddd 1px solid;
        }

       /* .footer {
            background-color: #999;
            height: 50px;
            margin-top: 10px;
        }*/

        .bottom a {
            margin-top: 50px;
            color: #666;
            padding-top: 30px;
            margin-left: 15px;
        }

        .bottom a:hover {
            color: #000;
            text-decoration: underline;
        }

        .bottom p {
            text-align: center;
            line-height: 25px;
        }
    </style>
    <!-- 提示框的样式引入 -->
    <link rel="stylesheet" href="../static/libs/messenger/css/messenger.css"/>
    <link rel="stylesheet" href="../static/libs/messenger/css/messenger-theme-future.css"/>
    <script type="text/javascript">
        $(function () {
            initComplexArea('seachprov', 'seachcity', 'seachdistrict', area_array, sub_array, '44', '0', '0');
            /*$("#liveSpan").click(function () {
             if ($("#liveDiv").css("display") == "none") {
             $("#liveDiv").show();
             $("#livaInput").hide();
             $("#liveSpan").text("取消修改");
             } else {
             $("#liveDiv").hide();
             $("#livaInput").show();
             $("#liveSpan").text("修改地址");
             }
             });*/
        });


        //得到地区码
        function getAreaID() {
            var area = 0;
            if ($("#seachdistrict").val() != "0") {
                area = $("#seachdistrict").val();
            } else if ($("#seachcity").val() != "0") {
                area = $("#seachcity").val();
            } else {
                area = $("#seachprov").val();
            }
            return area;
        }

        function showAreaID() {
            //地区码
            var areaID = getAreaID();
            //地区名
            var areaName = getAreaNamebyID(areaID);
            alert("您选择的地区码：" + areaID + "      地区名：" + areaName);
        }

        //根据地区码查询地区名
        function getAreaNamebyID(areaID) {
            var areaName = "";
            if (areaID.length == 2) {
                areaName = area_array[areaID];
            } else if (areaID.length == 4) {
                var index1 = areaID.substring(0, 2);
                areaName = area_array[index1] + " " + sub_array[index1][areaID];
            } else if (areaID.length == 6) {
                var index1 = areaID.substring(0, 2);
                var index2 = areaID.substring(0, 4);
                areaName = area_array[index1] + " " + sub_array[index1][index2] + " " + sub_arr[index2][areaID];
            }
            return areaName;
        }
    </script>
</head>

<body>


<!--左侧导航开始-->
<div class="container clearfix">


    <!--CONTENT-->
    <div id="content">

        <!--slider-->
        <div class="slider">
            <!--用户收货地址开始-->
            <div class="slides">
                <div class="adress_right">
                    <h2>收货地址</h2><br>
                    <p>新增收货地址 电话号码/手机号选填一项，其余均为必填项</p><br>
                    <ul>
                        <li>&nbsp;所在地区&nbsp;*&nbsp;&nbsp;
                            <center>
                                <select id="seachprov" name="seachprov"
                                        onChange="changeComplexProvince(this.value, sub_array, 'seachcity', 'seachdistrict');"></select>&nbsp;&nbsp;
                                <select id="seachcity" name="homecity"
                                        onChange="changeCity(this.value,'seachdistrict','seachdistrict');"></select>&nbsp;&nbsp;
                                <span id="seachdistrict_div"><select id="seachdistrict"
                                                                     name="seachdistrict"></select></span>
                            </center>
                        </li>
                        <%--<select name="66" style="width:85px;">
                        <option value="上海">上海</option>
                        <option value="苏州">苏州</option>
                        <option value="南京">南京</option>
                        <option value="兰州">兰州</option>
                        </select>&nbsp;&nbsp;<input type="">--%>


                        <li>&nbsp;详细地址&nbsp;*&nbsp;&nbsp;<input type="text" id="detail"></li>
                        <li>邮&nbsp;政&nbsp;编&nbsp;码&nbsp;&nbsp;<input type="text" id="zip"></li>
                        <li>收货人姓名*&nbsp;&nbsp;<input type="text" id="recipient"></li>
                        <li>手&nbsp;机&nbsp;号&nbsp;码&nbsp;&nbsp;<%--<select name="66" style="width:85px;">
                            <option value="中国">中国</option>
                            <option value="苏州">美国</option>
                        </select>&nbsp;&nbsp;--%><input type="text" id="tel"/></li>
                        <li>电&nbsp;话&nbsp;号&nbsp;码&nbsp;&nbsp;<%--<select name="66" style="width:85px;">
                            <option value="上海">上海</option>
                            <option value="苏州">苏州</option>
                        </select>&nbsp;&nbsp;--%><input type="text" id="phone"/><%---<input type="number">-<input type="number">--%>
                        </li>
                    </ul>
                    <input type="checkbox" style=" margin-left:100px;" id="ismain">设为默认收货地址<br><br>
                    <input type="button" value="保存" style=" margin-left:100px;" id="addAddress">
                    <div class="table_list">
                        <table width="600px" height="80px"
                               style=" float:right; margin-top:30px; margin-right:80px; text-align:center;">
                            <tr>
                                <td>收货人</td>
                                <td>所在地区</td>
                                <td>详细地址</td>
                                <td>邮编</td>
                                <td>手机</td>
                                <td>电话</td>
                                <td style="display: none"></td>
                                <td>操作</td>
                            </tr>
                            <c:if test="${requestScope.addr!=null && requestScope.addr!=''}">
                                <c:forEach items="${requestScope.addr}" var="item">
                                    <tr>
                                        <td>${item.recipient}</td>
                                        <td>${item.area}</td>
                                        <td>${item.detail}</td>
                                        <td>${item.zip}</td>
                                        <td>${item.tel}</td>
                                        <td>${item.phone}</td>
                                        <td style="display: none">${item.id}</td>
                                        <c:if test="${item.ismain==0}"><td><input type="button" data-btn="setDefault" value="设为默认"></td></c:if>
                                        <c:if test="${item.ismain==1}"><td><input type="button" value="默认地址"></td></c:if>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </table>
                    </div>
                </div>
            </div>

        </div>

    </div>

</div>


<!-- jQuery -->
<script src="../js/jquery-3.1.1.js"></script>
<script src="../js/jquery.cycle.all.js"></script>
<script src="../js/tabs-accordian.js"></script>

<!-- Custom JS -->
<script src="../js/custom.js"></script>

<!-- 提示框的js -->
<script src="../static/libs/messenger/js/messenger.min.js"></script>
<script src="../static/util/imessenger.js"></script>

<%--省市县三级联动插件--%>
<script src="../js/area/Area.js" type="text/javascript"></script>
<script src="../js/area/AreaData_min.js" type="text/javascript"></script>

<script src="<%=basePath%>js/user/addressManager.js" type="text/javascript"></script>

<%--<div style="display:none">
    <script src='http://v7.cnzz.com/stat.php?id=155540&web_id=155540' language='JavaScript' charset='gb2312'></script>
</div>--%>
</body>
</html>
