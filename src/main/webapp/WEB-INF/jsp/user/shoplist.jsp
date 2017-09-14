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
    <title>商品浏览</title>
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
        <!--main开始-->
            .main{margin-top:35px; width:950px; height:450px; background-color:#993;}
        .main_l{ height: 450px; width: 150px;}
        .main_l ul li{list-style:none; margin-top:36px; }
        .main_l ul li a{ text-decoration:none; margin-bottom:30px; color:#000; font-family:"微软雅黑";font-size:16px;}
        .main_l ul li a:hover{color:#000; font-size:18px;}

        .main_r{ margin-top:-460px; margin-left:100px; height:450px; width: 600px;}
        .main_r ul li{ list-style:none; float:left; margin-top:20px; margin-left: 30px;}
        .main_r img{width:150px; height:auto;}
        <!--底部版权开始-->
            .bottom{width:100%;clear:both;text-align:center;padding:10px 0;line-height:25px;color:#666;border-top:#ddd 1px solid;}
        .footer{ background-color:#999; height:50px; margin-top:260px;}
        .bottom a{margin-top:50px;color:#666; padding-top:30px; margin-left:15px;}
        .bottom a:hover{color:#000;text-decoration:underline;}
        .bottom p{ text-align:center; line-height:25px;}
    </style>
</head>

<body>
<div class="head">
    <div class="h_left"><p>欢迎光临***&nbsp;&nbsp; <a href="">退出</a></p></div>
    <div class="h_right">
        <ul>
            <li><a herf="javascript:void(0)"  onclick="window.location.href='<%=basePath%>user/toShopHome'">首页</a></li>
            <li><a href="<%=basePath%>user/toShopCenter">用户管理</a></li>
            <li><a href="<%=basePath%>cart/toCart/${sessionScope.user.id}">购&nbsp;&nbsp;物&nbsp;&nbsp;车</a></li>
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
<div class="main">

    <div class="main_l">
        <ul>
            <%--<li><a href="">板块一</a></li>--%>
            <%--<li><a href="">板块二</a></li>--%>
            <%--<li><a href="">板块三</a></li>--%>
            <%--<li><a href="">板块四</a></li>--%>
            <c:forEach var="parts" items="${allparts}">
                <li
                        <c:if test="${parts.id}==${pid}" >
                            style="font-weight: bold;"
                        </c:if>
                >
                    <a href="<%=basePath%>part/view/${parts.id}">${parts.pname}</a>
                </li>
            </c:forEach>
        </ul>
    </div>

    <div class="main_r">
        <ul>
            <%--<li><a href=""><img src="img/b1.png"></a></li>--%>
            <%--<li><a href=""><img src="img/b1.png"></a></li>--%>
            <%--<li><a href=""><img src="img/b1.png"></a></li>--%>
            <%--<li><a href=""><img src="img/b1.png"></a></li>--%>
            <%--<li><a href=""><img src="img/b1.png"></a></li>--%>
            <%--<li><a href=""><img src="img/b1.png"></a></li>--%>
            <%--<li><a href=""><img src="img/b1.png"></a></li>--%>
            <%--<li><a href=""><img src="img/b1.png"></a></li>--%>
            <c:forEach var="goods" items="${allgoods}">
                <li>
                    <a href="<%=basePath%>goods/getGoods/${goods.get("gid")}">
                        <img src="<%=basePath%>picture/show?pic=${goods.get("title")}">
                        <br>
                        <label>${goods.get("gname")}</label>
                        <br>
                        <label>${goods.get("price")}</label>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>

<div class="bottom">
    <div class="footer">
        <P>
            <a href="#" rel="nofollow">关于我们</a> &nbsp;|<a href="#" rel="nofollow">联系我们</a>&nbsp;|<a href="#" rel="nofollow"><a href='http://www.veryhuo.com/z/falvapp/' target='_blank'><b>法律</b></a>声明</a>&nbsp;|<a href="#" rel="nofollow">网站地图</a>&nbsp;|<a target="_blank" href="#">版权声明</a>&nbsp;|<a href="#" rel="nofollow">帮助中心</a><br />
            ***商城 版权所有　© 2005-2020　京ICP备********号</P>
    </div>
</div>
</body>
</html>
