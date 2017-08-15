<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>购物车结算</title>
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
<!--选择收货地址开始-->
.choose{ width:100%;}
.choose .table1 { border:1px solid #999; text-align:center; line-height:25px;}
.choose .table1 td{border-top:1px solid #0CF;}
.plus{
 border: 1px solid; border-radius:10px; width:80px; height:35px;
 color:#FFF; font-weight: bold; background:#3CF;
 }

<!--底部版权开始-->
.footer{width:100%;clear:both;text-align:center;padding:10px 0;line-height:25px;color:#666;border-top:#ddd 1px solid;}
.footer{ background-color:#999; height:100px; position: fixed;}
.footer a{margin-top:50px;color:#666; padding-top:30px; margin-left:15px;}
.footer a:hover{color:#000;text-decoration:underline;}
.footer p{ text-align:center; line-height:25px;}
</style>

  <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.js"></script>
  <script type="text/javascript">
      $(document).ready(function() {
          <%--$(".query").change(function() {--%>
              <%--var aid = $("input[name='choice']:checked").attr("value");--%>
              <%--//alert(aid);--%>
              <%--$.ajax( {--%>
                  <%--type : 'POST',--%>
                  <%--contentType : 'application/json',--%>
                  <%--url : '<%=basePath%>cart/freight',--%>
                  <%--data : aid,--%>
                  <%--dataType : 'text',--%>
                  <%--success : function(data) {--%>
                      <%--$("#freight").html(data);--%>
                      <%--var t=parseFloat($("#total").attr("value")) ;--%>
                      <%--$("#all").html( parseFloat(data)+t );--%>
                  <%--},--%>
                  <%--error : function(data) {--%>
                      <%--alert("错误!")--%>
                  <%--}--%>
              <%--});--%>
          <%--});--%>

          //生成订单
          $("#add").click(function () {
              var json=$("#info").attr("value");//待提交  -->商品信息
              //console.log(json);//testOK
              json=json.toString();
              var list= $('input:radio[name="choice"]:checked').val();
              if(list==null){
                  alert("请选中一个!");
                  return false;
              }

              var tablerow = $('input:radio[name="choice"]:checked').parent().parent();
              var aid = tablerow.find("[name='aid']").attr("value");//待提交,收货地址
              //console.log(aid);

              //var all=$("#all").attr("value");
              //console.log(all);

              console.log(json);
              var date=json.substr(0,json.length-1);
              //json=json.substr(0,json.length-1);
              date=date+",'aid':'"+aid+"'}";
              //var dates='{json:'+json+',aid:'+aid+',all:'+all+'}';
              console.log(date);
              $.ajax( {
                  type : 'POST',
                  contentType : 'application/json',
                  url : '<%=basePath%>order/create',
                  data : date,
                  dataType : 'json',
                  success : function(data) {
                      console.log(data);
                      if(data==true)
                      {
                          alert("购买成功");
                          window.location.href="<%=basePath%>user/toShopCenter";
                      }
                  },
                  error : function(data) {
                      alert("错误");
                  }
              });
              //最终提交
              <%--var form = $("<form></form>");--%>
              <%--form.attr('action', "<%=basePath%>");--%>
              <%--form.attr('method', 'post');--%>
              <%--form.attr('target', '_self');--%>

              <%--var input1 = $("<input type='hidden' name='json' />");--%>
              <%--input1.attr('value', json);--%>
              <%--form.append(input1);--%>

              <%--form.appendTo("body");--%>
              <%--form.css('display', 'none');--%>
              <%--form.submit();--%>
          });

      })
  </script>

</head>

<body>
  <div class="head">
  <div class="h_left"><p>欢迎光临***&nbsp;&nbsp; <a href="">退出</a></p></div>
  <div class="h_right">
  <ul>
  <li><a href="">****</a></li>
  <li><a href="">用户管理</a></li>
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
  <!--选择收货地址开始-->
  <div class="choose">
  <h2>选择收货地址</h2>
  <table class="table1" width="92%" border="0" cellpadding="0" cellspacing="0">
    <tr style=" background-color:#CCC;">
      <th scope="col">收货人</th>
      <th scope="col">区域</th>
      <th scope="col">详细地址</th>
      <th scope="col">邮编</th>
      <th scope="col">手机</th>
      <th scope="col">选择</th>
    </tr>
    <c:forEach var="address" items="${addresses}">
      <tr>
        <%--<input type="hidden" name="aid" value="${address.id}">--%>
        <td name="aid" value="${address.id}">${address.recipient}</td>
        <td>${address.area}</td>
        <td>${address.detail}</td>
        <td>${address.zip}</td>
        <td>${address.tel}</td>
        <td><input type="radio" name="choice" class="query" value="${address.id}"></td>
      </tr>
    </c:forEach>
  </table><br>
  <input type="button" value="添加" id="add" name="add" class="plus">
  <br><br>
  <table class="table2" border="0">
    <input type="hidden" id="cart" value="${cart}">
  <tr>
    <td>运 &nbsp;费：</td><td id="freight">${freight}</td>
    <%--<input type="hidden" id="freight_" value="${freight}">--%>
  </tr>
  <tr>
    <td>商品总价：</td><td id="total" value="${total}">${total}</td>
    <%--<input type="hidden" id="total_" value="">--%>
  </tr>
  <tr>
    <td>总&nbsp;计：</td><td id="all" value="${total+freight}">${total+freight}</td>
    <%--<input type="hidden" id="all_" value="${total+freight}">--%>
  </tr>
  </table><br>
    <input type="hidden" id="info" value="${cart}">
  </div>

  <!--底部版权开始-->
  <div class="footer"  style=" width:100%;">
  <P>
  <a href="#" rel="nofollow">关于我们</a>
    &nbsp;|
    <a href="#" rel="nofollow">联系我们</a>
    &nbsp;|<a href="#" rel="nofollow"></a>
    <a href='http://www.veryhuo.com/z/falvapp/' target='_blank'><b>法律</b>声明</a>
    &nbsp;|
    <a href="#" rel="nofollow">网站地图</a>
    &nbsp;|
    <a target="_blank" href="#">版权声明</a>&nbsp;|
    <a href="#" rel="nofollow">帮助中心</a><br />
  ***商城 版权所有　© 2005-2020　京ICP备********号</P>
  </div>
</body>
</html>

