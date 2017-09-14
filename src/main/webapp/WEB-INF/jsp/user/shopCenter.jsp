<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<html>
<head>
  <meta charset="utf-8">
  <title>用户管理</title>
  <%--按钮样式--%>
  <link href="../css/button.css" rel="stylesheet" type="text/css"/>
  <%--日期选择插件样式--%>
  <link href="../css/date/date.css" type="text/css" rel="stylesheet" />
  <link rel="stylesheet" type="text/css" href="../css/modal/modal_test.css" />
  <style>
    .head{width:100%; height:80px; background:#3399ff; overflow:hidden;}
    .h_left{ height:80px; margin-left:50px; float:left; width:150px;}
    .h_left a{color:#FFF; font-size:16px; text-decoration:none;}
    .h_left p{color:#FFF; font-size:16px;}
    .h_left a:hover{color:#999; font-size:18px;}
    .h_right{margin-right:150px; margin-top:0px;  height:80px; width:1000; float:right;}
    form {
      margin-top:20px; width:180px; float:left; height:15px; margin-right:20px;
    }
    .search_text{width:120px; height:15px; border:2px solid #CCC; background:#3399ff; border-radius:5px;}
    .search_btn{ background:#CCC; width:50px; height:20px; border-radius:5px; font-size:10px; color:#FFF;}
    .h_right ul{ float:right;}
    .h_right ul li{ float:left; list-style:none; font-size:16px; margin-left:35px;}
    .h_right ul li a{font-size:16px; text-decoration:none; color:#fff;}
    .h_right ul li a:hover{font-size:18px; color:#999;}

    <!--左边菜单开始-->
        .all{width:100%; overflow:hidden;}
    .all_left .all_right{ float:left;}
    .all_left{ width:150px; height:800px; background:#fff; margin-top:-16px;}
    .all_left hr{ width:150px; margin-left:-40px;color:#999;}
    .all_left ul li{ line-height:10px; list-style:none; padding-top:5px; }
    .all_left .jt{width:7px; height:10px; margin-left:15px;}
    .all_left ul li a{ text-decoration:none; font-size:14px; color:#666;}
    .all_left ul li a:hover{ font-size:16px;}
    .all_left ul li a:active{ font-size:16px;}
    .all_left>ul>li>ul>li{ line-height:25px; font-size:14px; color:#666;}
    .all_right{ float:right;margin-top:-750px; width: 1250px;}
    /*.all_right table{ margin-top:30px; text-align:center;}*/
    <!--底部版权开始-->
        .footer{width:100%;clear:both;text-align:center;padding:10px 0;line-height:25px;color:#666;border-top:#ddd 1px solid;}
    .footer{ background-color:#999; height:100px; position: fixed;}
    .footer a{margin-top:50px;color:#666; padding-top:30px; margin-left:15px;}
    .footer a:hover{color:#000;text-decoration:underline;}
    .footer p{ text-align:center; line-height:25px;}
    /*.bottom{width:100%;clear:both;text-align:center;padding:10px 0;line-height:25px;color:#666;border-top:#ddd 1px solid;}
    .footer{ background-color:#999; height:50px; margin-top:50px;}
    .bottom a{margin-top:50px;color:#666; padding-top:30px; margin-left:15px;}
    .bottom a:hover{color:#000;text-decoration:underline;}
    .bottom p{ text-align:center; line-height:25px;}*/

    .userInfoTable input[type="text"] {
      border:1px solid #669b1f;
      border-radius: 3px;
      background-color: #fcfdfd;
      height: 24px;
    }

    .active{
      margin-bottom: 10px;
      padding-bottom: 0px;
      padding-top: 0px;
    }
  </style>


  <script src="../static/libs/jquery/jquery.min.js"></script>



  <script type="text/javascript">
      $(function (){
          initComplexArea('seachprov', 'seachcity', 'seachdistrict', area_array, sub_array, '44', '0', '0');
          $("#liveSpan").click(function(){
              if($("#liveDiv").css("display")=="none"){
                  $("#liveDiv").show();
                  $("#liveInput").hide();
                  $("#liveSpan").text("取消修改");
              }else{
                  $("#liveDiv").hide();
                  $("#liveInput").show();
                  $("#liveSpan").text("修改地址");
              }
          });
      });



      //得到地区码
      function getAreaID(){
          var area = 0;
          if($("#seachdistrict").val() != "0"){
              area = $("#seachdistrict").val();
          }else if ($("#seachcity").val() != "0"){
              area = $("#seachcity").val();
          }else{
              area = $("#seachprov").val();
          }
          return area;
      }

      function showAreaID() {
          //地区码
          var areaID = getAreaID();
          //地区名
          var areaName = getAreaNamebyID(areaID) ;
          alert("您选择的地区码：" + areaID + "      地区名：" + areaName);
      }

      //根据地区码查询地区名
      function getAreaNamebyID(areaID){
          var areaName = "";
          if(areaID.length == 2){
              areaName = area_array[areaID];
          }else if(areaID.length == 4){
              var index1 = areaID.substring(0, 2);
              areaName = area_array[index1] + " " + sub_array[index1][areaID];
          }else if(areaID.length == 6){
              var index1 = areaID.substring(0, 2);
              var index2 = areaID.substring(0, 4);
              areaName = area_array[index1] + " " + sub_array[index1][index2] + " " + sub_arr[index2][areaID];
          }
          return areaName;
      }
  </script>
  <!-- 提示框的样式引入 -->
  <!--<link rel="stylesheet" href="../static/libs/messenger/css/messenger.css" />
  <link rel="stylesheet" href="../static/libs/messenger/css/messenger-theme-future.css" />-->
</head>

<body>
<!--头部开始-->
<div class="head">
  <div class="h_left"><p>欢迎光临${requestScope.user.nickname}&nbsp;&nbsp; <a href="">退出</a></p></div>

  <div class="h_right">
    <form id="search_form" method="post" action="<%=basePath%>goods/search">
      <input type="text" id="key" name="key" value="Search" class="swap_value" />
      <input type="image" src="http://files.jb51.net/demoimg/200912/btn_search_box.gif" width="27" height="24" id="go" alt="Search" title="Search" />
    </form>
    <ul>
      <li><a herf="javascript:void(0)"  onclick="window.location.href='<%=basePath%>user/toShopHome'">首页</a></li>
      <li><a href="" style="font-size:18px; color:#F00;">用户管理</a></li>
      <li><a herf="javascript:void(0)"  onclick="window.location.href='<%=basePath%>cart/toCart/${sessionScope.user.id}'">购&nbsp;&nbsp;物&nbsp;&nbsp;车</a></li>
    </ul>
  </div>
</div>
<!--头部结束-->
<div class="all">
  <!--左边菜单开始-->
  <script type="text/javascript">
      function showsubmenu(sid){
          var whichEl = document.getElementById("submenu" + sid);
          whichEl.style.display = whichEl.style.display =='none'?'':'none';
      }
  </script>
  <div class="all_left">
    <ul>
      <li><h4><span></span><a onClick="window.location.href='<%=basePath%>user/toShopCenter'">用户管理<img class="jt" src="手机/img/jian.png"></a></h4></li><hr>
      <li><h4><span></span><a href="javascript:void(0)" id="recieverAddress">地址管理<img class="jt" src="手机/img/jian.png"></a></h4></li><hr>
      <li><h4><span></span><a href="javascript:void(0)" id="commentManager">评论管理<img class="jt" src="手机/img/jian.png"></a></h4></li><hr>
      <li><h4><span></span><a href="javascript:void(0)" id="history">历史纪录管理<img class="jt" src="手机/img/jian.png"></a></h4></li><hr>
      <li><h4><span></span><a href="javascript:void(0)" onClick="showsubmenu(1)">订单管理<img class="jt" src="手机/img/jian.png"></a></h4><hr>
        <ul id="submenu1" style="list-style: none; display:none; margin-left:-20px;">
          <li class="active"><a href="javascript:void(0)" id="nopay">待付款</a></li>
          <li class="active"><a href="javascript:void(0)" id="nosend">待发货</a></li>
          <li class="active"><a href="javascript:void(0)" id="noaccept">待收货</a></li>
          <li class="active"><a href="javascript:void(0)" id="nocomment">待评价</a></li>
          <li class="active"><a href="">已评价</a></li>
          <li class="active"><a href="javascript:void(0)" id="outtime">已取消</a></li>
        </ul>
      </li>
    </ul>
  </div>
  <!--左边菜单结束-->
  <!--右边信息开始-->
  <div class="all_right">
    <h2>用户信息</h2>
    <table width="900px" height="300px" class="userInfoTable">
      <tr>
        <td style="font-size: 17px">用户名:</td>
        <td><input type="text" value="${requestScope.user.nickname}" name="name"></td>
        <td style="font-size: 17px">生&nbsp;日:</td>
        <td>

          <input name="member.birth" type="text" value="${requestScope.birth}" size="14" readonly onClick="showcalendar(event,this);" onFocus="showcalendar(event, this);if(this.value=='0000-00-00')this.value=''">

        </td>
      </tr>
      <tr>
        <td style="font-size: 17px">性&nbsp;别:</td>
        <td>
          <input name="sex" type="radio" ${requestScope.user.sex=='男'?"checked":""} value="男">男 &nbsp;&nbsp;
          <input name="sex" type="radio" ${requestScope.user.sex=='女'?"checked":""} value="女">女
          <%--<input name="sex" type="radio" <c:if test="${requestScope.user.sex=='男'}">checked="checked"</c:if> value="男">男 &nbsp;&nbsp;
          <input name="sex" type="radio" <c:if test="${requestScope.user.sex=='女'}">checked="checked"</c:if> value="女">女--%>
        </td>
        <td style="font-size: 17px">居住地:</td>
        <td>
          <input id="liveInput" type="text" value="${requestScope.user.live}" disabled />
          <span id="liveDiv" style="display: none;float: left;margin-right: 5px">
        <center>
          <select id="seachprov" name="seachprov" onChange="changeComplexProvince(this.value, sub_array, 'seachcity', 'seachdistrict');"></select>&nbsp;&nbsp;
          <select id="seachcity" name="homecity" onChange="changeCity(this.value,'seachdistrict','seachdistrict');"></select>&nbsp;&nbsp;
          <span id="seachdistrict_div"><select id="seachdistrict" name="seachdistrict"></select></span>
        </center>
      </span>
          <span class="button small gray" type="button" id="liveSpan">修改地址</span>
        </td>
      </tr>
      <tr>
        <td style="font-size: 17px">手机号码:</td>
        <td>
          <input type="text" value="${requestScope.user.tel}" >
          <input class="button medium gray"  style=" text-align:left;"  type="reset" value="修改"> &nbsp;&nbsp;
          <span>是否允许手机登录
        <c:choose>

          <c:when test="${requestScope.user.tellogin==1}">
            <input type="checkbox" value="1" name="istel" checked>
          </c:when>

          <c:otherwise>
            <input type="checkbox"  name="istel">
          </c:otherwise>
        </c:choose>

      </span>
        </td>
        <%--<td colspan="2">
        </td>
    --%>
      </tr>
      <tr>
        <td style="font-size: 17px">上次登录:</td>
        <td colspan="3" >${requestScope.loginDate}</td>

      </tr>
      <tr>
        <td style="font-size: 17px">积分:</td>
        <td colspan="3" style="font-weight: bold;color: #2d6987">${requestScope.user.score}</td>

      </tr>
    </table>
    <input class="button bigrounded green" style="text-align: center;margin-left: 250px" data-btn="savePersonalInfo" type="button" value="保存">
  </div>
  <!--右边信息结束-->

  <%--<div class="footer" style=" width:100%;">
  <P>
  <a href="#" rel="nofollow">关于我们</a> &nbsp;|<a href="#" rel="nofollow">联系我们</a>&nbsp;|<a href="#" rel="nofollow"><a href='' target='_blank'>法律声明</a></a>&nbsp;|<a href="#" rel="nofollow">网站地图</a>&nbsp;|<a target="_blank" href="#">版权声明</a>&nbsp;|<a href="#" rel="nofollow">帮助中心</a><br />
  ***商城 版权所有　© 2005-2020　京ICP备********号</P>
  </div>--%>

</div>

<div id="modal-overlay" class="modal-overlay">
  <div class="modalTitleDiv"><span class="modalTitle">收货地址地址编辑</span></div>
  <div class="modal-data">
    <div class="modalContent">
      <input name="id" type="hidden" class="clearContent"/>
      <div class="modalDetail">
        <div class="contentNameDiv"><span class="contentName">收货人姓名:</span></div><div class="clearContentDiv"><input name="recipient" type="text" class="clearContent"/></div>
      </div>
      <div class="modalDetail">
        <div class="contentNameDiv"><span  class="contentName">手机号码:</span></div><div class="clearContentDiv"><input name="tel" type="text" class="clearContent"/></div>
      </div>
      <div class="modalDetail">
        <div class="contentNameDiv"><span  class="contentName">电话号码:</span></div><div class="clearContentDiv"><input name="phone" type="text" class="clearContent"/></div>
      </div>
      <div class="modalDetail">
        <div class="contentNameDiv"><span  class="contentName">地&nbsp;&nbsp;&nbsp;&nbsp;址:</span></div><div class="clearContentDiv"><input name="area" type="text" class="clearContent"/></div>
      </div>
      <div class="modalDetail">
        <div class="contentNameDiv"><span  class="contentName">邮政编码:</span></div><div class="clearContentDiv"><input name="zip" type="text" class="clearContent"/></div>
      </div>
    </div>
    <div class="sureOrCancle">
      <div class="modalSure button medium blue" id="modalSure">确定</div>
      <div class="modalCancle button medium gray" id="modalCancle">取消</div>
    </div>
  </div>
</div>
<div id="modalDialog" class="modalDialog">

</div>

</body>
<%--模态框--%>
<script src="../js/modal/modal_test.js"></script>
<script src="../js/jquery-3.1.1.js"></script>
<%--省市县三级联动插件--%>
<script src="../js/area/Area.js" type="text/javascript"></script>
<script src="../js/area/AreaData_min.js" type="text/javascript"></script>
<%--日期插件--%>
<script type="text/javascript" src="../js/date/date.js"></script>
<!-- 提示框的js -->
<script src="../static/libs/messenger/js/messenger.min.js"></script>
<script src="../static/util/imessenger.js"></script>
<%--页面单独js--%>
<script src="<%=basePath%>js/user/shopCenter.js"  type="text/javascript"></script>

<!-- layer -->
<script type="text/javascript" src="<%=basePath%>js/layer.js" ></script>
</html>


