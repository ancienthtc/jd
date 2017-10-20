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
    <noscript><img height="1" width="1" style="display:none" src="picture/3116590b319d4b2c985af27b0a41f20b.gif"/>
    </noscript>
    <!-- End Facebook Pixel Code -->
    <link href='css/cart.css' rel='stylesheet' type='text/css'/>
    <script type='text/javascript' src='js/cart.js'></script>
    <script type='text/javascript' src='js/tool_tips_web.js'></script>
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
        "date": "2017/09/13 17:40:34",
        "lang": "en",
        "currency": "USD",
        "currency_symbols": "$",
        "currency_rate": "1.0000",
        "FbAppId": "1594883030731762",
        "FbPixelOpen": "1",
        "UserId": "0",
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
                            <a rel="nofollow" href="javascript:;" data="USD"><img src="picture/53092c531f.jpg"
                                                                                  alt="USD"/>USD</a>
                            <a rel="nofollow" href="javascript:;" data="EUR"><img src="picture/b355374c5e.jpg"
                                                                                  alt="EUR"/>EUR</a>
                            <a rel="nofollow" href="javascript:;" data="GBP"><img src="picture/f5e3cb314d.jpg"
                                                                                  alt="GBP"/>GBP</a>
                            <a rel="nofollow" href="javascript:;" data="CAD"><img src="picture/235af43e96.jpg"
                                                                                  alt="CAD"/>CAD</a>
                        </dd>
                    </dl>
                </li>
                <li class="block fl border_r sign">
                    <dl>
                        <dt><a rel="nofollow" href="javascript:;" class="SignInButton FontColor">Sign In</a> or <a
                                rel="nofollow" href="register.htm" class="FontColor">Join Free</a></dt>
                        <dd class="login">
                            <script type='text/javascript' src='js/facebook.js'></script>
                            <div id="fb_button" scope="public_profile, email" onclick="checkLoginState();"
                                 class="fb_button" appid="1594883030731762">
                                <i></i>
                                <span>Log In with Facebook</span>
                                <em></em>
                            </div>
                            <script type='text/javascript' src='js/google.js'></script>
                            <div id="google_btn" class="google_button"
                                 clientid="640892902807-64ev2hjtu0141m7lsn9k15mfm9b5nak5.apps.googleusercontent.com">
                                <span class="icon"></span>
                                <span class="button_text">Login with Google +</span>
                            </div>
                            <script type='text/javascript' src='js/api.js'></script>
                            <div id="paypalLogin" appid="AXaj3xAfsUrUujWbtErMA7ElMc6gEeou8TMJMibnisJR21oFmbZ-4eCrvx5d"
                                 u="http://13660272395.myueeshop.com/?do_action=user.user_oauth&Type=Paypal"></div>
                        </dd>
                    </dl>
                    <script type="text/javascript">
                        $(document).ready(function () {
                            user_obj.sign_in_init();
                        });
                    </script>
                </li>
                <li class="fr border_r"><a href="member_favorite.htm">Wish List</a></li>
                <li class="fr border_r"><a href="member_index.htm">My Account</a></li>
            </ul>
        </div>
    </div>
    <div class="FontBgColor">
        <div class="wide">
            <div class="logo fl"><h1><a href="index.htm"><img src="picture/logo.png" alt="lywebsite"/></a></h1></div>
            <div class="intro fr">
                <div class="intro_info fl"> | <a href="about.htm">Contact Us</a></div>
                <a class="cart_inner fl header_cart" href="member_cart.htm"><span class="cart_count">0</span></a>
            </div>
            <div class="search fr NavBgColor">
                <form action="search.htm" method="get" class="form">
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
                <a href="index.htm" class="navlink NavHoverBgColor NavBorderColor1">HomePage</a>
            </div>
            <div class="item fl">
                <a href="about.htm" class="navlink NavHoverBgColor NavBorderColor1">About Us</a>
            </div>
            <div class="item fl">
                <a href="pro_list.jsp" class="navlink NavHoverBgColor NavBorderColor1">Products</a>
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
    <script type="text/javascript">$(document).ready(function () {
        cart_obj.cart_list()
    });</script>
    <div id="lib_cart">
        <div class="cartBox">
            <h2>Shopping Cart</h2>
            <div class="contents empty">
                <h3>Your shopping cart is empty.</h3>
                <div class="cartDraft">Looking for your items?<br/>Since you weren't able to complete your order, we've
                    saved it as a draft order. <a href="index.htm">Click here</a> to go to My Orders where you can view
                    and complete your draft order.
                </div>
                <ul>
                    <li><span class="roundRedDot">•</span> You have the power to change this!</li>
                    <li><span class="roundRedDot">•</span> Once you start filling your shopping cart, we'll show you all
                        the special offers that we have in store just for you!
                    </li>
                </ul>
                <p><a name="continue_shopping" class="continueShoppingBtn" title="Continue Shopping"><b>Continue
                    Shopping</b></a></p>
            </div>
        </div>
    </div>
</div>

<div id="footer">
    <div class="foot wide clean">
        <div class="foot_menu fl">
            <div class="foot_menu_hd">About Us</div>
            <ul class="list">
                <li><a href="about.htm"><em></em>About Us</a></li>
                <li><a href="pro_list.jsp"><em></em>Products</a></li>
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


</body>
</html>