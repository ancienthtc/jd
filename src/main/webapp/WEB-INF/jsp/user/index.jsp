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
    <link href='<%=basePath%>css/index.css' rel='stylesheet' type='text/css'/>
</head>

<body>
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
                            <dt><a rel="nofollow" href="<%=basePath%>user/toMember_index" class="FontColor"><span>${sessionScope.user.nickname}</span></a>
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
            <div class="logo fl"><h1><a href="<%=basePath%>login/view"><img src="<%=basePath%>picture/logo.png"
                                                                            alt="lywebsite"/></a></h1></div>
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
<div class="wide clean topad">
    <ul>
        <li>
            <div class="img"><img src="<%=basePath%>picture/ecc34f88fe.jpg"/></div>
            <h2 class="FontColor">FREE SHIPPING &amp;amp; RETURN</h2>
            <span>30 Days Money Back</span>
        </li>
        <li class="middle">
            <div class="img"><img src="<%=basePath%>picture/59be0d3726.jpg"/></div>
            <h2 class="FontColor">MONEY BACK GUARANTEE</h2>
            <span>All the Hottest Bargains</span>
        </li>
        <li>
            <div class="img"><img src="<%=basePath%>picture/fcb69ff355.jpg"/></div>
            <h2 class="FontColor">ONLINE SUPPORT 24/7</h2>
            <span>2x points + Free Gift</span>
        </li>
    </ul>
</div>
<div class="wide main">
    <div class="lefter fl">
        <div class="side_category sidebar">
            <div class="cate_title b_title">Products Categories</div>
            <div class="cate_menu b_main">
                <ul>
                    <c:forEach var="i" items="${parts}">
                        <li><h2><a href="<%=basePath%>part/prolist">${i.pname}</a><em class="NavArrowColor"></em></h2>
                        </li>
                    </c:forEach>
                    <!-- 换成动态板块
                    <li><h2><a href="part/prolist.jsp">Classification 01</a><em class="NavArrowColor"></em></h2></li>
                    <li><h2><a href="part/prolist.jsp">Classification 02</a><em class="NavArrowColor"></em></h2></li>
                    <li><h2><a href="part/prolist.jsp">Classification 03</a><em class="NavArrowColor"></em></h2></li>
                    <li><h2><a href="part/prolist.jsp">Classification 04</a><em class="NavArrowColor"></em></h2></li>
                    <li><h2><a href="part/prolist.jsp">Classification 05</a><em class="NavArrowColor"></em></h2></li>
                    <li><h2><a href="part/prolist.jsp">Classification 06</a><em class="NavArrowColor"></em></h2></li>
                    <li><h2><a href="part/prolist.jsp">Classification 07</a><em class="NavArrowColor"></em></h2></li>
                    -->
                </ul>
                <a class="b_bottom FontColor" href="<%=basePath%>part/prolist">See More»</a>
            </div>
        </div>

        <div id="what_hot" class="sidebar">
            <h2 class="b_title FontColor">What's Hot</h2>
            <div class="b_main">

                <c:forEach var="i" items="${hot}">
                    <dl class="pro_item clearfix">
                        <dt class="fl">
                            <a class="pic_box" href="../goods/NewGoodsDetail/${i.id}"><img
                                    src="<%=basePath%>image/show?pic=${i.title}"/><span></span></a>
                        </dt>
                        <dd class="fl pro_info">
                            <div class="pro_name"><a href="../goods/NewGoodsDetail/${i.id}">${i.name}</a></div>
                            <div class="pro_price"><em class="currency_data PriceColor"></em><span
                                    class="price_data PriceColor" data="${i.price}"></span></div>
                        </dd>
                    </dl>
                </c:forEach>

                <!-- 热销改动态数据
                <dl class="pro_item clearfix">
                    <dt class="fl"><a class="pic_box" href="pro" ><img src="picture/leftpro.jpg" /><span></span></a></dt>
                    <dd class="fl pro_info">
                        <div class="pro_name"><a href="pro" >Product Name</a></div>
                        <div class="pro_price"><em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="3.99"></span></div>
                    </dd>
                </dl>

                <dl class="pro_item clearfix">
                    <dt class="fl"><a class="pic_box" href="pro" ><img src="picture/leftpro.jpg" /><span></span></a></dt>
                    <dd class="fl pro_info">
                        <div class="pro_name"><a href="pro" >Product Name</a></div>
                        <div class="pro_price"><em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="3.99"></span></div>
                    </dd>
                </dl>

                <dl class="pro_item clearfix">
                    <dt class="fl"><a class="pic_box" href="pro" ><img src="picture/leftpro.jpg" /><span></span></a></dt>
                    <dd class="fl pro_info">
                        <div class="pro_name"><a href="pro" >Product Name</a></div>
                        <div class="pro_price"><em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="3.99"></span></div>
                    </dd>
                </dl>
                -->
                <a class="b_bottom FontColor" href="<%=basePath%>part/prolist">See More»</a>
            </div>
        </div>

        <div class="left_ad">
            <div style='overflow:hidden;'>
                <script type='text/javascript' src='<%=basePath%>js/jquery.blockui.js'></script>
                <script type='text/javascript' src='<%=basePath%>js/jquery.superslide.js'></script>
                <style type='text/css'>
                    .slideBox_4 {
                        overflow: hidden;
                        position: relative;
                    }

                    .slideBox_4 .hd {
                        height: 15px;
                        overflow: hidden;
                        position: absolute;
                        bottom: 15px;
                        z-index: 1;
                    }

                    .slideBox_4 .hd ul {
                        overflow: hidden;
                        zoom: 1;
                        float: left;
                    }

                    .slideBox_4 .hd ul li {
                        float: left;
                        margin-left: 5px;
                        width: 10px;
                        height: 10px;
                        -webkit-border-radius: 5px;
                        -moz-border-radius: 5px;
                        border-radius: 5px;
                        background: #f1f1f1;
                        cursor: pointer;
                    }

                    .slideBox_4 .hd ul li:first-child {
                        margin-left: 0;
                    }

                    .slideBox_4 .hd ul li.on {
                        background: #f00;
                        color: #fff;
                    }

                    .slideBox_4 .bd {
                        position: relative;
                        height: 100%;
                        z-index: 0;
                    }

                    .slideBox_4 .bd ul li a {
                        display: block;
                        background-position: center top;
                        background-repeat: no-repeat;
                    }
                </style>
                <div id="slideBox_4" class="slideBox_4">
                    <div class="hd">
                        <ul>
                            <li></li>
                            <li></li>
                            <li></li>
                        </ul>
                    </div>
                    <div class="bd">
                        <ul>
                            <li><a href='javascript:;'><img src='<%=basePath%>picture/leftbanner01.jpg'/></a></li>
                            <li><a href='javascript:;'><img src='<%=basePath%>picture/leftbanner02.jpg'/></a></li>
                            <li><a href='javascript:;'><img src='<%=basePath%>picture/leftbanner03.jpg'/></a></li>
                        </ul>
                    </div>
                </div>
                <script type="text/javascript">jQuery(document).ready(function () {
                    jQuery(".slideBox_4").slide({mainCell: ".bd ul", effect: "fade", autoPlay: true, interTime: 5000});
                });</script>
            </div>
        </div>


        <div class="seckill_box sidebar_to">
            <h2 class="seckill_title b_title FontColor">Flash Sales</h2>
            <div class="seckill_main b_main">
                <div class="item">
                    <div class="img pic_box"><a href="pro"><img src="<%=basePath%>picture/cuxiao.jpg"/></a><span></span>
                    </div>
                    <div class="name"><a href="<%=basePath%>pro">Promotional product name</a></div>
                    <div class="days clean" endTime="2020/07/31 16:24:00">
                        <div class="i fl">
                            <div class="pink d">00</div>
                            day
                        </div>
                        <div class="i fl">
                            <div class="h">00</div>
                            hours
                        </div>
                        <div class="i fl">
                            <div class="m">00</div>
                            mins
                        </div>
                        <div class="i fl">
                            <div class="s">00</div>
                            secs
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                //秒杀时间倒计时
                $(".seckill_box .item .days").each(function () {
                    var obj = $(this),
                        time = new Date();
                    obj.genTimer({
                        beginTime: ueeshop_config.date,
                        targetTime: obj.attr("endTime"),
                        callbackOnlyDatas: 1,
                        callback: function (e) {
                            obj.find('.d').html(e.dates > 99 ? 99 : e.dates);
                            obj.find('.h').html(e.hours);
                            obj.find('.m').html(e.minutes);
                            obj.find('.s').html(e.seconds);
                        }
                    });
                });
            });
        </script>
        <div class="left_ad">
            <div><img src='<%=basePath%>picture/6309456e94.jpg' alt=''></div>
        </div>


    </div>


    <div class="righter fr">
        <div class="index_banner">
            <div style='overflow:hidden;'>
                <script type='text/javascript' src='<%=basePath%>js/jquery.blockui.js'></script>
                <script type='text/javascript' src='<%=basePath%>js/jquery.superslide.js'></script>
                <style type='text/css'>
                    .slideBox_1 {
                        overflow: hidden;
                        position: relative;
                    }

                    .slideBox_1 .hd {
                        height: 15px;
                        overflow: hidden;
                        position: absolute;
                        bottom: 15px;
                        z-index: 1;
                    }

                    .slideBox_1 .hd ul {
                        overflow: hidden;
                        zoom: 1;
                        float: left;
                    }

                    .slideBox_1 .hd ul li {
                        float: left;
                        margin-left: 5px;
                        width: 10px;
                        height: 10px;
                        -webkit-border-radius: 5px;
                        -moz-border-radius: 5px;
                        border-radius: 5px;
                        background: #f1f1f1;
                        cursor: pointer;
                    }

                    .slideBox_1 .hd ul li:first-child {
                        margin-left: 0;
                    }

                    .slideBox_1 .hd ul li.on {
                        background: #f00;
                        color: #fff;
                    }

                    .slideBox_1 .bd {
                        position: relative;
                        height: 100%;
                        z-index: 0;
                    }

                    .slideBox_1 .bd ul li a {
                        display: block;
                        background-position: center top;
                        background-repeat: no-repeat;
                    }
                </style>
                <div id="slideBox_1" class="slideBox_1">
                    <div class="hd">
                        <ul>
                            <li></li>
                            <li></li>
                            <li></li>
                        </ul>
                    </div>
                    <div class="bd">
                        <ul>
                            <li><a href='javascript:;'><img src='<%=basePath%>picture/banner01.jpg' alt=''/></a></li>
                            <li><a href='javascript:;'><img src='<%=basePath%>picture/banner02.jpg' alt=''/></a></li>
                            <li><a href='javascript:;'><img src='<%=basePath%>picture/banner03.jpg' alt=''/></a></li>
                        </ul>
                    </div>
                </div>
                <script type="text/javascript">jQuery(document).ready(function () {
                    jQuery(".slideBox_1").slide({mainCell: ".bd ul", effect: "fade", autoPlay: true, interTime: 5000});
                });</script>
            </div>
        </div>

        <ul class="banner_list clean">
            <li><img src="<%=basePath%>picture/xiaotu1.jpg" alt=""/></li>
            <li><img src="<%=basePath%>picture/xiaotu2.jpg" alt=""/></li>
            <li><img src="<%=basePath%>picture/xiaotu3.jpg" alt=""/></li>
        </ul>

        <div class="clean">
            <div class="index_prod index_prod_list clean">
                <div class="index_prod_hd clean">
                    <h2 class="fl">New Products</h2>
                    <div class="move fr">
                        <a class="move_left" href="javascript:;"></a>
                        <a class="more_right" href="javascript:;"></a>
                    </div>
                </div>
                <div class="index_prod_bd prod_list" effects="2">
                    <div class="index_prod_row clean" num="0" style="display:block;">

                        <!---第一页产品列表开始--->
                        <c:forEach var="i" items="${fp}">
                            <div class="prod_box prod_box_2 fl">
                                <div class="prod_box_pic">
                                    <a class="pic_box" href="../goods/NewGoodsDetail/${i.id}"><img
                                            src="<%=basePath%>image/show?pic=${i.title}"/><span></span></a>
                                    <em class="icon_seckill DiscountBgColor">Sale</em>
                                </div>
                                <div class="prod_box_info">
                                    <div class="prod_box_inner">
                                        <div class="name"><a href="../goods/NewGoodsDetail/${i.id}">${i.name}</a></div>
                                        <div class="review"><span class="star star_s5"></span></div>
                                        <div class="price">
                                            <del><em class="currency_data"></em><span class="price_data"
                                                                                      data="8.99"></span></del>
                                            <em class="currency_data PriceColor"></em><span
                                                class="price_data PriceColor" data="${i.price}" keyid="932"></span>
                                        </div>
                                        <div class="add"><a class="add_btn" href="../goods/NewGoodsDetail/${i.id}">ADD
                                            TO CART</a></div>
                                    </div>
                                    <div class="add_cart_box">
                                        <div class="add_cart_bg ProListBgColor"></div>
                                        <a href="../goods/NewGoodsDetail/${i.id}" rel="nofollow" class="add_cart"
                                           data="932">Add to Cart</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <!-- 第一页改动态
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro1.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro1.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro1.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro1.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro1.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro1.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro1.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro1.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        -->
                        <!---第一页产品列表结束--->
                        <div class="clear"></div>
                    </div>


                    <div class="index_prod_row clean" num="1" style="display:none;">

                        <!---第二页产品列表开始--->
                        <c:forEach var="i" items="${sp}">
                            <div class="prod_box prod_box_2 fl">
                                <div class="prod_box_pic">
                                    <a class="pic_box" href="../goods/NewGoodsDetail/${i.id}"><img
                                            src="<%=basePath%>image/show?pic=${i.title}"/><span></span></a>
                                    <em class="icon_seckill DiscountBgColor">Sale</em>
                                </div>
                                <div class="prod_box_info">
                                    <div class="prod_box_inner">
                                        <div class="name"><a href="../goods/NewGoodsDetail/${i.id}">${i.name}</a></div>
                                        <div class="review"><span class="star star_s5"></span></div>
                                        <div class="price">
                                            <del><em class="currency_data"></em><span class="price_data"
                                                                                      data="8.99"></span></del>
                                            <em class="currency_data PriceColor"></em><span
                                                class="price_data PriceColor" data="${i.price}" keyid="932"></span>
                                        </div>
                                        <div class="add"><a class="add_btn" href="../goods/NewGoodsDetail/${i.id}">ADD
                                            TO CART</a></div>
                                    </div>
                                    <div class="add_cart_box">
                                        <div class="add_cart_bg ProListBgColor"></div>
                                        <a href="../goods/NewGoodsDetail/${i.id}" rel="nofollow" class="add_cart"
                                           data="932">Add to Cart</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <!-- 第二页改动态
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro2.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro2.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro2.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro2.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro2.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro2.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro2.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro2.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        -->

                        <!---第二页产品列表结束--->


                        <div class="clear"></div>
                    </div>


                    <div class="index_prod_row clean" num="2" style="display:none;">
                        <!---第三页产品列表开始--->
                        <c:forEach var="i" items="${tp}">
                            <div class="prod_box prod_box_2 fl">
                                <div class="prod_box_pic">
                                    <a class="pic_box" href="../goods/NewGoodsDetail/${i.id}"><img
                                            src="<%=basePath%>image/show?pic=${i.title}"/><span></span></a>
                                    <em class="icon_seckill DiscountBgColor">Sale</em>
                                </div>
                                <div class="prod_box_info">
                                    <div class="prod_box_inner">
                                        <div class="name"><a href="../goods/NewGoodsDetail/${i.id}">Product Name</a>
                                        </div>
                                        <div class="review"><span class="star star_s5"></span></div>
                                        <div class="price">
                                            <del><em class="currency_data"></em><span class="price_data"
                                                                                      data="8.99"></span></del>
                                            <em class="currency_data PriceColor"></em><span
                                                class="price_data PriceColor" data="${i.price}" keyid="932"></span>
                                        </div>
                                        <div class="add"><a class="add_btn" href="../goods/NewGoodsDetail/${i.id}">ADD
                                            TO CART</a></div>
                                    </div>
                                    <div class="add_cart_box">
                                        <div class="add_cart_bg ProListBgColor"></div>
                                        <a href="../goods/NewGoodsDetail/${i.id}" rel="nofollow" class="add_cart"
                                           data="932">Add to Cart</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <!-- 第三页动态
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro3.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro3.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro3.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro3.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro3.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro3.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro3.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="prod_box prod_box_2 fl">
                            <div class="prod_box_pic">
                                <a class="pic_box" href="pro"><img src="picture/pro3.jpg" /><span></span></a>
                                <em class="icon_seckill DiscountBgColor">Sale</em>
                            </div>
                            <div class="prod_box_info">
                                <div class="prod_box_inner">
                                    <div class="name"><a href="pro">Product Name</a></div>
                                    <div class="review"><span class="star star_s5"></span></div>
                                    <div class="price"><del><em class="currency_data"></em><span class="price_data" data="8.99"></span></del> <em class="currency_data PriceColor"></em><span class="price_data PriceColor" data="4.59" keyid="932"></span></div>
                                    <div class="add"><a class="add_btn" href="pro">ADD TO CART</a></div>
                                </div>
                                <div class="add_cart_box">
                                    <div class="add_cart_bg ProListBgColor"></div>
                                    <a href="pro" rel="nofollow" class="add_cart" data="932">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                        -->
                        <!---第三页产品列表结束--->
                        <div class="clear"></div>
                    </div>


                </div>
            </div>
        </div>

        <div class="rightad">
            <h1>WHY SHOP WITH US?</h1>
            <ul>
                <li>
                    <div class="img"><img src="<%=basePath%>picture/2b06435cf6.jpg" alt="Free Shipping"/></div>
                    <div class="title">Free Shipping</div>
                    <div class="txt">30 Days Money Back Bargains 30 Days Money Back 30 Days Money Back</div>
                    <a class="more FontColor" href="javascript:void(0);" target="_blank">Learn More &gt;</a>
                </li>
                <li class="middle">
                    <div class="img"><img src="<%=basePath%>picture/e9b4335c63.jpg" alt="Deals Hot Zone"/></div>
                    <div class="title">Deals Hot Zone</div>
                    <div class="txt">All the Hottest Bargains All the Hottest Bargains All the Hottest Bargains</div>
                    <a class="more FontColor" href="javascript:;" target="_blank">Learn More &gt;</a>
                </li>
                <li>
                    <div class="img"><img src="<%=basePath%>picture/7840d3e23b.jpg" alt="Superstar Zone"/></div>
                    <div class="title">Superstar Zone</div>
                    <div class="txt">2x points + Free Gift 2x points + Free Gift 2x points + Free Bargains Gift</div>
                    <a class="more FontColor" href="javascript:;" target="_blank">Learn More &gt;</a>
                </li>
            </ul>
        </div>
    </div>
    <div class="clear"></div>
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
            <a href="javascript:void(0);" target="_blank" style="margin:0 5px;"><img
                    src="<%=basePath%>picture/06e4596004.png" alt="2"/></a>
            <a href="javascript:void(0);" target="_blank" style="margin:0 5px;"><img
                    src="<%=basePath%>picture/a42c34df2c.png" alt="3"/></a>
            <a href="javascript:void(0);" target="_blank" style="margin:0 5px;"><img
                    src="<%=basePath%>picture/84b60e7538.png" alt="4"/></a>
        </div>
        <div class="cp fr copyright"> &nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0);" target="_blank">POWERED BY
            SZJIDING</a></div>
    </div>
</div>

</body>
</html>