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
    <meta name="keywords" content="PET STORE"/>
    <meta name="description" content="PET STORE"/>
    <title>PET STORE</title>
    <link href='<%=basePath%>css/global.css' rel='stylesheet' type='text/css'/>
    <link href='<%=basePath%>css/global_1.css' rel='stylesheet' type='text/css'/>
    <link href='<%=basePath%>css/user.css' rel='stylesheet' type='text/css'/>
    <link href='<%=basePath%>css/style.css' rel='stylesheet' type='text/css'/>
    <script type='text/javascript' src='<%=basePath%>js/jquery-1.7.2.min.js'></script>
    <script type='text/javascript' src='<%=basePath%>js/en.js'></script>
    <script type='text/javascript' src='<%=basePath%>js/global.js'></script>
    <script type='text/javascript' src='<%=basePath%>js/user.js'></script>
    <script type='text/javascript' src='<%=basePath%>js/main.js'></script>

    <!-- layer -->
    <script type="text/javascript" src="<%=basePath%>js/layer.js" ></script>

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


<script type="text/javascript">
    function paypal2() {
        var url = "<%=basePath%>order/gotopay";
        //uuid acount userid
        var user_id="";
        user_id=${sessionScope.user.id};    //ok
        if(user_id==null || user_id.length<=0)
        {
            return false;
        }
        //var account=$("#all_price").text();//ok
        var account="";
        account=${order.allprice};
        if(account==null || account=="")
        {
            return false;
        }

        var uuid=$("#order_uuid").text();//ok
        var dates='{"user_id":"'+user_id+'","account":"'+account+'","uuid":"'+uuid+'"}';
        $.ajax({
            type : 'POST',
            contentType : 'application/json; charset=UTF-8',
            url : url,
            data : dates,
            dataType : 'html',
            success: function (data) {
                if(data=="" || data==null)
                {
                    return false;
                }
                else
                {
                    layer.open({
                        type : 1,  //获取页面层信息
                        skin : "layui-layer-molv",
                        border : [1],
                        area : ['43%','70%'],
                        content : data    //把result转为jQuery对象
                    });
                }

            },
            error: function () {
                alert("请求失败");
            }
        })

    }

    $(document).ready(function() {

        $("#to_pay").click(function () {
            alert("立刻跳转到支付页面");
            paypal2();
        });

        $("#to_pay1").click(function () {
            alert("立刻跳转到支付页面");
            paypal2();
        });

    })

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
                            <dt><a rel="nofollow" href="<%=basePath%>user/toMember_index" class="FontColor"><span>${sessionScope.user.nickname}</span></a>
                            </dt>
                            <dd class="user">
                                <a rel="nofollow" href="<%=basePath%>member_orders.htm">My Orders</a>
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
<div id="main" class="wide">
    <div id="lib_user" class="clearfix">
        <div id="lib_user_crumb" class="widget">
            <ul class="crumb_box clearfix">
                <li class="home"><a href="<%=basePath%>login/view" title="Home">Home<i></i></a></li>
                <li class="crumb2 root"><a href="<%=basePath%>user/toMember_index">My Account<i></i></a></li>
            </ul>
        </div>
        <div id="lib_user_menu">
            <h3 class="title">My Account</h3>
            <ul>
                <li><a href="<%=basePath%>user/toMember_index">Basic Information</a></li>
                <li><a href="<%=basePath%>member_orders_list.htm">My Orders</a></li>
                <li><a href="<%=basePath%>member_favorite.htm">My Favorite</a></li>
                <li><a href="<%=basePath%>address/AddressEdit">Manage Address Book</a></li>
                <li><a href="<%=basePath%>member_sysinfo_list.htm">System Message</a></li>
                <li><a href="<%=basePath%>login/view">Sign Out</a></li>
            </ul>
        </div>
        <div id="lib_user_main">
            <script type="text/javascript">$(document).ready(function () {
                user_obj.order_init()
            });</script>
            <div class="order_body">
                <div class="order_base">
                    <table class="fl" cellpadding="3">
                        <tr>
                            <th>Order Number:</th>
                            <td id="order_uuid">${order.uuid}</td>
                        </tr>
                        <tr>
                            <th>Order Date:</th>
                            <td>${order.ordertime.toLocaleString()}</td>
                        </tr>
                        <tr>
                            <th>Order Status:</th>
                            <td>
                                <strong>
                                    <c:choose>
                                        <c:when test="${order.paystatus==0}">
                                            <a id="to_pay1" href="javascript:void(0);">Awaiting Payment</a>

                                        </c:when>
                                        <c:when test="${order.paystatus==1 && order.shopstatus==0}">
                                            Awaiting Delivery
                                        </c:when>
                                        <c:when test="${order.paystatus==1 && order.shopstatus==1}">
                                            Awaiting Receipt
                                        </c:when>
                                        <c:when test="${order.paystatus==1 && order.shopstatus==2}">
                                            Awaiting Evaluate
                                        </c:when>
                                        <c:when test="${order.paystatus==1 && order.shopstatus==3}">
                                            Evaluation Completion
                                        </c:when>
                                        <c:when test="${order.paystatus==2}">
                                            Order Cancel
                                        </c:when>
                                    </c:choose>
                                </strong>
                            </td>
                        </tr>
                        <tr>
                            <th>Shipped To:</th>
                            <td><strong>${address.zip}</strong>
                                ${address.area}&nbsp;/&nbsp;${address.detail}
                            </td>
                        </tr>
                        <tr>
                            <th></th>
                            <td>Phone:${address.phone}</td>
                        </tr>
                        <tr>
                            <th></th>
                            <td>Tel:${address.tel}</td>
                        </tr>
                        <tr>
                            <th>Shipping Method:</th>
                            <td>DHL</td>
                        </tr>
                        <tr>
                            <th>Logistics info:</th>
                            <td><strong>${log}</strong>

                            </td>
                        </tr>
                        <tr>
                            <th>Payment Method:</th>
                            <td>Paypal<br><a class="order_btn edit_pay_btn" href="javascript:;" oid="17091217094179"
                                             pid="1">Edit payment method</a></td>
                        </tr>
                    </table>
                    <div class="order_view fr">
                        <a class="order_btn payment2btn" href="javascript:void(0);" target="_blank"
                           title="Go to Paypal and complete your payment.">Complete Your Payment</a>
                        <a class="order_btn" href="javascript:void(0);">Delete this order</a>
                        <br/>
                        <a class="order_btn" href="javascript:void(0);" target="_blank">Print Order</a>
                        <br/>
                        <a class="order_btn" href="javascript:void(0);">Contact</a>
                    </div>
                    <div class="clear"></div>
                    <form id="paypal_checkout_form" name="paypal_checkout_form" method="POST"
                          action="/cart/complete/17091217094179.html" class="hide">
                        <input id="paypal_payment_option" value="paypal_express" type="radio" name="paymentMethod"
                               title="PayPal Checkout" class="radio" style="display:none;" checked/>
                        <input type="submit" value="Submit" id="paypal_checkout_button"/>
                    </form>
                    <script src="<%=basePath%>js/checkout.js" async></script>
                    <script>
                        window.paypalCheckoutReady = function () {
                            paypal.checkout.setup("320006220@qq.com", {
                                button: "paypal_checkout_button",
                                environment: "production",
                                condition: function () {
                                    return document.getElementById("paypal_payment_option").checked === true;
                                }
                            });
                        };
                    </script>
                </div>
                <div class="order_menu order_status">
                    <h3>Order Status</h3>
                    <table cellpadding="0" cellspacing="0" width="100%" class="row_table">
                        <thead>
                        <tr>
                            <th width="25">&nbsp;</th>
                            <th width="300">Date / Time</th>
                            <%--<th width="100">Time</th>--%>
                            <th>Status</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>&nbsp;</td>
                            <td>${order.ordertime.toLocaleString()}</td>
                            <%--<td>05:09 PM</td>--%>
                            <td>
                                <c:choose>
                                    <c:when test="${order.paystatus==0}">
                                        <a id="to_pay" href="javascript:void(0);">Awaiting Payment</a>
                                    </c:when>
                                    <c:when test="${order.paystatus==1 && order.shopstatus==0}">
                                        Awaiting Delivery
                                    </c:when>
                                    <c:when test="${order.paystatus==1 && order.shopstatus==1}">
                                        Awaiting Receipt
                                    </c:when>
                                    <c:when test="${order.paystatus==1 && order.shopstatus==2}">
                                        Awaiting Evaluate
                                    </c:when>
                                    <c:when test="${order.paystatus==1 && order.shopstatus==3}">
                                        Evaluation Completion
                                    </c:when>
                                    <c:when test="${order.paystatus==2}">
                                        Order Cancel
                                    </c:when>
                                </c:choose>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="order_menu order_summary">
                    <h3>Order Summary</h3>
                    <div class="waybill_products_list">
                        <div class="row_hd">
                            <strong>Ships From: China</strong>
                            <span>Status: Awaiting Shipping</span>
                        </div>
                        <table cellpadding="0" cellspacing="0" width="100%" class="row_table">
                            <thead>
                            <tr>
                                <th>Item (1709121709417900)</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Amount</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${goodslist}">
                                <tr>
                                    <td class="pro_list">
                                        <dl class="clearfix">
                                            <dt><a href="<%=basePath%>goods/NewGoodsDetail/${item.get("goodsid")}" target="_blank"><img src="<%=basePath%>image/show?pic=${item.get("title")}"></a></dt>
                                            <dd>
                                                <h4><a href="<%=basePath%>goods/NewGoodsDetail/${item.get("goodsid")}" target="_blank">${item.get("goodsname")}</a></h4>
                                                <p class="pro_attr">${item.get("goodsid")}</p>
                                                <p class="pro_attr">format:${item.get("fname")}</p>
                                            </dd>
                                        </dl>
                                    </td>
                                    <td class="pro_price"><span>${item.get("price")}</span></td>
                                    <td class="pro_qty">${item.get("amount")}</td>
                                    <td class="pro_amount"><span>${item.get("amount")*item.get("price")}</span></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="2"></td>
                                <td>${goodslist.size()}</td>
                                <td>${total}</td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
                <div class="grand_total">
                    <table cellpadding="0" cellspacing="0">
                        <tbody>
                        <tr>
                            <th>Subtotal (${goodslist.size()} Item):<em>USD</em></th>
                            <td>${total}</td>
                        </tr>
                        <tr>
                            <th>Shipping Charges & Insurance:<em>USD</em></th>
                            <td>${freight}</td>
                        </tr>
                        <tr>
                            <td colspan="2"></td>
                        </tr>
                        </tbody>
                        <tfoot>
                        <tr>
                            <th width="100%" class="totalprod">Grand Total:<em>USD</em></th>
                            <td class="totalPrice" id="all_price">${order.allprice}</td>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="footer">
    <div class="foot wide clean">
        <div class="foot_menu fl">
            <div class="foot_menu_hd">About Us</div>
            <ul class="list">
                <li><a href="<%=basePath%>about.htm"><em></em>About Us</a></li>
                <li><a href="<%=basePath%>pro_list.jsp"><em></em>Products</a></li>
                <li><a href="<%=basePath%>about.htm"><em></em>Equipment</a></li>
                <li><a href="<%=basePath%>about.htm"><em></em>Honor</a></li>
                <li><a href="<%=basePath%>about.htm"><em></em>Contact Us</a></li>
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
                <li><a href="<%=basePath%>about.htm">PAYMENT METHODS</a></li>
                <li><a href="<%=basePath%>about.htm">SHIPPING &amp; RETURNS</a></li>
                <li><a href="<%=basePath%>about.htm">Location &amp; Working Hours</a></li>
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
            <a href="javascript:void(0);" target="_blank" style="margin:0 5px;"><img src="<%=basePath%>picture/06e4596004.png"
                                                                                     alt="2"/></a>
            <a href="javascript:void(0);" target="_blank" style="margin:0 5px;"><img src="<%=basePath%>picture/a42c34df2c.png"
                                                                                     alt="3"/></a>
            <a href="javascript:void(0);" target="_blank" style="margin:0 5px;"><img src="<%=basePath%>picture/84b60e7538.png"
                                                                                     alt="4"/></a>
        </div>
        <div class="cp fr copyright"> &nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0);" target="_blank">POWERED BY
            SZJIDING</a></div>
    </div>
</div>


</body>
</html>