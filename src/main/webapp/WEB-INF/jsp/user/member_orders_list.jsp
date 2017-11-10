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

    <script type="text/javascript">
        $(function(){
            //alert("x");
            $.ajax({
                type : 'POST',
                contentType : 'application/json;charset=UTF-8',
                url : 'order/mOrderList',
                data : '{}',
                dataType : 'json',
                success : function(jsonDate) {
                    console.log( '当前页码'+eval(jsonDate).pageNo );
                    console.log( '当页条目'+eval(jsonDate).pageSize );
                    console.log( '总页数'+eval(jsonDate).pages );
                    console.log( '总条目'+eval(jsonDate).total );
                    console.log(jsonDate);
                    dealJson(jsonDate);
                    afterLoad();
                },
                error : function(data) {
                    alert("错误!")
                }
            });

            //直接选择分类
            $(".choose_type").click(function () {
                var s=$(this).attr("name");
                $("#status").val(s);
                $(".choose_type").removeClass("current");
                $(this).addClass("current");
                //console.log(s);
                $("#pageNo").val(1);
                getOrder(null);
            });

        });

        //处理json
        function dealJson(jsonDate) {
            $("#list_body").empty();
            $("#turn_page").empty();
            var html='';
            var html2='';
            html2+='<li class="page_last"><a href="javascript:void(0);" id="pre" class="page_button" name="p">Previous<em class="icon_page_prev"></em></a></li>';
            $.each(jsonDate.dataList, function(i, row){
                i=i+1;
                var show='';
                if(row.paystatus == 0 )
                {
                    show='未付款';
                }
                if( row.paystatus == 1 && row.shopstatus == 0 )
                {
                    show='未发货';
                }
                if( row.paystatus == 1 && row.shopstatus == 1 )
                {
                    show='未收货';
                }
                if( row.paystatus == 1 && row.shopstatus == 2 )
                {
                    show='未评价';
                }
                if( row.paystatus == 1 && row.shopstatus == 3 )
                {
                    show='已完成';
                }
                if( row.paystatus == 2 )
                {
                    show='已取消';
                }
                html+='<tr class="odd">'+'<td>'+row.ordertime+'</td>'+'<td><a class="order_info" href="<%=basePath%>order/mOrder/' + row.uuid
                    + '" title="' + row.uuid+'">' + row.uuid + '</a></td>'+ '<td>USD $' + row.allprice + '</td><td><strong>' + show
                    + '</strong></td>' + '<td><a class="order_info" href="<%=basePath%>order/mOrder/' + row.uuid + '">View Details</a>&nbsp;&nbsp;'
                    + '<a class="order_info" href="<%=basePath%>order/mOrder/' + row.uuid + '" target="_blank">PrintOrder</a>&nbsp;&nbsp;'
                    + '<a class="order_info" href="<%=basePath%>order/mOrder/' + row.uuid + '">Contact</a></td></tr>';
                //console.log(html);
//                html2+='<li><font class="page_item_current" id="btn_page'+i+'" name="'+i+'">'+i+'</font></li>';
            });
            //分页按钮
            for (var i=1 ; eval(jsonDate).pages >= i ; i++  )
            {
                if( i==eval(jsonDate).pageNo )
                {
                    html2+='<li><font class="page_item_current">'+i+'</font></li>';
                }
                else
                {
                    html2+='<li><a href="javascript:void(0);" name="'+i+'" class="page_item">'+i+'</a></li>';
                }
            }

            html2+='<li class="page_last"><a href="javascript:void(0);" id="next" class="page_button" name="n">Next<em class="icon_page_next"></em></a></li>';
            html2+='<input type="hidden" id="pageNo" name="pageNo" value="'+eval(jsonDate).pageNo+'">';
            html2+='<input type="hidden" id="pageSize" name="pageSize" value="'+eval(jsonDate).pageSize+'">';
            html2+='<input type="hidden" id="pages" name="pages" value="'+eval(jsonDate).pages+'">';
            html2+='<input type="hidden" id="total" name="total" value="'+eval(jsonDate).total+'">';
            html2+='<input type="hidden" id="status" name="status" value="-1">';
            if(! jsonDate.dataList.length>0)
            {
                html2='empty';
            }
            $("#list_body").html(html);
            $("#turn_page").html(html2);
        }

        //绑定事件
        function afterLoad()
        {
            //alert("after");
            $(function() {
                //前进/后退
                $(".page_button").click(function () {
                    if( $(this).attr("name")=="p" ) //前页
                    {
//                        var pageNo=$("#pageNo").val();
//                        pageNo=pageNo-1;
//                        if(pageNo>=1)
//                        {
//                            console.log(pageNo);
//                            getOrder(pageNo);
//                        }
                        getOrder(null,"p");
                        //alert("p");
                        //toGetGoods(1,null,null,null);
                    }
                    else if($(this).attr("name") == "n")//后页
                    {
//                        var pageNo=$("#pageNo").val();
//                        var pages=$("#pages").val();
//                        pageNo=pageNo+1;
//                        if(pages>=pageNo)
//                        {
//                            console.log(pageNo);
//                            getOrder(pageNo);
//                        }
                        getOrder(null,"n");
                        //alert("n");
                        //toGetGoods(2,null,null,null);
                    }
                });
                //页码选择
                $(".page_item").click(function () {
                    var pageNo=$(this).attr("name");
                    //toGetGoods(3,null,null,pageNo);
                    getOrder(pageNo,null);
                });

            })
        }

        //发送后续ajax
        function getOrder(pageNo,oper) {
            if(pageNo==null)
            {
                pageNo= $("#pageNo").val();
            }
            var pageSize=$("#pageSize").val();
            var pages=$("#pages").val();
            var total=$("#total").val();
            var type=$("#status").val();
            if(oper=="p")
            {
                if(pageNo>1)
                {
                    pageNo=parseInt(pageNo)-1;
                }
                else {
                    return false;
                }
            }
            else if(oper=="n")
            {
                if(pages>pageNo)
                {
                    pageNo=parseInt(pageNo)+1;
                }
                else {
                    return false;
                }
            }
            var dates='';
            dates+='{'
            dates+='"pageNo":"'+pageNo+'","pageSize":"'+pageSize+'","type":"'+type+'"';
            dates+='}';
            $.ajax({
                type : 'POST',
                contentType : 'application/json;charset=UTF-8',
                url : 'order/mMoreOrderList',
                data : dates,
                dataType : 'json',
                success : function(jsonDate) {
                    console.log(jsonDate);
                    dealJson(jsonDate);
                    afterLoad();
                },
                error : function(data) {
                    alert("错误!")
                }
            });

        }

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
            <h1 class="lib_user_title">My Orders</h1>
            <dl class="orders_status_list">
                <dd><a href="javascript:void(0);" status="0" class="current choose_type" name="-1">All</a></dd>
                <dt></dt>
                <dd><a href="javascript:void(0);" status="1" class="choose_type" name="0">Awaiting Payment</a></dd>
                <dt></dt>
                <%--<dd><a href="/account/orders/?OrderStatus=2" status="2">Awaiting Confirm Payment</a></dd>--%>
                <%--<dt></dt>--%>
                <%--<dd><a href="/account/orders/?OrderStatus=3" status="3">Payment Wrong</a></dd>--%>
                <%--<dt></dt>--%>
                <dd><a href="javascript:void(0);" status="4" class="choose_type" name="1">Awaiting Shipping</a></dd>
                <dt></dt>
                <dd><a href="javascript:void(0);" status="5" class="choose_type" name="2">Shipment Shipped</a></dd>
                <dt></dt>
                <dd><a href="javascript:void(0);" status="6" class="choose_type" name="3">Received</a></dd>
                <dt></dt>
                <dd><a href="javascript:void(0);" status="7" class="choose_type" name="4">Cancelled</a></dd>
            </dl>
            <table id="lib_user_order" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <th width="110">Order Date</th>
                    <th width="110">Order Number</th>
                    <th width="90">Order Total</th>
                    <th width="150">Order Status</th>
                    <th width="180">Action</th>
                </tr>
                <tbody id="list_body">
                    <tr class="odd">
                        <td>Sep 12, 2017</td>
                        <td><a class="order_info" href="member_orders.htm" title="17091217094179">17091217094179</a></td>
                        <td>USD $65.44</td>
                        <td><strong>Awaiting Payment</strong></td>
                        <td><a class="order_info" href="member_orders.htm">View Details</a>&nbsp;&nbsp;
                            <a class="order_info" href="member_orders.htm" target="_blank">PrintOrder</a>&nbsp;&nbsp;
                            <a class="order_info" href="member_orders.htm">Contact</a></td>
                    </tr>
                </tbody>
            </table>
            <div class="blank20"></div>
            <div id="turn_page">
                <li><font class='page_noclick'><em class='icon_page_prev'></em>Previous</font></li>
                <li><font class='page_item_current'>1</font></li>
                <li class='page_last'><font class='page_noclick'>Next<em class='icon_page_next'></em></font></li>
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

</body>
</html>