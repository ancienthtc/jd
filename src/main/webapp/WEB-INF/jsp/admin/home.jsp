<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台模板管理系统</title>
<link type="text/css" rel="stylesheet" href="<%=basePath%>css/style.css" />
<script type="text/javascript" src="<%=basePath%>js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/menu.js"></script>



</head>

<body>
<div class="top"></div>
<div id="header">
	<div class="logo">商城后台管理系统</div>
	<div class="navigation">
		<ul>
		 	<li>欢迎您！</li>
			<li><a href="">${sessionScope.get("admin").admin}</a></li>
			<li><a href="">修改密码</a></li>
			<li><a href="">设置</a></li>
			<li><a href="">退出</a></li>
		</ul>
	</div>
</div>
<div id="content">
	<div class="left_menu">
				<ul id="nav_dot">
      <li>
          <h4 class="M1"><span></span>板块管理</h4>
          <div class="list-item none">
            <a href='<%=basePath%>part/list'>板块列表</a>
            <a href='<%=basePath%>admin/partadd'>板块添加</a>
          </div>
        </li>
        <li>
          <h4 class="M2"><span></span>商品管理</h4>
          <div class="list-item none">
            <a href='<%=basePath%>goods/listpage'>商品列表</a>
            <a href=''>商品添加</a>         
           </div>
        </li>
        <li>
          <h4 class="M3"><span></span>用户管理</h4>
          <div class="list-item none">
            <a href=''>用户列表</a>
            <a href=''>购买记录</a>
          </div>
        </li>
	 </ul>
		</div>
		<div class="m-right">
			<div class="right-nav">
					<ul>
							<li><img src="<%=basePath%>image/home.png"></li>
								<li style="margin-left:25px;">您当前的位置：</li>
								<li><a href="#">系统后台</a></li>
								
						</ul>
			</div>
			<div class="main">
				
			</div>
		</div>
</div>
<div class="bottom"></div>
<div id="footer"></div>
<script>navList(12);</script>
</body>
</html>
