<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>无标题文档</title>
	<!--轮播图开始-->
	<script type="text/javascript" src="<%=basePath%>js/jquery -1.7.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/superslide.2.1.js"></script>
	<link href="<%=basePath%>css/style.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		<!--导航开始-->
		.daohang ul{margin-left:10px;}
		.daohang ul li{
			float:left;
			margin-left:150px;
			list-style:none;
			margin-top:30px;
		}
		.daohang a{font-size:24px;
			color:#000;
			text-decoration:none
		}
		.daohang a:hover{color:#F00;}
		.daohang img{width:50px;
			height:50px;
			margin-left:20px;
		}
		<!--导航结束-->
		<!--分类开始-->
				/*.fenlei{
                    width:1300px;
                }
                .fenlei ul li{
                    float:left;
                    margin-left:100px;
                    width:180px;
                    height:100px;

                    }
                .fenlei ul li a{color:#333;}
                .fenlei a:hover{color:#F00; text-decoration:none;}
                .fenlei ul li img{
                    width:50px;
                    height:50px;

                    }*/
		<!--分类结束-->
			<script src="<%=basePath%>js/jquery1.42.min.js"></script>
															  .tuijian{ width:1300px;}
		.tuijian ul li{width:250px;margin-left:10px; float:left; border:1px solid #930;}
		.tuijian a{color:#333; font-size:18px; text-align:center;}
		.tuijian a:hover{color:#F00; text-decoration:none;}


		.rexiao{ width:1300px;}
		.rexiao ul li{width:250px;margin-left:10px; float:left;border:1px solid #930;}
		.rexiao a{color:#333; font-size:20px;}
		.rexiao a:hover{color:#F00; text-decoration:none;}
	</style>
</head>



<body>
	<c:if test="${not empty User.nickname}">
		<h3>欢迎登录 ${User.nickname}</h3>
	</c:if>
	<c:if test="${empty User.nickname}">
		<a href="<%=basePath%>login/login">您好！请登录</a><br>
	</c:if>

<div align="center">


<!--轮播图开始-->
<div class="fullSlide" >
	<div class="bd">
		<ul>
			<li _src="url(<%=basePath%>image/a.jpg)">
			 <a href="#"></a>
			</li>
			<li _src="url(<%=basePath%>image/b.jpg)"> <a href="#"></a></li>
			<li _src="url(<%=basePath%>image/c.jpg)"> <a href="#"></a></li>

		</ul>
	</div>
	<div class="hd"><ul></ul></div>
	<span class="prev"></span>
	<span class="next"></span>
</div><!--fullSlide end-->


<script type="text/javascript">
    $(".fullSlide").hover(function(){
            $(this).find(".prev,.next").stop(true, true).fadeTo("show", 0.5)
        },
        function(){
            $(this).find(".prev,.next").fadeOut()
        });
    $(".fullSlide").slide({
        titCell: ".hd ul",
        mainCell: ".bd ul",
        effect: "fold",
        autoPlay: true,
        autoPage: true,
        trigger: "click",
        startFun: function(i) {
            var curLi = jQuery(".fullSlide .bd li").eq(i);
            if ( !! curLi.attr("_src")) {
                curLi.css("background-image", curLi.attr("_src")).removeAttr("_src")
            }
        }
    });
</script>
<!-- 轮播 结束 -->
<!--导航开始-->
<div class="daohang">
	<ul>
		<li><a href="index.html"><img src="<%=basePath%>image/biao1.png"/><br />首&nbsp;&nbsp;&nbsp;页</a></li>
		<li><a herf="#"><img src="<%=basePath%>image/biao2.png" /><br />所有商品</a></li>
		<li><a herf="#"><img src="<%=basePath%>image/biao3.png" /><br />购&nbsp;物&nbsp;车</a></li>
		<li><a herf="#"><img src="<%=basePath%>image/biao4.png" /><br />个人中心</a></li>
	</ul>
</div>
<!--导航结束-->

<!--搜索框开始-->
<div class="container">
	<div class="search">

		<input type="text" name="q">
		<input class="button" type="submit" value="Search">
	</div>
</div>
<!--搜索框结束-->
<!--爆款推荐开始-->
<div>
	<div class="tuijian" style="background-color:#0CC; width:1300px; height:30px; margin-top:30px; margin-left:20px;">
		<p style="font:18px 微软雅黑; margin-left:30px; margin-top:20px;">爆款推荐</p>
		<ul>
			<c:forEach var="item" items="${parts}" varStatus="vs">
				<li>
					<a href="<%=basePath%>part/view/${item.get("pid")}">
						<img style="width: 160px;height:300px;" src="<%=basePath%>picture/show?pic=${item.get("title")}" /><br />
						<br />${item.get("pname")}<br /><br />${item.get("type")}
					</a>
				</li>
				<c:if test="${vs.index%3==0 }"><br/></c:if>
			</c:forEach>
		</ul>
		<div class="mask"></div>
	</div>

</div>
<!--爆款推荐结束-->

<!--本季热销开始-->
<%--<div class="rexiao" style="background-color:#0CC; width:1300px; height:30px; margin-top:500px; margin-left:20px;">--%>
<%--<p style="font:18px 微软雅黑; margin-left:30px; margin-top:20px;">本季热销</p>--%>
<%--<ul>--%>
<%--<li><a href="#"><img src="images/cloth2.jpg" /><br /><br />夏季女装连衣裙<br /><br />￥220</a></li>--%>
<%--<li><a href="#"><img src="images/cloth2.jpg" /><br /><br />夏季女装连衣裙<br /><br />￥220</a></li>--%>
<%--<li><a href="#"><img src="images/cloth2.jpg" /><br /><br />夏季女装连衣裙<br /><br />￥220</a></li>--%>
<%--<li><a href="#"><img src="images/cloth2.jpg" /><br /><br />夏季女装连衣裙<br /><br />￥220</a></li>--%>
<%--</ul>--%>
<%--</div>--%>
<!--本季热销结束-->
</div>
</body>
</html>
