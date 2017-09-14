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
    <title>购物车</title>
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

        <!--主体开始-->
            .main{
                width:100%
            }
        .main h2{ font-family:"微软雅黑";
            text-indent:2em;
            margin-top:80px;
            margin-bottom:50px;
        }
        .main .t1{ text-align:center;
            line-height:40px;}
        .main .t1 img{
            width:30px;
            height:auto;
            margin-top:10px;
        }
        .t2{ margin-top:50px;}
        <!--主体结束-->
        <!--底部版权开始-->
            .bottom{width:100%;clear:both;text-align:center;padding:10px 0;line-height:25px;color:#666;border-top:#ddd 1px solid;}
        .footer{ background-color:#999; height:50px; margin-top:160px;}
        .bottom a{margin-top:50px;color:#666; padding-top:30px; margin-left:15px;}
        .bottom a:hover{color:#000;text-decoration:underline;}
        .bottom p{ text-align:center; line-height:25px;}
    </style>

    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.js"></script>
    <!-- 从购物车删除 -->
    <script type="text/javascript">
        $(document).ready(function(){
            <!-- 加入购物车 -->
            $(".delete").click(function() {
                var itemid=$(this).attr("name");
                var date='{cartitemid:'+itemid+'}';
                $.ajax( {
                    type : 'POST',
                    contentType : 'application/json',
                    url : '<%=basePath%>cart/del',
                    data : date,
                    dataType : 'json',
                    success : function(data) {
                        //alert(data);
                        if(data==false)
                        {
                            alert("删除失败!");
                        }
                        else if(data==true)
                        {
                            alert("删除成功!");
                            window.location.href="<%=basePath%>cart/toCart/${sessionScope.user.id}";
                        }

                    },
                    error : function(data) {
                        alert("错误!")
                    }
                });
            });

            $("#alldel").click(function () {
                var uid=$("#uid").attr("value");
                var date='{uid:'+uid+'}';
                $.ajax( {
                    type : 'POST',
                    contentType : 'application/json',
                    url : '<%=basePath%>cart/delall',
                    data : date,
                    dataType : 'json',
                    success : function(data) {
                        //alert(data);
                        if(data==false)
                        {
                            alert("删除失败!");
                        }
                        else if(data==true)
                        {
                            alert("删除成功!");
                            window.location.href="<%=basePath%>cart/toCart/${sessionScope.user.id}";
                        }
                    },
                    error : function(data) {
                        alert("错误!")
                    }
                });
            });

            //结算
            $("#cal").click(function () {
                var userid=$("#uid").attr("value");
                var total=$("#info2").text();
                var checkbox_count=0;
                var goodslist="";
                goodslist=goodslist+"{'goods':[";
                $('input[name="choose"]:checked').each(function(t,n){//每个checkbox
                    var tablerow = $(this).parent().parent();
                    //console.log(tablerow);
                    var title = tablerow.find("[name='title']").attr("value");
                    var gid = tablerow.find("[name='title']").attr("value2");
                    var name= tablerow.find("[name='name']").attr("value");
                    var price= tablerow.find("[name='price']").attr("value");
                    var amount= tablerow.find("[name='gclass']").attr("value");
                    var gclass= tablerow.find("[name='gclass']").attr("value2");
                    var all= tablerow.find("[name='all']").attr("value");
                    var ciid= tablerow.find("[name='all']").attr("value2");
                    goodslist=goodslist+"{'title':'"+title+ "','gid':'"+gid+"','name':'"+name+"','price':'"+price+"','amount':'"+amount+"','gclass':'"+gclass+"','all':'"+all+"','ciid':'"+ciid+"'},";
                    //console.log(a);
                    checkbox_count++;
                });
                goodslist=goodslist.substr(0,goodslist.length-1);
                //a.append("]}");
                goodslist=goodslist+"]}";
                //console.log(goodslist);
                //嵌入goodslist
                var json=goodslist.substr(0,goodslist.length-1)+",'userid':'"+userid+"','total':'"+total+"'}";
                //console.log(json);
                if(!checkbox_count>0)
                {
                    alert("请选择结算商品");
                    return;
                }
                //alert("开始提交");
                <%--submitForm("<%=basePath%>cart/tocommit","{name:json,val:"+json+"}");--%>

                var form = $("<form></form>");
                form.attr('action', "<%=basePath%>cart/tocommit");
                form.attr('method', 'post');
                form.attr('target', '_self');

                var input1 = $("<input type='hidden' name='json' />");
                input1.attr('value', json);
                form.append(input1);

                form.appendTo("body");
                form.css('display', 'none');
                form.submit();

                <%--$.ajax({--%>
                    <%--type : "POST",--%>
                    <%--contentType : 'application/json',--%>
                    <%--url : "<%=basePath%>cart/tocommit",--%>
                    <%--data : json,--%>
                    <%--async : false,--%>
                    <%--success : function(data){--%>
                        <%--console.log(data);--%>
                    <%--}--%>
                <%--});--%>

                <%--$.ajax( {--%>
                    <%--type : 'POST',--%>
                    <%--contentType : 'application/json',--%>
                    <%--url : '<%=basePath%>cart/tocommit',--%>
                    <%--data : json,--%>
                    <%--//dataType : 'text',--%>
                    <%--success : function(data) {--%>
                        <%--//window.location=data;--%>
                        <%--//window.location.reload(data);--%>
                        <%--//console.log(data);--%>
                        <%--//alert(data);--%>
                        <%--&lt;%&ndash;window.location.href = "'<%=basePath%>"+data+"'";&ndash;%&gt;--%>
                        <%--console.log(data);--%>
                        <%--&lt;%&ndash;window.location.href = "<%=basePath%>cart/commit";&ndash;%&gt;--%>
                        <%--window.open("<%=basePath%>cart/commit");--%>
                    <%--},--%>
                    <%--error : function(data) {--%>
                        <%--console.log("1 "+data);--%>
                        <%--alert(data);--%>
                        <%--alert("错误");--%>
                    <%--}--%>
                <%--});--%>
            });

            //选择商品

            $(".choose").click(function () {
                var a="";
                //a.append("{'goods':[");
                a=a+"{'goods':[";
                $('input[name="choose"]:checked').each(function(t,n){//每个checkbox
                    var tablerow = $(this).parent().parent();
                    //console.log(tablerow);
                    var title = tablerow.find("[name='title']").attr("value");
                    var gid = tablerow.find("[name='title']").attr("value2");
                    var name= tablerow.find("[name='name']").attr("value");
                    var price= tablerow.find("[name='price']").attr("value");
                    var amount= tablerow.find("[name='gclass']").attr("value");
                    var gclass= tablerow.find("[name='gclass']").attr("value2");
                    var all= tablerow.find("[name='all']").attr("value");
                    var ciid= tablerow.find("[name='all']").attr("ciid");
                    a=a+"{'title':'"+title+ "','gid':'"+gid+"','name':'"+name+"','price':'"+price+"','amount':'"+amount+"','gclass':'"+gclass+"','all':'"+all+"','ciid':'"+ciid+"'},";
                    //console.log(a);
                });
                a=a.substr(0,a.length-1);
                //a.append("]}");
                a=a+"]}";
                //console.log(a);
                $.ajax( {
                    type : 'POST',
                    contentType : 'application/json',
                    url : '<%=basePath%>cart/getcal',
                    data : a,
                    dataType : 'json',
                    success : function(data) {
                        //console.log(data.allof);
                        if(data.length != false)
                        {
                            $("#info1").html("");//清空info内容
                            $("#info2").html("");
                            $("#info1").append( data.count );
                            $("#info2").append( data.allof );
                        }
                        if(data==null || data.length<=0 || data==false)
                        {
                            $("#info1").html("");//清空info内容
                            $("#info2").html("");
                            $("#info1").append( 0 );
                            $("#info2").append( 0 );
                        }
                    },
                    error : function(data) {
                        //alert("错误!");
                        $("#info1").html("");//清空info内容
                        $("#info2").html("");
                        $("#info1").append( 0 );
                        $("#info2").append( 0 );
                    }
                });
            });

//            function submitForm(action, params) {
//                var form = $("<form></form>");
//                form.attr('action', action);
//                form.attr('method', 'post');
//                form.attr('target', '_self');
//                for(var i=0 ; i < params.length;i ++){
//                    var input1 = $("<input type='hidden' name='"+params[i].name+"' />");
//                    input1.attr('value', params[i].val);
//                    form.append(input1);
//                }
//                form.appendTo("body");
//                form.css('display', 'none');
//                form.submit();
//            }

        });
    </script>

</head>

<body>
<!--头部开始-->
<div class="head">
    <div class="h_left"><p>欢迎光临 ${sessionScope.user.nickname}&nbsp;&nbsp; <a href="">退出</a></p></div>
    <div class="h_right">
        <ul>
            <li><a herf="javascript:void(0)"  onclick="window.location.href='<%=basePath%>user/toShopHome'">首页</a></li>
            <li><a href="<%=basePath%>user/toShopCenter">用户管理</a></li>
            <li><a href="" style="font-size:18px; color:#F00;">购&nbsp;&nbsp;物&nbsp;&nbsp;车</a></li>
        </ul>
    </div>
</div>
<!--搜索框开始-->
<div id="search_box">
    <form id="search_form" method="post" action="<%=basePath%>goods/search">
        <input type="text" id="key" name="key" value="Search" class="swap_value" />
        <input type="image" src="http://files.jb51.net/demoimg/200912/btn_search_box.gif" width="27" height="24" id="go" alt="Search" title="Search" />
    </form>
</div>
<!--头部结束-->

<!--主体开始-->
<div class="main">
    <h2>商品列表</h2>
    <input type="hidden" id="uid" value="${sessionScope.user.id}">
    <table class="t1" width="92%">
        <tr>
            <th scope="col">选择</th>
            <th scope="col">图片</th><!-- 图片 -->
            <th scope="col">商品名</th>
            <th scope="col">单&nbsp;价</th>
            <th scope="col">数&nbsp;量</th>
            <th scope="col">总&nbsp;额</th>
            <th scope="col">删除</th><!-- 删除 -->
        </tr>
        <c:if test="${not empty items}">
            <c:forEach var="col" items="${items}">
                <tr>
                    <c:if test="${empty col.get('id')}" >
                        <td colspan="6">该商品已下架</td>
                    </c:if>
                    <c:if test="${not empty col.get('id')}" >
                        <td><input type="checkbox" name="choose" class="choose"></td>
                        <td name="title" value="${col.get("title")}" value2="${col.get("id")}"><img src="<%=basePath%>picture/show?pic=${col.get("title")}"></td><!-- 图片名 -->
                        <td name="name" value="${col.get("name")}">${col.get("name")}</td><!-- 商品名 -->
                        <td name="price" value="${col.get("price")}">￥ ${col.get("price")}</td><!-- 单价 -->
                        <td name="gclass" value="${col.get("amount")}" value2="${col.get("gclass")}">${col.get("amount")} / ${col.get("gclass")}</td><!-- 单位 -->
                        <td name="all" value="${col.get("all")}" value2="${col.get("ciid")}">￥ ${col.get("all")}</td><!-- 总额 -->
                    </c:if>

                    <td><input type="button" class="delete" name="${col.get("ciid")}" id="del${col.get("ciid")}" value="删除"></td>
                </tr>
            </c:forEach>
        </c:if>
        <c:if test="${empty items}">
            <tr>
                <td colspan="7"><a href="<%=basePath%>login/view">暂无商品，前去购买</a></td>
            </tr>
        </c:if>
        <%--<tr>--%>
            <%--<td><img src="img/good2.png"></td>--%>
            <%--<td>长裙</td>--%>
            <%--<td>￥22.8</td>--%>
            <%--<td>4</td>--%>
            <%--<td>￥91.2</td>--%>
            <%--<td><input type="button" name="delete" value="删除"></td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
            <%--<td><img src="img/good4.png"></td>--%>
            <%--<td>富士山</td>--%>
            <%--<td>￥4.5</td>--%>
            <%--<td>1</td>--%>
            <%--<td>￥4.5</td>--%>
            <%--<td><input type="button" name="delete" value="删除"></td>--%>
        <%--</tr>--%>
    </table>
    <table class="t2" width="92%">
        <tr>
            <th scope="col"><input type="button" id="alldel" name="delete" value="全部删除" style=" margin-left:-10px;"></th>
            <%--<th scope="col">商品共&nbsp;${cal.get("count")}&nbsp;件</th>--%>
            <%--<th scope="col" id="total" name="${cal.get("total")}">合计：&nbsp;${cal.get("total")}</th>--%>
            <%--<th scope="col"><input type="button" id="cal" name="sub" value="结算" style="margin-right:15px;"></th>--%>
            <th scope="col">商品共&nbsp; <label id="info1">0</label> &nbsp;件</th>
            <th scope="col" id="total" name="">合计：￥<label id="info2">0</label>&nbsp;</th>
            <th scope="col"><input type="button" id="cal" name="sub" value="结算" style="margin-right:15px;"></th>
        </tr>
    </table>


</div>
<!--主体结束-->
<div class="bottom">
    <div class="footer">
        <P>
            <a href="#" rel="nofollow">关于我们</a> &nbsp;|<a href="#" rel="nofollow">联系我们</a>&nbsp;|<a href="#" rel="nofollow"><a href='http://www.veryhuo.com/z/falvapp/' target='_blank'><b>法律</b></a>声明</a>&nbsp;|<a href="#" rel="nofollow">网站地图</a>&nbsp;|<a target="_blank" href="#">版权声明</a>&nbsp;|<a href="#" rel="nofollow">帮助中心</a><br />
            ***商城 版权所有　© 2005-2020　京ICP备********号</P>
    </div>
</div>
</body>
</html>
