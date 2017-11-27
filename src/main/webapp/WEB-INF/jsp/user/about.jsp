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
    <link href='css/global.css' rel='stylesheet' type='text/css'/>
    <link href='css/global_1.css' rel='stylesheet' type='text/css'/>
    <link href='css/user.css' rel='stylesheet' type='text/css'/>
    <link href='css/style.css' rel='stylesheet' type='text/css'/>

    <link href='<%=basePath%>css/user/special.css' rel='stylesheet' type='text/css'/>

    <script type='text/javascript' src='js/jquery-1.7.2.min.js'></script>
    <script type='text/javascript' src='js/en.js'></script>
    <script type='text/javascript' src='js/global.js'></script>
    <script type='text/javascript' src='js/user.js'></script>
    <script type='text/javascript' src='js/main.js'></script>
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
    <noscript><img height="1" width="1" style="display:none" src="picture/3523c051d6d54a079309b12eae2c624f.gif"/>
    </noscript>
    <!-- End Facebook Pixel Code -->
</head>

<body class="lang_en">
<style type="text/css">
    .FontColor, a.FontColor, a.FontColor:hover, a:hover {
        color: #00C17E;
    }

    .FontBgColor {
        background-color: #00C17E;
    }

    .FontBorderColor {
        border-color: #00C17E;
    }

    .FontBorderHoverColor:hover, a.FontBorderHoverColor:hover {
        border-color: #00C17E;
    }

    .FontBgHoverColor:hover {
        background-color: #00C17E !important;
    }

    .FontHoverColor:hover {
        color: #00C17E !important;
    }

    .NavBgColor {
        background-color: #00935F;
    }

    .NavHoverBgColor:hover {
        background-color: #01A46A;
    }

    .NavBorderColor1 {
        border-color: #00935F;
    }

    .CategoryBgColor {
        background-color: #00935F;
    }

    .PriceColor {
        color: #00935F;
    }

    .AddtoCartBgColor {
        background-color: #00935F;
    }

    .BuyNowBgColor {
        background-color: #00C17E;
    }

    .ReviewBgColor {
        background-color: #00935F;
    }

    .DiscountBgColor {
        background-color: #00935F;
    }

    .DiscountBorderColor {
        border-color: #00935F;
    }

    .ProListBgColor {
        background-color: #00C17E;
    }

    .ProListHoverBgColor:hover {
        background-color: #00935F;
    }

    .GoodBorderColor {
        border-color: #00C17E;
    }

    .GoodBorderHoverColor:hover {
        border-color: #00935F;
    }

    .GoodBorderColor.selected {
        border-color: #00935F;
    }

    .GoodBorderBottomHoverColor {
        border-bottom-color: #00935F;
    }
</style>
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
                            <a rel="nofollow" href="javascript:;" data="USD"><img src="<%=basePath%>picture/53092c531f.jpg"
                                                                                  alt="USD"/>USD</a>
                            <a rel="nofollow" href="javascript:;" data="EUR"><img src="<%=basePath%>picture/b355374c5e.jpg"
                                                                                  alt="EUR"/>EUR</a>
                            <a rel="nofollow" href="javascript:;" data="GBP"><img src="<%=basePath%>picture/f5e3cb314d.jpg"
                                                                                  alt="GBP"/>GBP</a>
                            <a rel="nofollow" href="javascript:;" data="CAD"><img src="<%=basePath%>picture/235af43e96.jpg"
                                                                                  alt="CAD"/>CAD</a>
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
                    <li class="fr border_r"><a href="<%=basePath%>user/toMember_index.htm">My Account</a></li>
                </c:if>
            </ul>
        </div>
    </div>

    <div class="FontBgColor">
        <div class="wide">
            <div class="logo fl"><h1><a href="<%=basePath%>login/view"><img src="picture/logo.png" alt="lywebsite"/></a>
            </h1></div>
            <div class="intro fr">
                <div class="intro_info fl"> | <a href="about.htm">Contact Us</a></div>
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
                <a href="about.htm" class="navlink NavHoverBgColor NavBorderColor1">About Us</a>
            </div>
            <div class="item fl">
                <a href="<%=basePath%>part/prolist" class="navlink NavHoverBgColor NavBorderColor1">Products</a>
            </div>
            <div class="item fl">
                <a href="about.htm" class="navlink NavHoverBgColor NavBorderColor1">Equipment</a>
            </div>
            <div class="item fl">
                <a href="about.htm" class="navlink NavHoverBgColor NavBorderColor1">Culture</a>
            </div>
            <div class="item fl">
                <a href="about.htm" class="navlink NavHoverBgColor NavBorderColor1">Honor</a>
            </div>
            <div class="item fl">
                <a href="about.htm" class="navlink NavHoverBgColor NavBorderColor1">Quality</a>
            </div>
            <div class="item fl">
                <a href="about.htm" class="navlink NavHoverBgColor NavBorderColor1">Contact Us</a>
            </div>
        </div>
    </div>
</div>
<div id="main" class="wide">
    <div class="blank20"></div>
    <div class="side_left fl">
        <div class="help_menu">
            <div class="help_title">About Us</div>
            <ul class="help_list">
                <li><a class="current FontColor" hidefocus="true" href="about.htm">About Us</a></li>
                <li><a hidefocus="true" href="about.htm">Equipment</a></li>
                <li><a hidefocus="true" href="about.htm">Culture</a></li>
                <li><a hidefocus="true" href="about.htm">Honor</a></li>
                <li><a hidefocus="true" href="about.htm">Quality</a></li>
                <li><a hidefocus="true" href="about.htm">Contact Us</a></li>
            </ul>
            <div class="help_title">Overview</div>
            <ul class="help_list">
                <li><a hidefocus="true" href="about.htm">PAYMENT METHODS</a></li>
                <li><a hidefocus="true" href="about.htm">SHIPPING &amp; RETURNS</a></li>
                <li><a hidefocus="true" href="about.htm">Location &amp; Working Hours</a></li>
            </ul>
        </div>
    </div>
    <div class="side_right fr right_main">
        <div class="main_title">About Us</div>
        <div class="main_content editor_txt">About Us</div>
    </div>
    <div class="blank25"></div>
</div>

<div id="footer">
    <div class="foot wide clean">
        <div class="foot_menu fl">
            <div class="foot_menu_hd">About Us</div>
            <ul class="list">
                <li><a href="about.htm"><em></em>About Us</a></li>
                <li><a href="<%=basePath%>part/prolist"><em></em>Products</a></li>
                <li><a href="about.htm"><em></em>Equipment</a></li>
                <li><a href="about.htm"><em></em>Honor</a></li>
                <li><a href="about.htm"><em></em>Contact Us</a></li>
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
                <li><a href="about.htm">PAYMENT METHODS</a></li>
                <li><a href="about.htm">SHIPPING &amp; RETURNS</a></li>
                <li><a href="about.htm">Location &amp; Working Hours</a></li>
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
            <a href="javascript:void(0);" target="_blank" style="margin:0 5px;"><img src="picture/06e4596004.png"
                                                                                     alt="2"/></a>
            <a href="javascript:void(0);" target="_blank" style="margin:0 5px;"><img src="picture/a42c34df2c.png"
                                                                                     alt="3"/></a>
            <a href="javascript:void(0);" target="_blank" style="margin:0 5px;"><img src="picture/84b60e7538.png"
                                                                                     alt="4"/></a>
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

<!-- 站长统计 -->
<script type="text/javascript">
    var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");
    document.write(unescape("%3Cspan id='cnzz_stat_icon_1265895728'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s22.cnzz.com/z_stat.php%3Fid%3D1265895728%26show%3Dpic' type='text/javascript'%3E%3C/script%3E"));
</script>
</body>
</html>