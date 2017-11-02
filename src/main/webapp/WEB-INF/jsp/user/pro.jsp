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

    <script type="text/javascript">

//        var radio = document.getElementById("test").getElementsByTagName("li");
//        var text = document.getElementById("text");
//        var submit = document.getElementById("buynow_button");
//        submit.onclick = function(){
//            for(var i=0;i<radio.length;i++){
//                if(radio[i].checked){
//                    text.value = radio[i].value;
//                }
//            }
//        }


        $(document).ready(function(){
            <!-- 加和减 -->
            //数量+
            $("#btn_add").click(function () {
                var a=$("#quantity").val();
                //alert(a);
                a=parseInt(a)+1;
                if(a>10)
                {
                    return;
                }
                else
                {
                    $("#quantity").val(a);
                }

            });
            //数量-
            $("#btn_cut").click(function () {
                var a = $("#quantity").val();
                a=parseInt(a)-1;
                if (0 >= a) {
                    a=parseInt(a)+1;
                    return;
                }
                else
                {
                    $("#quantity").val(a);
                }
            });

            //添加到购物车
            $("#addtocart_button").click(function () {
                var count=$("#quantity").val();

                var userid;
                if( $("#uid").val() == null || $("#uid").val().length<=0 || $("#uid").val()=="undefined" )
                {
                    check_login();
                    return false;
                }
                else
                {
                    userid=$("#uid").val();
                }

                var goodsid=$("#goodsid").val();
                //选中的价格
                var tprice=$("#cur_price").text();
                //规格id  formatid
                var fid=$("#test").find(".active").attr("name");
                //var fname;
                if(fid=="a")
                {
                    fid="null";
                }

                if(userid.length<=0)
                {
                    userid='null';
                }
                if(goodsid.length<=0)
                {
                    goodsid='null';
                }
                var date='{count:'+count+',userid:'+userid+',goodsid:'+goodsid+',tprice:'+tprice+',fid:'+fid+'}';
                $.ajax( {
                    type : 'POST',
                    contentType : 'application/json',
                    url : '<%=basePath%>cart/add',
                    data : date,
                    dataType : 'json',
                    success : function(data) {
                        //alert(data);
                        if(data==false)
                        {
                            alert("添加失败!");
                        }
                        else if(data==true)
                        {
                            alert("添加成功!");
                        }

                    },
                    error : function(data) {
                        alert("错误!")
                    }
                });
            });

            $("#buynow_button").click(function () {

                //userid , total=1
                //title=first title , gid , name , price=单价 , amount=选取个数 , gclass , all=amount*price , ciid*
                var userid;
                if( $("#uid").val() == null || $("#uid").val().length<=0 || $("#uid").val()=="undefined" )
                {
                    check_login();
                    return false;
                }
                else
                {
                    userid=$("#uid").val();
                }



                var title=$("#img1").attr("title");
                var gid='${goods.id}';
                var name='${goods.name}';
                var price=$("#cur_price").text();
                var amount=$("#quantity").val();//ok
                var gclass='${goods.gclass}';

                var total=price*amount;
                //var total=1;

                //规格参数
                var fid=$("#test").find(".active").attr("name");
                var fname=$("#test").find(".active").attr("fname");

                if(fid=="a")
                {
                    fid="null";
                }

                var all=amount*price;
                var json="";
                json=json+'{"goods":[';
                json=json+'{"title":"'+title+'","gid":"'+gid+'","name":"'+name+'","price":"'+price+'","amount":"'+amount+
                    '","gclass":"'+gclass+'","all":"'+all+'","ciid":null,"fid":"'+fid+'","fname":"'+fname+'"}';
                json=json+'],';
                json=json+'"userid":"'+userid+'","total":"'+total+'"';
                json=json+'}';

                console.log(json);
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


        })

        function check_login() {
            var user=$("#uid").val();
            if(user==null || user.length<=0)
            {
                alert("请先登录");
                <%--window.location.href='<%=basePath%>';--%>
//                window.navigate("jb51.jsp");
                <%--window.href="<%=basePath%>login/view";--%>
                //return false;
            }
        }



    </script>

    <noscript><img height="1" width="1" style="display:none"
                   src="<%=basePath%>picture/7be5419f895f46468831605c9de69b7c.gif"/></noscript>
    <!-- End Facebook Pixel Code -->
    <link href='<%=basePath%>css/lightbox.min.css' rel='stylesheet' type='text/css'/>
    <!-- Facebook Pixel Code -->
    <script type="text/javascript">
        <!--
        When
        a
        page
        viewed
        such as landing
        on
        a
        product
        detail
        page.-->
        fbq('track', 'ViewContent', {
            content_type: 'product',//产品类型为产品
            content_ids: ['084'],//产品ID
            content_name: 'Allied Precision 290 Deluxe Non-Heated Bird Bath with Pedestal, Beige (Discontinued by Manufacturer)',//产品名称
            value: 15,//产品价格
            currency: 'USD'//货币类型
        });

        <!-- When some adds a product to a shopping cart. -->
        $.fn.fbq_addtocart = function () {
            fbq('track', 'AddToCart', {
                content_type: 'product',//产品类型为产品
                content_ids: ['084'],//产品ID
                content_name: 'Allied Precision 290 Deluxe Non-Heated Bird Bath with Pedestal, Beige (Discontinued by Manufacturer)',//产品名称
                currency: 'USD'//货币类型
            });
        }
    </script>
    <!-- End Facebook Pixel Code -->
</head>

<body class="lang_en">
<input id="uid" value="${sessionScope.user.id}" type="hidden"/>
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

    .format_ {
        color: black;
        height: 40px;
        border: 1px solid #ddd;
        text-align: center;
        line-height: 40px;
        float: left;
        padding-left: 10px;
        padding-right: 10px;
        margin-left: 10px;
        margin-top: 10px;
    }

    .active{border: 1px solid red;}

</style>
<script type="text/javascript">
    $(window).resize(function () {
        $(window).webDisplay(0);
    });
    $(window).webDisplay(0);
    var ueeshop_config = {
        "domain": "http://szjiding.com",
        "date": "2017/09/13 17:55:28",
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
            <div class="logo fl"><h1><a href="<%=basePath%>login/view"><img src="<%=basePath%>picture/logo.png" alt="lywebsite"/></a>
            </h1></div>
            <div class="intro fr">
                <div class="intro_info fl"> | <a href="<%=basePath%>about.htm">Contact Us</a></div>
                <c:if test="${not empty sessionScope.user}">
                    <a class="cart_inner fl header_cart" href="<%=basePath%>cart/toCart/${sessionScope.user.id}"><span class="cart_count">1</span></a>
                </c:if>
                <c:if test="${empty sessionScope.user}">
                    <a class="cart_inner fl header_cart" href="<%=basePath%>login_register"><span class="cart_count">1</span></a>
                </c:if>
            </div>
            <div class="search fr NavBgColor">
                <form action="<%=basePath%>search.htm" method="get" class="form">
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
                <a href="<%=basePath%>about.htm" class="navlink NavHoverBgColor NavBorderColor1">About Us</a>
            </div>
            <div class="item fl">
                <a href="<%=basePath%>part/prolist" class="navlink NavHoverBgColor NavBorderColor1">Products</a>
            </div>
            <div class="item fl">
                <a href="<%=basePath%>about.htm" class="navlink NavHoverBgColor NavBorderColor1">Equipment</a>
            </div>
            <div class="item fl">
                <a href="<%=basePath%>about.htm" class="navlink NavHoverBgColor NavBorderColor1">Culture</a>
            </div>
            <div class="item fl">
                <a href="<%=basePath%>about.htm" class="navlink NavHoverBgColor NavBorderColor1">Honor</a>
            </div>
            <div class="item fl">
                <a href="<%=basePath%>about.htm" class="navlink NavHoverBgColor NavBorderColor1">Quality</a>
            </div>
            <div class="item fl">
                <a href="<%=basePath%>about.htm" class="navlink NavHoverBgColor NavBorderColor1">Contact Us</a>
            </div>
        </div>
    </div>
</div>
<div id="main" class="wide">
    <link href='<%=basePath%>css/module_4.css' rel='stylesheet' type='text/css'/>
    <div id="location">Your position: <a href="<%=basePath%>login/view">Home</a> &gt; <a href='<%=basePath%>part/prolist'>Products</a>
    </div>
    <div id="prod_detail">
        <div class="clearfix">


            <div class="detail_left fl prod_gallery_x" style="height: auto;">

                <c:if test="${not empty images}">
                    <img src="<%=basePath%>image/show?pic=${images.get(0).title}">
                    <input type="hidden" id="img1" title="${images.get(0).title}"/>
                </c:if>
                <c:if test="${empty images}">
                    <img src="<%=basePath%>image/show?pic=">
                    <input type="hidden" id="img1" title=""/>
                </c:if>
                <input type="hidden" id="user_id" value="${sessionScope.user.id}"/>
            </div>


            <div class="detail_right fr">
                <div class="widget prod_info_title"><h2 itemprop="name">${goods.name}</h2></div>
                <div class="widget prod_info_brief">${goods.part}</div>
                <div class="widget prod_info_number">Item Code: ${goods.id}</div>
                <div class="widget prod_info_review">
                    <span class="star star_s5"></span><a class="write_review review_count" href="#review_box">(10)</a><a
                        class="write_review track" href="javascript:void(0);">Write a review</a>
                    <div class="prod_info_share">
                        <div class="share_toolbox clearfix"
                             data-title="Allied Precision 290 Deluxe Non-Heated Bird Bath with Pedestal, Beige (Discontinued by Manufacturer)"
                             data-url="http://szjiding.com/allied-precision-290-deluxe-non-heated-bird-bath-with-pedestal-beige-discontinued-by-manufacturer_p0943.html">
                            <ul>
                                <li><a href="javascript:;" rel="nofollow" class="share_s_btn share_s_facebook"
                                       data="facebook">facebook</a></li>
                                <li><a href="javascript:;" rel="nofollow" class="share_s_btn share_s_twitter"
                                       data="twitter">twitter</a></li>
                                <li><a href="javascript:;" rel="nofollow" class="share_s_btn share_s_googleplus"
                                       data="googleplus">googleplus</a></li>
                                <li><a href="javascript:;" rel="nofollow" class="share_s_btn share_s_pinterest"
                                       data="pinterest">pinterest</a></li>
                                <li>
                                    <a href="javascript:;" rel="nofollow" class="share_s_btn share_s_more">More</a>
                                    <div class="share_hover">
                                        <a href="javascript:;" rel="nofollow" class="share_s_btn" id="linkedin"
                                           data="linkedin"><i class="share_s_linkedin"></i><span>linkedin</span></a>
                                        <a href="javascript:;" rel="nofollow" class="share_s_btn" id="vk" data="vk"><i
                                                class="share_s_vk"></i><span>vk</span></a>
                                        <a href="javascript:;" rel="nofollow" class="share_s_btn" id="google"
                                           data="google"><i class="share_s_google"></i><span>google</span></a>
                                        <a href="javascript:;" rel="nofollow" class="share_s_btn" id="digg" data="digg"><i
                                                class="share_s_digg"></i><span>digg</span></a>
                                        <a href="javascript:;" rel="nofollow" class="share_s_btn" id="reddit"
                                           data="reddit"><i class="share_s_reddit"></i><span>reddit</span></a>
                                        <a href="javascript:;" rel="nofollow" class="share_s_btn" id="stumbleupon"
                                           data="stumbleupon"><i
                                                class="share_s_stumbleupon"></i><span>stumbleupon</span></a>
                                        <a href="javascript:;" rel="nofollow" class="share_s_btn" id="delicious"
                                           data="delicious"><i class="share_s_delicious"></i><span>delicious</span></a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <b>Share this:</b></div>
                    <div class="prod_info_inquiry"><a class="product_inquiry" href="javascript:;" data-user="0"
                                                      data-proid="943">Have a question?</a></div>
                </div>
                <div class="widget prod_info_price">
                    <div class="widget price_left price_0">
                        <div class="price_info_title">Goods Sales:</div>
                        <del id="gsales">${goods.sales}</del>
                    </div>
                    <div class="widget price_left price_1">
                        <div class="price_info_title">Price:</div>
                        <div itemprop="offers" itemscope itemtype="http://schema.org/Offer" class="current_price">
                            <meta id="schemaorg_offer_price" itemprop="price" content="${goods.price}"/>
                            <meta id="schemaorg_offer_currency" itemprop="priceCurrency" content="USD"/>
                            <meta id="schemaorg_offer_availability" itemprop="availability" content="InStock"/>
                            <div class="left">
                                <dl class="widget prod_info_currency">
                                    <dt><a href="javascript:;">USD
                                        <div class="arrow"><em></em><i></i></div>
                                    </a></dt>
                                    <dd>
                                        <ul>
                                            <li><a href="javascript:;" data="USD">USD</a></li>
                                            <li><a href="javascript:;" data="EUR">EUR</a></li>
                                            <li><a href="javascript:;" data="GBP">GBP</a></li>
                                            <li><a href="javascript:;" data="CAD">CAD</a></li>
                                        </ul>
                                    </dd>
                                </dl>
                                <strong id="cur_price" class="price">${goods.price}</strong>
                            </div>
                            <div class="discount_price discount_attr fl">(<span>42% OFF</span>)</div>
                            <div class="clear"></div>
                            <div class="save_price">Goods Stock: <span class="save_p" id="save_p">${goods.stock}</span><span class="save_style">(42% Off)</span>
                            </div>
                        </div>
                    </div>
                    <a class="prod_info_pdf" href="javascript:;"><em class="icon_pdf"></em>PDF Format</a>
                </div>
                <div class="guige">
                    <span>specifications:</span>

                    <!-- 规格参数 -->
                    <%--<div class="moren" id="test">--%>
                        <%--<div class="format_ active" value="1" >default</div>--%>
                        <%--<div class="format_" value="2">defaultdefaultdefaultdefaultdefaultdefault</div>--%>
                        <%--<div class="format_" value="3">defaultrtreter</div>--%>
                    <%--</div>--%>

                    <ul id="test">
                        <c:forEach var="item" items="${formats}">

                            <c:if test="${empty item.id}">
                                <li class="format_ " name="a" fname="${item.fname}" >${item.fname}</li>
                                <input type="hidden" id="gid" value="${goods.id}">
                            </c:if>
                            <c:if test="${not empty item.id}">
                                <li class="format_ " name="${item.id}" fname="${item.fname}" >${item.fname}</li>
                            </c:if>

                        </c:forEach>
                    </ul>


                </div>

                <form class="prod_info_form" name="prod_info_form" id="goods_form" action="/cart/add.html" method="post"
                      target="_blank">
                    <ul class="widget attributes" default_selected="0" data-combination="1">
                        <div class="attr_sure">
                            <span class="attr_sure_choice">Please select the information you want</span><span
                                class="attr_sure_close">X</span>
                        </div>

                        <li class="attr_show" name="Ships From" style="display:none;">
                            <h5>Ships From:</h5>
                            <span value="Ov:1"
                                  data="{&quot;Price&quot;:0,&quot;Qty&quot;:0,&quot;Weight&quot;:0,&quot;SKU&quot;:,&quot;IsIncrease&quot;:0}"
                                  class="GoodBorderColor GoodBorderHoverColor" title="China">
							<em class="icon_selected"></em>
							<em class="icon_selected_bg GoodBorderBottomHoverColor"></em>
							China
							</span>
                            <input type="hidden" name="id[Overseas]" id="attr_Overseas" attr="Overseas" value=""
                                   class="attr_value"/>
                        </li>
                    </ul>
                    <div class="widget key_info_line">
                        <div class="key_info_left">Shipping Cost:</div>
                        <div class="key_info_right">
                            <div class="shipping_cost_detail">
                                <span class="shipping_cost_price"></span>
                                <span class="shipping_cost_to">to</span>
                                <span id="shipping_flag" class="icon_flag"></span>
                                <span id="shipping_cost_button" class="shipping_cost_button FontColor"></span>
                            </div>
                            <div class="shipping_cost_info">Estimated Delivery Time:<span class="delivery_day"></span>
                            </div>
                            <div class="shipping_cost_error">Please select the country you want to ship from</div>
                        </div>
                    </div>
                    <div class="widget prod_info_quantity">
                        <label for="quantity">Quantity:</label>
                        <div class="quantity_box" data="{&quot;min&quot;:1,&quot;max&quot;:16,&quot;count&quot;:1}">
                            <input id="quantity" class="qty_num" name="Qty" autocomplete="off" type="text" value="1"
                                   stock="16"/></div>
                        <div class="qty_box">
                            <div id="btn_add">+</div>
                            <div id="btn_cut">-</div>
                        </div>
                        <span>Units</span>
                        <div class="clear"></div>
                    </div>
                    <div class="widget prod_info_actions">
                        <%--<input type="submit" value="Add to Cart" class="add_btn addtocart AddtoCartBgColor" id="addtocart_button"/>--%>
                        <input type="button" value="Add to Cart" class="add_btn " onclick="javascript:void(0);" id="addtocart_button"/>
                        <%--<input type="button" value="Buy Now" class="add_btn buynow BuyNowBgColor" id="buynow_button"/>--%>
                        <input type="button" value="Buy Now" class="add_btn " onclick="javascript:void(0);" id="buynow_button"/>
                        <input type="hidden" value="${goods.id}" id="goodsid"/>
                        <div class="clear"></div>
                        <a href="javascript:;" class="favorite_btn add_favorite" data="943">Add to Favorite Items</a>
                    </div>
                    <input type="hidden" id="ProId" name="ProId" value="943"/>
                    <input type="hidden" id="ItemPrice" name="ItemPrice" value="15.00" initial="15.00" sales="0"
                           discount="" old="25.99"/>
                    <input type="hidden" name="Attr" id="attr_hide" value="[]"/>
                    <input type="hidden" id="ext_attr" value="[]"/>
                    <input type="hidden" name="products_type" value="2"/>
                    <input type="hidden" name="SId" value="1" stock="16"/>
                    <input type="hidden" id="CId" value="1"/>
                    <input type="hidden" id="CountryName" value="Afghanistan"/>
                    <input type="hidden" id="CountryAcronym" value="AF"/>
                    <input type="hidden" id="ShippingId" value="0"/>
                    <input type="hidden" id="attrStock" value="0"/>
                </form>
            </div>
        </div>
        <div class="clearfix">
            <div class="prod_desc_left fl">
                <div class="prod_description">
                    <ul class="pd_title">
                        <li class="current"><span>Description</span></li>
                    </ul>
                    <div class="pd_content editor_txt">
                        <div class="desc" data-number="0">
                            <div class="item_specifics">
                                <div class="title">Specifications</div>
                            </div>
                            Specifications
                            商品介绍
                            <table>
                                <tr>
                                    <th>产品参数一:</th>
                                    <td>${goods.parameter1}</td>
                                </tr>
                                <tr>
                                    <th>产品参数二:</th>
                                    <td>${goods.parameter2}</td>
                                </tr>
                                <tr>
                                    <th>产品参数三:</th>
                                    <td>${goods.parameter3}</td>
                                </tr>
                            </table>

                            <br>
                            <c:if test="${not empty images}">
                                <c:forEach var="i" items="${images}">
                                    <div class="prod_gallery_x" style="height: auto;">
                                        <img src="<%=basePath%>image/show?pic=${i.title}">
                                    </div>
                                </c:forEach>
                            </c:if>
                            <%--<c:if test="${empty images}">--%>
                                <%--<div class="prod_gallery_x" style="height: auto;">--%>
                                    <%--<img src="<%=basePath%>picture/propro.jpg">--%>
                                <%--</div>--%>
                            <%--</c:if>--%>
                            <br>

                            详情介绍:<br>
                            ${goods.detail}

                        </div>
                    </div>
                </div>
            </div>
            <div class="prod_desc_right fr">
                <div id="may_like" class="sidebar">
                    <h3 class="b_title">You May Like</h3>
                    <div class="b_list">

                        <dl class="pro_item clearfix">
                            <dt class="fl"><a class="pic_box" href="<%=basePath%>pro.htm"><img
                                    src="<%=basePath%>picture/leftpro.jpg"/><span></span></a></dt>
                            <dd class="fl pro_info">
                                <div class="pro_name"><a href="<%=basePath%>pro.htm">Product Name</a></div>
                                <div class="pro_price"><em class="currency_data PriceColor">$</em><span
                                        class="price_data PriceColor" data="18">18.00</span></div>
                            </dd>
                        </dl>

                        <dl class="pro_item clearfix">
                            <dt class="fl"><a class="pic_box" href="<%=basePath%>pro.htm"><img
                                    src="picture/leftpro.jpg"/><span></span></a></dt>
                            <dd class="fl pro_info">
                                <div class="pro_name"><a href="<%=basePath%>pro.htm">Product Name</a></div>
                                <div class="pro_price"><em class="currency_data PriceColor">$</em><span
                                        class="price_data PriceColor" data="18">18.00</span></div>
                            </dd>
                        </dl>

                        <dl class="pro_item clearfix">
                            <dt class="fl"><a class="pic_box" href="<%=basePath%>pro.htm"><img
                                    src="picture/leftpro.jpg"/><span></span></a></dt>
                            <dd class="fl pro_info">
                                <div class="pro_name"><a href="<%=basePath%>pro.htm">Product Name</a></div>
                                <div class="pro_price"><em class="currency_data PriceColor">$</em><span
                                        class="price_data PriceColor" data="18">18.00</span></div>
                            </dd>
                        </dl>

                        <dl class="pro_item clearfix">
                            <dt class="fl"><a class="pic_box" href="pro.htm"><img
                                    src="<%=basePath%>picture/leftpro.jpg"/><span></span></a></dt>
                            <dd class="fl pro_info">
                                <div class="pro_name"><a href="<%=basePath%>pro.htm">Product Name</a></div>
                                <div class="pro_price"><em class="currency_data PriceColor">$</em><span
                                        class="price_data PriceColor" data="18">18.00</span></div>
                            </dd>
                        </dl>

                        <dl class="pro_item clearfix">
                            <dt class="fl"><a class="pic_box" href="<%=basePath%>pro.htm"><img
                                    src="<%=basePath%>picture/leftpro.jpg"/><span></span></a></dt>
                            <dd class="fl pro_info">
                                <div class="pro_name"><a href="<%=basePath%>pro.htm">Product Name</a></div>
                                <div class="pro_price"><em class="currency_data PriceColor">$</em><span
                                        class="price_data PriceColor" data="18">18.00</span></div>
                            </dd>
                        </dl>


                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(function () {
                $('.pic_list>a').lightBox();
            });
        </script>


    </div>


</div>

<div id="footer">
    <div class="foot wide clean">
        <div class="foot_menu fl">
            <div class="foot_menu_hd">About Us</div>
            <ul class="list">
                <li><a href="<%=basePath%>about.htm"><em></em>About Us</a></li>
                <li><a href="<%=basePath%>part/prolist"><em></em>Products</a></li>
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


<script type='text/javascript' src='<%=basePath%>js/module.js'></script>
<script type='text/javascript' src='<%=basePath%>js/review.js'></script>
<script type='text/javascript' src='<%=basePath%>js/lightbox.min.js'></script>
<script type="text/javascript" src="<%=basePath%>js/addthis_widget.js"></script>
</body>
</html>

<script>
    var obj_lis = document.getElementById("test").getElementsByTagName("li");

    for(i=0;i<obj_lis.length;i++){
        obj_lis[i].onclick = function(){
            //改AJAX
            //alert($(this).attr("name"));
            var fid=$(this).attr("name");
            var gid=$("#gid").val();
            var dates='';
            if(fid=="a")
            {
                dates='{"fid":"'+gid+'","type":"'+0+'"}';
            }
            else
            {
                dates='{"fid":"'+fid+'","type":"'+1+'"}';
            }
            changePrice(dates);
            
        }
    }
    $('#test li').eq(0).addClass("active");
    $('#test li').each(function(){
        $(this).click(function(){
            $(this).addClass("active").siblings().removeClass("active");
        })
    })

    function changePrice(dates) {

        $.ajax( {
            type : 'POST',
            contentType : 'application/json',
            url : '<%=basePath%>format/changePrice',
            data : dates,
            dataType : 'json',
            success : function(data) {
                console.log(data);
                //$("#cur_price").text(data);
                $.each(data,function (i,row) {
                    if(i=="price")
                    {
                        $("#cur_price").text(row);//price
                    }
                    if(i=="stock")
                    {
                        $("#save_p").text(row);//price
                    }
                    if(i=="sales")
                    {
                        $("#gsales").text(row);
                    }

                })
//                for (var key in data)
//                {
//                    alert(key); alert(data[key]);
//                }
            },
            error : function(data) {
                alert("错误!")
            }
        });

    }
    
</script>