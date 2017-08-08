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
  <%--日期选择插件样式--%>
  <link href="../css/date/date.css" type="text/css" rel="stylesheet" />
<style>
.head{width:100%; height:100px; background:#996;}
.h_left{ height:100px; margin-left:50px; float:left;}
.h_left a{color:#000; font-size:16px; text-decoration:none;}
.h_left a:hover{color:#999; font-size:18px;}
.h_right{margin-right:150px; margin-top:-5px;  height:100px;}
.h_right ul{ float:right;}
.h_right ul li{ float:left; list-style:none; font-size:16px; margin-left:35px;}
.h_right ul li a{font-size:16px; text-decoration:none; color:#000;}
.h_right ul li a:hover{font-size:18px; color:#999;}
<!--搜索框开始-->
form { 
margin-top:20px; 
} 
#search_box {
margin-top:-42px;
margin-left:950px; 
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

<!--左边菜单开始-->
.all{width:100%;}
.all_left .all_right{ float:left;}
.all_left{ width:200px; height:auto; background:#993; margin-top:-10px;}
.all_left ul li{ line-height:30px; list-style:none; padding-bottom:30px; padding-top:50px; }
.all_left ul li a{ text-decoration:none; font-size:18px; color:#000;}
.all_left ul li a:hover{ font-size:20px;}
.all_left ul li a:active{ font-size:20px;}
.all_right{ float:right;margin-top:-450px; margin-right:350px;}
.all_right table{ margin-top:30px; text-align:center;}
<!--底部版权开始-->
.bottom{width:100%;clear:both;text-align:center;padding:10px 0;line-height:25px;color:#666;border-top:#ddd 1px solid;}
.footer{ background-color:#999; height:50px; margin-top:50px;}
.bottom a{margin-top:50px;color:#666; padding-top:30px; margin-left:15px;}
.bottom a:hover{color:#000;text-decoration:underline;}
.bottom p{ text-align:center; line-height:25px;}
</style>




  <script src="../static/libs/jquery/jquery.min.js"></script>



  <script type="text/javascript">
      $(function (){
          initComplexArea('seachprov', 'seachcity', 'seachdistrict', area_array, sub_array, '44', '0', '0');
          $("#liveSpan").click(function(){
              if($("#liveDiv").css("display")=="none"){
                  $("#liveDiv").show();
                  $("#livaInput").hide();
                  $("#liveSpan").text("取消修改");
              }else{
                  $("#liveDiv").hide();
                  $("#livaInput").show();
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
  <link rel="stylesheet" href="../static/libs/messenger/css/messenger.css" />
  <link rel="stylesheet" href="../static/libs/messenger/css/messenger-theme-future.css" />
</head>

<body>
<!--头部开始-->
<div class="head">
<div class="h_left"><p>欢迎光临${requestScope.user.nickname}&nbsp;&nbsp; <a href="">退出</a></p></div>
<div class="h_right">
<ul>
<li><a href="">****</a></li>
<li><a href="" style="font-size:18px; color:#F00;">用户管理</a></li>
<li><a href="">购&nbsp;&nbsp;物&nbsp;&nbsp;车</a></li>
</ul>
</div>
</div>
<!--搜索框开始-->
<div id="search_box"> 
<form id="search_form" method="post" action="#"> 
<input type="text" id="s" value="Search" class="swap_value" /> 
<input type="image" src="http://files.jb51.net/demoimg/200912/btn_search_box.gif" width="27" height="24" id="go" alt="Search" title="Search" /> 
</form> 
</div> 
<!--头部结束-->
<div class="all">
<!--左边菜单开始-->
<div class="all_left">
<ul>
<li><a onclick="window.location.href='<%=basePath%>user/toShopCenter'">用户管理</a></li>
<li><a href="javascript:void(0)" id="recieverAddress">收货地址管理</a></li>
<li><a href="javascript:void(0)">评论管理</a></li>
<li><a href="javascript:void(0)">订单管理</a></li>
</ul>
</div>
<!--左边菜单结束-->
<!--右边信息开始-->
<div class="all_right">
<h2>用户信息</h2>
<table width="600px" height="300px">
  <tr>
    <td>用户名</td>
    <td><input type="text" value="${requestScope.user.nickname}" name="name"></td>
    <td>生&nbsp;日</td>
    <td>

        <input name="member.birth" type="text" value="${requestScope.birth}" size="14" readonly onClick="showcalendar(event,this);" onFocus="showcalendar(event, this);if(this.value=='0000-00-00')this.value=''">

    </td>
  </tr>
  <tr>
    <td>性&nbsp;别</td>
    <td>
      <input name="sex" type="radio" ${requestScope.user.sex=='男'?"checked":""} value="男">男 &nbsp;&nbsp;
      <input name="sex" type="radio" ${requestScope.user.sex=='女'?"checked":""} value="女">女
      <%--<input name="sex" type="radio" <c:if test="${requestScope.user.sex=='男'}">checked="checked"</c:if> value="男">男 &nbsp;&nbsp;
      <input name="sex" type="radio" <c:if test="${requestScope.user.sex=='女'}">checked="checked"</c:if> value="女">女--%>
    </td>
    <td>居住地</td>
    <td>
      <input id="liveInput" type="text" value="${requestScope.user.live}" disabled />
      <div id="liveDiv" style="display: none">
        <center>
          <select id="seachprov" name="seachprov" onChange="changeComplexProvince(this.value, sub_array, 'seachcity', 'seachdistrict');"></select>&nbsp;&nbsp;
          <select id="seachcity" name="homecity" onChange="changeCity(this.value,'seachdistrict','seachdistrict');"></select>&nbsp;&nbsp;
          <span id="seachdistrict_div"><select id="seachdistrict" name="seachdistrict"></select></span>
        </center>
      </div>
      <span id="liveSpan">修改地址</span>
    </td>
  </tr>
  <tr>
    <td>手机号码</td>
    <td><input type="text" value="${requestScope.user.tel}" ></td>
    <td colspan="2"><input  style=" text-align:left; margin-left:-200px;"  type="reset" value="修改"> &nbsp;&nbsp;
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

  </tr>
  <tr>
    <td>上次登录</td>
    <td colspan="3" >${requestScope.loginDate}</td>
    
  </tr>
  <tr>
    <td>积分</td>
    <td colspan="3">${requestScope.user.score}</td>
    
  </tr>
</table>
<input style="text-align:center; margin-left:300px; margin-top:20px; width:60px; height:25px;" data-btn="savePersonalInfo" type="button" value="保存">
</div>
<!--右边信息结束-->
<div class="bottom">
<div class="footer">
<P>
<a href="#" rel="nofollow">关于我们</a> &nbsp;|<a href="#" rel="nofollow">联系我们</a>&nbsp;|<a href="#" rel="nofollow"><a href='' target='_blank'>法律声明</a></a>&nbsp;|<a href="#" rel="nofollow">网站地图</a>&nbsp;|<a target="_blank" href="#">版权声明</a>&nbsp;|<a href="#" rel="nofollow">帮助中心</a><br />
***商城 版权所有　© 2005-2020　京ICP备********号</P>
</div>
</div>
</div>
</body>
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
</html>
