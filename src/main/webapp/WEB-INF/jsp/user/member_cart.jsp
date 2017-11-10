<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>ShangHai Heavy·Foot International Trade Co.,Ltd.</title>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <link href='<%=basePath%>css/global.css' rel='stylesheet' type='text/css'/>
    <link href='<%=basePath%>css/global_1.css' rel='stylesheet' type='text/css'/>
    <link href='<%=basePath%>css/user.css' rel='stylesheet' type='text/css'/>
    <link href='<%=basePath%>css/style.css' rel='stylesheet' type='text/css'/>

    <link href='<%=basePath%>css/user/special.css' rel='stylesheet' type='text/css'/>

    <script type='text/javascript' src='<%=basePath%>js/jquery-1.7.2.min.js'></script>
    <script type='text/javascript' src='<%=basePath%>js/en.js'></script>
    <script type='text/javascript' src='<%=basePath%>js/global.js'></script>
    <script type='text/javascript' src='<%=basePath%>js/user.js'></script>
    <script type='text/javascript' src='<%=basePath%>js/main.js'></script>
    <!-- Facebook Pixel Code -->
    <script type="text/javascript">
        !function (f, b, e, v, n, t, s) {
            if (f.fbq)return;
            n = f.fbq = function () {
                n.callMethod ? n.callMethod.apply(n, arguments) : n.queue.push(arguments)
            };
            if (!f._fbq) f._fbq = n;
            n.push = n;
            n.loaded = !0;
            n.version = '2.0';
            n.queue = [];
            t = b.createElement(e);
            t.async = !0;
            t.src = v;
            s = b.getElementsByTagName(e)[0];
            s.parentNode.insertBefore(t, s)
        }(window, document, 'script', 'https://connect.facebook.net/en_US/fbevents.js');
        fbq('init', '');
        fbq('track', "PageView");
    </script>
    <noscript><img height="1" width="1" style="display:none"
                   src="<%=basePath%>picture/3523c051d6d54a079309b12eae2c624f.gif"/></noscript>
    <!-- End Facebook Pixel Code -->
    <link href='<%=basePath%>css/cart.css' rel='stylesheet' type='text/css'/>
    <script type='text/javascript' src='<%=basePath%>js/cart.js'></script>
    <script type='text/javascript' src='<%=basePath%>js/tool_tips_web.js'></script>

    <script type="text/javascript">
        $(document).ready(function(){

            //选择商品
            $(".va_m").click(function () {
                //console.log($(this).parent().find("[name='name']").val());
                var a="";
                //a.append("{'goods':[");
                a=a+"{'goods':[";
                $('input[name="select"]:checked').each(function(t,n){//每个checkbox
                    var tablerow = $(this).parent();
                    //console.log(tablerow);
                    var title = tablerow.find("[name='title']").attr("value");
                    var gid = tablerow.find("[name='gid']").attr("value");
                    var name= tablerow.find("[name='name']").attr("value");
                    var price= tablerow.find("[name='price']").attr("value");
                    var amount= tablerow.find("[name='amount']").attr("value");
                    var gclass= tablerow.find("[name='gclass']").attr("value");
                    var all= tablerow.find("[name='all']").attr("value");
                    var ciid= tablerow.find("[name='ciid']").attr("value");
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
                        console.log(data.allof);
                        if(data.length != false)
                        {
                            $("#span_count").text(data.count);
                            $("#strong_total").text(data.allof);
                        }
                        if(data==null || data.length<=0 || data==false)
                        {
                            $("#span_count").text(0);
                            $("#strong_total").text(0);
                        }
                    },
                    error : function(data) {
                        alert("错误!");
//                        $("#allamount").attr("start",0);
//                        $("#allprice").attr("price",0);
//                        $("#allprice").text(0);
                    }
                });
            });

            //移除商品
            $("#delone").click(function () {
                var itemid=$(this).attr("ciid");
                var date='{cartitemid:'+itemid+'}';
                console.log(itemid+"/"+date);
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

            //移除全部
            $("#delall").click(function () {
                var uid=${sessionScope.user.id};
                if(uid==null || uid.length<=0)
                {
                    return false;
                }
                var date='{uid:'+uid+'}';
                //console.log(date);
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

            //提交购物车
            $("#cart_cal").click(function () {
                var userid=${sessionScope.user.id};
                if(userid==null || userid.length<=0)
                {
                    return false;
                }
                var total=$("#strong_total").text();
                var checkbox_count=0;
                var goodslist="";
                goodslist=goodslist+"{'goods':[";
                $('input[name="select"]:checked').each(function(t,n){//每个checkbox
                    var tablerow = $(this).parent().parent();
                    //var tablerow=$("#father_select");
                    //console.log(tablerow);
                    var title = tablerow.find("[name='title']").attr("value");
                    var gid = tablerow.find("[name='gid']").attr("value");
                    var name= tablerow.find("[name='name']").attr("value");
                    var price= tablerow.find("[name='price']").attr("value");
                    var amount= tablerow.find("[name='amount']").attr("value");
                    var gclass= tablerow.find("[name='gclass']").attr("value");
                    //fid
                    var fid= tablerow.find("[name='fid']").attr("value");
                    //fname
                    var fname= tablerow.find("[name='fname']").attr("value");

                    var all= tablerow.find("[name='all']").attr("value");
                    var ciid= tablerow.find("[name='ciid']").attr("value");
                    goodslist=goodslist+"{'title':'"+title+ "','gid':'"+gid+"','name':'"+name+"','price':'"+price+"','amount':'"+amount
                        +"','gclass':'"+gclass+"','all':'"+all+"','ciid':'"+ciid+"','fid':'"+fid+"','fname':'"+fname+"'},";
                    //console.log(a);
                    checkbox_count++;
                });
                goodslist=goodslist.substr(0,goodslist.length-1);
                //a.append("]}");
                goodslist=goodslist+"]}";
                //console.log(goodslist);
                //嵌入goodslist
                var json=goodslist.substr(0,goodslist.length-1)+",'userid':'"+userid+"','total':'"+total+"'}";
                console.log(json);
                if(!checkbox_count>0)
                {
                    alert("请选择结算商品");
                    return;
                }

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

            });

        });

    </script>
</head>

<body class="lang_en">
<link href='<%=basePath%>css/nav.css' rel='stylesheet' type='text/css'/>
<script type="text/javascript">
    $(window).resize(function () {
        $(window).webDisplay(0);
    });
    $(window).webDisplay(0);
    var ueeshop_config = {
        "domain": "http://szjiding.com",
        "date": "2017/09/13 11:13:35",
        "lang": "en",
        "currency": "USD",
        "currency_symbols": "$",
        "currency_rate": "1.0000",
        "FbAppId": "1594883030731762",
        "FbPixelOpen": "1",
        "UserId": "2",
        "TouristsShopping": "1",
        "PaypalExcheckout": ""
    }
</script>

<div id="header">
    <div class="top">
        <div class="wide">
            <ul class="crossn top_info clean">
                <li class="block fl border_r drop">
                    <div class="fl"><strong>Currency:</strong></div>
                    <dl class="fl">
                        <dt><strong id="currency" class="FontColor"></strong></dt>
                        <dd class="currency">
                            <a rel="nofollow" href="javascript:;" data="USD"><img
                                    src="<%=basePath%>picture/53092c531f.jpg" alt="USD"/>USD</a>
                            <a rel="nofollow" href="javascript:;" data="EUR"><img
                                    src="<%=basePath%>picture/b355374c5e.jpg" alt="EUR"/>EUR</a>
                            <a rel="nofollow" href="javascript:;" data="GBP"><img
                                    src="<%=basePath%>picture/f5e3cb314d.jpg" alt="GBP"/>GBP</a>
                            <a rel="nofollow" href="javascript:;" data="CAD"><img
                                    src="<%=basePath%>picture/235af43e96.jpg" alt="CAD"/>CAD</a>
                        </dd>
                    </dl>
                </li>
                <li class="block fl border_r sign">
                    <div class="FontColor fl">Welcome&nbsp;</div>
                    <dl class="fl">

                        <c:if test="${not empty sessionScope.user}">
                            <dt><a rel="nofollow" href="<%=basePath%>user/toMember_index.htm" class="FontColor"><span>${sessionScope.user.nickname}</span></a>
                            </dt>
                            <dd class="user">
                                <a rel="nofollow" href="<%=basePath%>member_orders_list.htm">My Orders</a>
                                <a rel="nofollow" href="<%=basePath%>member_favorite.htm">My Favorites</a>
                                <a rel="nofollow" href="<%=basePath%>member_sysinfo_list.htm">Message</a>
                                <a rel="nofollow" href="<%=basePath%>user/userExit">Sign Out</a>
                            </dd>
                        </c:if>
                        <c:if test="${empty sessionScope.user}">
                            <dt><a rel="nofollow" href="<%=basePath%>login_register" class="FontColor"><span>请登录</span></a>
                            </dt>
                        </c:if>

                    </dl>
                </li>
                <c:if test="${empty sessionScope.user}">
                    <li class="fr border_r"><a href="<%=basePath%>login_register">Wish List</a></li>
                    <li class="fr border_r"><a href="<%=basePath%>login_register">My Account</a></li>
                </c:if>
                <c:if test="${not empty sessionScope.user}">
                    <li class="fr border_r"><a href="<%=basePath%>member_favorite.htm">Wish List</a></li>
                    <li class="fr border_r"><a href="<%=basePath%>user/toMember_index">My Account</a></li>
                </c:if>
            </ul>
        </div>
    </div>

    <div class="FontBgColor">
        <div class="wide">
            <div class="logo fl"><h1><a href="<%=basePath%>login/view"><img src="<%=basePath%>picture/logo.png" alt="lywebsite"/></a></h1></div>
            <div class="intro fr">
                <div class="intro_info fl"> | <a href="<%=basePath%>about">Contact Us</a></div>
                <c:if test="${not empty sessionScope.user}">
                    <a class="cart_inner fl header_cart" href="<%=basePath%>cart/toCart/${sessionScope.user.id}"><span class="cart_count">1</span></a>
                </c:if>
                <c:if test="${empty sessionScope.user}">
                    <a class="cart_inner fl header_cart" href="<%=basePath%>login_register"><span class="cart_count">1</span></a>
                </c:if>
            </div>
            <div class="search fr NavBgColor">
                <form action="<%=basePath%>goods/search" method="post" class="form">
                    <input type="text" class="text fl" placeholder="" name="Keyword" notnull="" value=""/>
                    <div class="category NavBorderColor1">
                        <div class="head">All Products<em></em></div>
                        <ul class="list">
                            <li cateid="0">All Products</li>
                            <li cateid="371">Classification 01</li>
                            <li cateid="374">Classification 02</li>
                            <li cateid="378">Classification 03</li>
                            <li cateid="380">Classification 04</li>
                            <li cateid="381">Classification 05</li>
                        </ul>
                    </div>
                    <input type="submit" class="button fr FontBgColor" value=""/>
                    <input type="hidden" name="CateId" value=""/>
                </form>
            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>
<div id="nav" class="NavBgColor">
    <div class="wide clean">
        <div class="nav fl NavBorderColor1">
            <div class="item fl">
                <a href="<%=basePath%>login/view" class="navlink NavHoverBgColor NavBorderColor1">HomePage</a>
            </div>
            <div class="item fl">
                <a href="<%=basePath%>about" class="navlink NavHoverBgColor NavBorderColor1">About Us</a>
            </div>
            <div class="item fl">
                <a href="<%=basePath%>part/prolist" class="navlink NavHoverBgColor NavBorderColor1">Products</a>
            </div>
            <div class="item fl">
                <a href="<%=basePath%>about" class="navlink NavHoverBgColor NavBorderColor1">Equipment</a>
            </div>
            <div class="item fl">
                <a href="<%=basePath%>about" class="navlink NavHoverBgColor NavBorderColor1">Culture</a>
            </div>
            <div class="item fl">
                <a href="<%=basePath%>about" class="navlink NavHoverBgColor NavBorderColor1">Honor</a>
            </div>
            <div class="item fl">
                <a href="<%=basePath%>about" class="navlink NavHoverBgColor NavBorderColor1">Quality</a>
            </div>
            <div class="item fl">
                <a href="<%=basePath%>about" class="navlink NavHoverBgColor NavBorderColor1">Contact Us</a>
            </div>
        </div>
    </div>
</div>
<div id="main" class="wide">
    <script type="text/javascript">$(document).ready(function () {
        cart_obj.cart_list()
    });
    </script>
    <div id="lib_cart">
        <div class="step">
            <div></div>
        </div>
        <div class="cartHeader">
            <a name="continue_shopping" class="textbtn fl" title="Continue Shopping">Continue Shopping</a>
            <a class="checkoutBtn fr">Proceed to Checkout</a>
        </div>
        <form name="shopping_cart">
            <div class="cartFrom">
                <table width="100%" align="center" cellpadding="12" cellspacing="0" border="0" class="itemFrom">
                    <thead>
                    <tr>
                        <td width="1%" class="first">
                            <input type="checkbox" name="select_all" value="" class="va_m" checked/></td>
                        <td width="48%">Item</td>
                        <td width="16%">Price</td>
                        <td width="20%" class="quantity">Quantity</td>
                        <td width="16%">Total</td>
                    </tr>
                    </thead>
                    <tbody id="father_select">
                    <c:if test="${empty items}">
                        <tr>
                            <td colspan="5">
                                <%--<a href="<%=basePath%>part/prolist">暂无商品,前去购买</a>--%>
                                <a href="<%=basePath%>part/prolist">There is no goods in cart,please to go shoping.</a>
                            </td>

                        </tr>
                    </c:if>
                    <c:if test="${not empty items}">
                        <c:forEach var="item" items="${items}">
                            <tr>
                                <td>
                                    <input type="checkbox" name="select" value="474" class="va_m" checked/>
                                    <input type="hidden" name="name" value="${item.get("name")}"/>
                                    <input type="hidden" name="title" value="${item.get("title")}"/>
                                    <input type="hidden" name="gid" value="${item.get("id")}"/>
                                    <input type="hidden" name="price" value="${item.get("price")}"/>
                                    <input type="hidden" name="gclass" value="${item.get("gclass")}"/>
                                    <input type="hidden" name="amount" value="${item.get("amount")}"/>

                                    <input type="hidden" name="fid" value="${item.get("fid")}"/>
                                    <input type="hidden" name="fname" value="${item.get("fname")}"/>

                                    <input type="hidden" name="ciid" value="${item.get("ciid")}"/>
                                    <input type="hidden" name="all" value="${item.get("all")}"/>
                                </td>
                                <td class="prList">
                                    <dl>
                                        <dt>
                                            <a href="<%=basePath%>goods/NewGoodsDetail/${item.get("id")}">
                                                <img src="<%=basePath%>image/show?pic=${item.get("title")}"/>
                                            </a>
                                        </dt>
                                        <dd>
                                            <h4><a href="<%=basePath%>goods/NewGoodsDetail/${item.get("id")}">${item.get("name")}</a></h4>
                                            <p>${item.get("id")}</p>
                                            <%--<p class="remark">--%>
                                                <%--Remark:<input type="text" name="Remark[]" value="" maxlength="200" data=""/>--%>
                                                <%--<span><img src="<%=basePath%>picture/edit.png"/></span>--%>
                                            <%--</p>--%>
                                            <p>
                                                Format:${item.get("fname")}
                                                <%--<c:if test="${item.get('fname')==null}">--%>
                                                    <%--Format:DEFAULT--%>
                                                <%--</c:if>--%>
                                                <%--<c:if test="${item.get('fname')!=null}">--%>
                                                    <%--Format:${item.get("fname")}--%>
                                                <%--</c:if>--%>
                                            </p>
                                        </dd>
                                    </dl>
                                </td>
                                <td class="prPrice"><p price="${item.get("price")}" discount="100">${item.get("price")}</p></td>
                                <td class="prQuant" id="allamount" start="${item.get("amount")}"><!-- 全部数量 -->
                                    <img src="<%=basePath%>picture/reduce.png" name="reduce"/>
                                    <input type="text" name="Qty[]" value="1" maxlength="4"/>
                                    <img src="<%=basePath%>picture/add.png" name="add"/>
                                    <input type="hidden" name="S_Qty[]" value="1"/>
                                    <input type="hidden" name="CId[]" value="474"/>
                                    <input type="hidden" name="ProId[]" value="938"/>
                                </td>
                                <td class="prAmount">
                                    <p id="allprice" price="${item.get("all")}">${item.get("all")}</p><!-- 全部价格 -->
                                    <%--<a href="/cart/remove_c0474.html" rel="del" title="remove item">remove item</a>--%>
                                    <input type="button" id="delone" ciid="${item.get("ciid")}" value="remove item" onclick="javascript:void(0);"/>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    </tbody>
                    <tfoot>
                    <tr class="shopping_cart_total">
                        <td colspan="4" align="right"><label>Subtotal</label> (<span id="span_count">${cal.get("count")} items</span>) :</td>
                        <td><strong id="strong_total">${cal.get("total")}</strong></td>
                    </tr>
                    </tfoot>
                </table>
                <input type="hidden" name="CartProductPrice" value="7.99"/>
                <input type="hidden" name="DiscountPrice" value="0" data-type="0" data-value="[]"/>
            </div>
        </form>
        <div class="cartFooter">
            <a name="continue_shopping" href="<%=basePath%>part/prolist" class="textbtn fl" title="Continue Shopping">Continue Shopping</a>

            <%--<a name="remove" class="textbtn fl" title="Remove">Remove</a>--%>
            <input type="button" class="textbtn fl" value="Remove" id="delall"/>
            <input type="button" class="checkoutBtn fr" id="cart_cal" value="Proceed to Checkout"/>

            <%--<span class="fr">OR</span>--%>
            <%--<button class="paypal_checkout_button fr" onclick="javascript:void(0);"></button>--%>

            <script src="<%=basePath%>js/checkout.js" async></script>

            <div class="clear"></div>
        </div>
        <div class="clear"></div>
        <div class="cartBox">
            <h2>Your Recent History</h2>
            <div class="contents products clearfix">

                <dl class="pro_item fl">
                    <dt><a class="pic_box" href="pro.htm"><img src="<%=basePath%>picture/pro.jpg"/><span></span></a></dt>
                    <dd class="pro_name"><a href="pro.htm">Product Name</a></dd>
                </dl>

                <dl class="pro_item fl">
                    <dt><a class="pic_box" href="pro.htm"><img src="<%=basePath%>picture/pro.jpg"/><span></span></a></dt>
                    <dd class="pro_name"><a href="pro.htm">Product Name</a></dd>
                </dl>

                <dl class="pro_item fl">
                    <dt><a class="pic_box" href="pro.htm"><img src="<%=basePath%>picture/pro.jpg"/><span></span></a></dt>
                    <dd class="pro_name"><a href="pro.htm">Product Name</a></dd>
                </dl>

                <dl class="pro_item fl">
                    <dt><a class="pic_box" href="pro.htm"><img src="<%=basePath%>picture/pro.jpg"/><span></span></a></dt>
                    <dd class="pro_name"><a href="pro.htm">Product Name</a></dd>
                </dl>

                <dl class="pro_item fl">
                    <dt><a class="pic_box" href="pro.htm"><img src="<%=basePath%>picture/pro.jpg"/><span></span></a></dt>
                    <dd class="pro_name"><a href="pro.htm">Product Name</a></dd>
                </dl>

                <dl class="pro_item fl">
                    <dt><a class="pic_box" href="pro.htm"><img src="<%=basePath%>picture/pro.jpg"/><span></span></a></dt>
                    <dd class="pro_name"><a href="pro.htm">Product Name</a></dd>
                </dl>

                <dl class="pro_item fl">
                    <dt><a class="pic_box" href="pro.htm"><img src="<%=basePath%>picture/pro.jpg"/><span></span></a></dt>
                    <dd class="pro_name"><a href="pro.htm">Product Name</a></dd>
                </dl>


            </div>
        </div>
    </div>
</div>

<div id="footer">
    <div class="foot wide clean">
        <div class="foot_menu fl">
            <div class="foot_menu_hd">About Us</div>
            <ul class="list">
                <li><a href="<%=basePath%>about"><em></em>About Us</a></li>
                <li><a href="<%=basePath%>part/prolist"><em></em>Products</a></li>
                <li><a href="<%=basePath%>about"><em></em>Equipment</a></li>
                <li><a href="<%=basePath%>about"><em></em>Honor</a></li>
                <li><a href="<%=basePath%>about"><em></em>Contact Us</a></li>
            </ul>
        </div>
        <div class="foot_menu fcu fl">
            <div class="foot_menu_hd">Contact Us</div>
            <div class="fcu_item fcu_0"><strong>Address:</strong><br/>China JiangSu SuZhou</div>
            <div class="fcu_item fcu_1"><strong>Phone:</strong><br/>0512-57609476</div>
            <div class="fcu_item fcu_2"><strong>Email:</strong><br/><a
                    href="mailto:Heavyfoot@qq.com">Heavyfoot@qq.com</a></div>
        </div>
        <div class="foot_menu fMain fl">
            <div class="foot_menu_hd">Overview</div>
            <ul class="list">
                <li><a href="<%=basePath%>about">PAYMENT METHODS</a></li>
                <li><a href="<%=basePath%>about">SHIPPING &amp; RETURNS</a></li>
                <li><a href="<%=basePath%>about">Location &amp; Working Hours</a></li>
            </ul>
        </div>
        <div class="newsletter foot_menu fl">
            <div class="foot_menu_hd">Be the First to Know</div>
            <div class="newsletter_tips">Get all the latest information on Events, Sales and Offers. Sign up for
                newsletter today.
            </div>
            <div class="newsletter_title">Enter your e-mail Address</div>
            <div class="form">
                <form id="newsletter_foot_form">
                    <input type="text" class="text" name="Email" value="" notnull="" format="Email"/>
                    <input type="submit" class="button FontBgColor" value="Subscribe"/>
                </form>
            </div>
        </div>
        <div class="clear"></div>
    </div>
</div>

<div id="copyright">
    <div class="wide clean">
        <div class="cp fl">
            <a href="javascript:void(0);" target="_blank" style="margin:0 5px;"><img src="<%=basePath%>picture/06e4596004.png" alt="2"/></a>
            <a href="javascript:void(0);" target="_blank" style="margin:0 5px;"><img src="<%=basePath%>picture/a42c34df2c.png" alt="3"/></a>
            <a href="javascript:void(0);" target="_blank" style="margin:0 5px;"><img src="<%=basePath%>picture/84b60e7538.png" alt="4"/></a>
        </div>
        <div class="cp fr copyright"> &nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0);" target="_blank">POWERED BY
            SZJIDING</a></div>
    </div>
</div>


<div id="div_side">

    <a target="_blank"
       href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=RCYlK2opJWk3KiszPWouJSkhNwQiKzwpJS0oaicrKQ"
       style="text-decoration:none;">
        <img src="<%=basePath%>picture/mail.png" alt="">
    </a>
</div>

</body>
</html>