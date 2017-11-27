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

    <script type="text/javascript">
        //加载页面发送ajax
        $(function(){
            var key=$("#key").val();
            var date="";
            if( key.length>0 )
            {
                date=key;
            }
            else
            {
                date="null";
            }

            $.ajax( {
                type : 'POST',
                contentType : 'application/json;charset=UTF-8',
                url : '<%=basePath%>goods/partGoods',
                data : date,
                dataType : 'json',
                success : function(jsonDate) {
//                    console.log( '当前页码'+eval(jsonDate).pageNo );
//                    console.log( '当页条目'+eval(jsonDate).pageSize );
//                    console.log( '总页数'+eval(jsonDate).pages );
//                    console.log( '总条目'+eval(jsonDate).total );
//                    console.log(jsonDate);
                    dealJson(jsonDate);
                    afterLoad();
                },
                error : function(data) {
                    alert("错误!")
                }
            });

            //板块选择
            $(".part_choice").click(function () {
                //alert("xx");
                $("#partid").val($(this).attr("name"));
                //清空搜索条目

                $("#key").val("");
                $("#keyshow").val("");

                toGetGoods(3,null,null,1);
                //console.log( $(this).attr("name") );
            })


            //直接帅选
            $("#submit_btn1").click(function () {
                toGetGoods(4,null,null,null);
            });
//            $(".go").click(function () {
//                $(this).remove("#submit_btn");
//                toGetGoods(4,null,null,null);
//            });

            //Sales

            //News

        })

        //绑定事件
        function afterLoad()
        {
            //alert("after");
            $(function() {
                //前进/后退
                $(".page_button").click(function () {
                    if( $(this).attr("name")=="p" ) //前页
                    {
                        //alert("p");
                        toGetGoods(1,null,null,null);
                    }
                    else if($(this).attr("name") == "n")//后页
                    {
                        //alert("n");
                        toGetGoods(2,null,null,null);
                    }
                });
                //页码选择
                $(".page_item").click(function () {
                    var pageNo=$(this).attr("name");
                    toGetGoods(3,null,null,pageNo);
                });

            })
        }

        //发送ajax 类型，最低价，最高价，查询页码(null为当前)
        function toGetGoods(type,index,end,pageNo) {
            $(function() {
                var pid=$("#partid").val();
                if(pageNo==null)
                {
                    pageNo=$("#pageNo").val();
                }
                var pageSize=$("#pageSize").val();
                var pages=$("#pages").val();
                var total=$("#total").val();
                var min=$("#minprice").val();
                var max=$("#maxprice").val();

                var key=$("#key").val();
                //console.log(pid+" "+pageNo+" "+pageSize+" "+pages+" "+total+" "+type+" "+min+" "+max);

                var json='';
                json+='{';
                json+='"type":"'+type+'","pid":"'+pid+'","pageNo":"'+pageNo+'","pageSize":"'+pageSize+'","pages":"'+pages+'","total":"'+total+'"';
                json+=',"min":"'+min+'","max":"'+max+'"';
                if(key.length=="" || key==null)
                {
                    json+=',"key":"null"';
                }
                else
                {
                    json+=',"key":"'+key+'"';
                }
                json+='}';
                //console.log(json);
                $.ajax( {
                    type : 'POST',
                    contentType : 'application/json',
                    url : '<%=basePath%>goods/GoodsList',
                    data : json,
                    dataType : 'json',
                    success : function(jsonDate) {
                        console.log(jsonDate);
                        if(jsonDate==null)
                        {
                            return;
                        }
                        dealJson(jsonDate);
                        afterLoad();
                    },
                    error : function(jsonDate) {
                        console.log(jsonDate);
                        alert("错误!")
                    }
                });

            })
        }

        //处理json
        function dealJson(jsonDate) {
            $('#prod_list').empty();
            $("#turn_page").empty();

            var html='';
            var html2='';
            //遍历
            $.each(jsonDate.dataList, function(i, row){
                html+='<div class="prod_box prod_box_5 fl">'
                    + '<div class="prod_box_pic">'
                    + '<a class="pic_box" href="<%=basePath%>goods/NewGoodsDetail/'+row.id+'">'
                    + '<img src="<%=basePath%>image/show?pic='+row.title+'"/><span></span></a>'
                    + '<em class="icon_seckill DiscountBgColor">Sale</em></div>'
                    + '<div class="prod_box_info">'
                    + '<div class="prod_box_inner">'
                    + '<h3 class="prod_name">'
                    + '<a href="<%=basePath%>goods/NewGoodsDetail/'+row.id+'">'+row.name+'</a></h3>'
                    + '<div class="prod_price">'
                    + '<span class="price_data PriceColor" data="10" keyid="942">'+row.price+'</span>'
                    + '<del><em class="currency_data">$</em><span class="price_data" data="16.00">16.00</span></del></div>'
                    + '<div class="free_shipping"></div>'
                    + '<div class="prod_view">'
                    + '<span class="star star_s5"></span>'
                    + '<a class="review_count" href="<%=basePath%>pro.htm">(10)</a>'
                    + '<span class="favorite add_favorite" data="942"><i class="icon_heart"></i>(0)</span></div>'
                    + '</div></div></div>';

            });

            if(jsonDate.dataList.length>0)
            {
                html2+='<li class="page_last"><a href="javascript:void(0);" id="pre" class="page_button" name="p">Previous<em class="icon_page_prev"></em></a></li>';
            }
            else
            {
                html2+='暂无数据';
            }

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
            if(jsonDate.dataList.length>0)
            {
                html2+='<li class="page_last"><a href="javascript:void(0);" id="next" class="page_button" name="n">Next<em class="icon_page_next"></em></a></li>';
            }

            html2+='<input type="hidden" id="pageNo" name="pageNo" value="'+eval(jsonDate).pageNo+'">';
            html2+='<input type="hidden" id="pageSize" name="pageSize" value="'+eval(jsonDate).pageSize+'">';
            html2+='<input type="hidden" id="pages" name="pages" value="'+eval(jsonDate).pages+'">';
            html2+='<input type="hidden" id="total" name="total" value="'+eval(jsonDate).total+'">';
            html2+='<input type="hidden" id="partid" name="partid" value="null">';
            $('#prod_list').html(html);
            $("#turn_page").html(html2);
        }

    </script>


    <noscript><img height="1" width="1" style="display:none" src="<%=basePath%>picture/3523c051d6d54a079309b12eae2c624f.gif"/>
    </noscript>
    <!-- End Facebook Pixel Code -->
    <script type="text/javascript">$(function () {
        products_list_obj.init();
    });</script>
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
                    <li class="fr border_r"><a href="<%=basePath%>user/toMember_index.htm">My Account</a></li>
                </c:if>
            </ul>
        </div>
    </div>

    <div class="FontBgColor">
        <div class="wide">
            <div class="logo fl"><h1><a href="<%=basePath%>login/view"><img src="<%=basePath%>picture/logo.png" alt="lywebsite"/></a></h1></div>
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
                <form action="<%=basePath%>goods/search" method="post" class="form">
                    <input type="text" id="keyshow" class="text fl" placeholder="" name="Keyword" notnull="" value="${key}"/>
                    <!-- 定义key -->
                    <input type="hidden" id="key" value="${key}"/>

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
    <div id="location">Your position: <a href="<%=basePath%>login/view">Home</a> &gt; Products</div>
    <div class="pro_left fl">
        <div class="side_category sidebar">
            <div class="cate_title b_title">Products Categories</div>
            <div class="cate_menu b_main">
                <ul>
                    <c:if test="${empty allparts}">
                        <li><h2><a href="<%=basePath%>part/prolist">显示有误</a><em class="NavArrowColor"></em></h2></li>
                    </c:if>
                    <c:if test="${not empty allparts}">

                        <c:forEach var="s" items="${allparts}">
                            <li><h2>
                                <a href="javascript:void(0);" class="part_choice" name="${s.id}">${s.pname}</a>
                                <em class="NavArrowColor"></em>
                            </h2></li>
                        </c:forEach>

                    </c:if>
                    <!--
                    <li><h2><a href="<%=basePath%>part/prolist">Classification 01</a><em class="NavArrowColor"></em></h2></li>
                    <li><h2><a href="<%=basePath%>part/prolist">Classification 02</a><em class="NavArrowColor"></em></h2></li>
                    <li><h2><a href="<%=basePath%>part/prolist">Classification 03</a><em class="NavArrowColor"></em></h2></li>
                    <li><h2><a href="<%=basePath%>part/prolist">Classification 04</a><em class="NavArrowColor"></em></h2></li>
                    <li><h2><a href="<%=basePath%>part/prolist">Classification 05</a><em class="NavArrowColor"></em></h2></li>
                    <li><h2><a href="<%=basePath%>part/prolist">Classification 06</a><em class="NavArrowColor"></em></h2></li>
                    <li><h2><a href="<%=basePath%>part/prolist">Classification 07</a><em class="NavArrowColor"></em></h2></li>
                    -->
                </ul>
            </div>
        </div>


        <div id="what_hot" class="sidebar">
            <h2 class="b_title FontColor">What's Hot</h2>
            <div class="b_main">

                <c:forEach var="s" items="${hot}">
                    <dl class="pro_item clearfix">
                        <dt class="fl">
                            <a class="pic_box" href="<%=basePath%>goods/NewGoodsDetail/${s.id}">
                                <img src="<%=basePath%>image/show?pic=${s.title}"/><span></span>
                            </a>
                        </dt>
                        <dd class="fl pro_info">
                            <div class="pro_name">
                                <a href="<%=basePath%>goods/NewGoodsDetail/${s.id}">Product Name</a>
                            </div>
                            <div class="pro_price">
                                <em class="currency_data PriceColor"></em>
                                <span class="price_data PriceColor" data="${s.price}"></span>
                            </div>
                        </dd>
                    </dl>
                </c:forEach>

                <!--
                <dl class="pro_item clearfix">
                    <dt class="fl"><a class="pic_box" href="<%=basePath%>pro.htm"><img src="<%=basePath%>picture/leftpro.jpg"/><span></span></a>
                    </dt>
                    <dd class="fl pro_info">
                        <div class="pro_name"><a href="<%=basePath%>pro.htm">Product Name</a></div>
                        <div class="pro_price"><em class="currency_data PriceColor"></em><span
                                class="price_data PriceColor" data="3.99"></span></div>
                    </dd>
                </dl>

                <dl class="pro_item clearfix">
                    <dt class="fl"><a class="pic_box" href="<%=basePath%>pro.htm"><img src="<%=basePath%>picture/leftpro.jpg"/><span></span></a>
                    </dt>
                    <dd class="fl pro_info">
                        <div class="pro_name"><a href="<%=basePath%>pro.htm">Product Name</a></div>
                        <div class="pro_price"><em class="currency_data PriceColor"></em><span
                                class="price_data PriceColor" data="3.99"></span></div>
                    </dd>
                </dl>

                <dl class="pro_item clearfix">
                    <dt class="fl"><a class="pic_box" href="<%=basePath%>pro.htm"><img src="<%=basePath%>picture/leftpro.jpg"/><span></span></a>
                    </dt>
                    <dd class="fl pro_info">
                        <div class="pro_name"><a href="<%=basePath%>pro.htm">Product Name</a></div>
                        <div class="pro_price"><em class="currency_data PriceColor"></em><span
                                class="price_data PriceColor" data="3.99"></span></div>
                    </dd>
                </dl>

                -->

                <a class="b_bottom FontColor" href="<%=basePath%>part/prolist">See More»</a>

            </div>
        </div>

        <div class="seckill_box sidebar_to">
            <h2 class="seckill_title b_title FontColor">Flash Sales</h2>
            <div class="seckill_main b_main">
                <div class="item">
                    <div class="img pic_box"><a href="<%=basePath%>pro.htm"><img src="<%=basePath%>picture/cuxiao.jpg"/></a><span></span></div>
                    <div class="name"><a href="<%=basePath%>pro.htm">Promotional product name</a></div>
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


        <div class="blank20"></div>
    </div>


    <div class="pro_right fr">
        <div class="narrow_search">
            <div class="ns_title clearfix">
                <h2>Products</h2>
            </div>
        </div>
        <div id="filter">
            <div class="prod_sort fl">
                <a href="javascript:void(0);"><em class="sort_icon_popular"></em>Most Popular</a>
                <a href="javascript:void(0);"><em class="sort_icon_sales"></em>Sales</a>
                <a href="javascript:void(0);"><em class="sort_icon_favorites"></em>Favorites</a>
                <a href="javascript:void(0);"><em class="sort_icon_new"></em>New</a>
                <a href="javascript:void(0);"><em class="sort_icon_price"></em>Price<i class="sort_icon_arrow"></i></a>
            </div>
            <div class="prod_price fl">
                <span class="pp_inputbox"><em class="currency_data"></em><input type="text" id="minprice"
                                                                                class="min_box" autocomplete="off"
                                                                                value=""></span>
                <span class="pp_heng">-</span>
                <span class="pp_inputbox"><em class="currency_data"></em><input type="text" id="maxprice"
                                                                                class="max_box" autocomplete="off"
                                                                                value=""></span>
                <input type="button" id="submit_btn1" class="pp_btn go" value="Go"/>
                <input type="hidden" class="no_price_url" value="?"/>
            </div>
            <div class="prod_menu fr">
                <div class='page'>
                    <div class='cur'>1/3</div>
                    <ul>
                        <li><a href='<%=basePath%>part/prolist'>1/3</a></li>
                        <li><a href='<%=basePath%>part/prolist'>2/3</a></li>
                        <li><a href='<%=basePath%>part/prolist'>3/3</a></li>
                    </ul>
                </div>
                <a href='<%=basePath%>part/prolist' class='page_item pre'></a><a href='<%=basePath%>part/prolist' class='page_item next'></a>
            </div>
        </div>
        <div id="prod_list" class="list prod_list clearfix" effects="5">

            <!---产品列表开始--->

            <!--
            <div class="prod_box prod_box_5 fl">
                <div class="prod_box_pic">
                    <a class="pic_box" href="pro.htm"><img src="<%=basePath%>picture/pro.jpg"/><span></span></a>
                    <em class="icon_seckill DiscountBgColor">Sale</em>
                </div>
                <div class="prod_box_info">
                    <div class="prod_box_inner">
                        <h3 class="prod_name"><a href="<%=basePath%>pro.htm">Products Name</a></h3>
                        <div class="prod_price">
                            <em class="currency_data PriceColor">$</em><span class="price_data PriceColor" data="10"
                                                                             keyid="942">10.00</span>
                            <del><em class="currency_data">$</em><span class="price_data" data="16.00">16.00</span>
                            </del>
                        </div>
                        <div class="free_shipping"></div>
                        <div class="prod_view">
                            <span class="star star_s5"></span><a class="review_count" href="<%=basePath%>pro.htm">(10)</a><span
                                class="favorite add_favorite" data="942"><i class="icon_heart"></i>(0)</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="prod_box prod_box_5 fl">
                <div class="prod_box_pic">
                    <a class="pic_box" href="pro.htm"><img src="<%=basePath%>picture/pro.jpg"/><span></span></a>
                    <em class="icon_seckill DiscountBgColor">Sale</em>
                </div>
                <div class="prod_box_info">
                    <div class="prod_box_inner">
                        <h3 class="prod_name"><a href="<%=basePath%>pro.htm">Products Name</a></h3>
                        <div class="prod_price">
                            <em class="currency_data PriceColor">$</em><span class="price_data PriceColor" data="10"
                                                                             keyid="942">10.00</span>
                            <del><em class="currency_data">$</em><span class="price_data" data="16.00">16.00</span>
                            </del>
                        </div>
                        <div class="free_shipping"></div>
                        <div class="prod_view">
                            <span class="star star_s5"></span><a class="review_count" href="<%=basePath%>pro.htm">(10)</a><span
                                class="favorite add_favorite" data="942"><i class="icon_heart"></i>(0)</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="prod_box prod_box_5 fl">
                <div class="prod_box_pic">
                    <a class="pic_box" href="pro.htm"><img src="picture/pro.jpg"/><span></span></a>
                    <em class="icon_seckill DiscountBgColor">Sale</em>
                </div>
                <div class="prod_box_info">
                    <div class="prod_box_inner">
                        <h3 class="prod_name"><a href="pro.htm">Products Name</a></h3>
                        <div class="prod_price">
                            <em class="currency_data PriceColor">$</em><span class="price_data PriceColor" data="10"
                                                                             keyid="942">10.00</span>
                            <del><em class="currency_data">$</em><span class="price_data" data="16.00">16.00</span>
                            </del>
                        </div>
                        <div class="free_shipping"></div>
                        <div class="prod_view">
                            <span class="star star_s5"></span><a class="review_count" href="pro.htm">(10)</a><span
                                class="favorite add_favorite" data="942"><i class="icon_heart"></i>(0)</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="prod_box prod_box_5 fl">
                <div class="prod_box_pic">
                    <a class="pic_box" href="pro.htm"><img src="picture/pro.jpg"/><span></span></a>
                    <em class="icon_seckill DiscountBgColor">Sale</em>
                </div>
                <div class="prod_box_info">
                    <div class="prod_box_inner">
                        <h3 class="prod_name"><a href="pro.htm">Products Name</a></h3>
                        <div class="prod_price">
                            <em class="currency_data PriceColor">$</em><span class="price_data PriceColor" data="10"
                                                                             keyid="942">10.00</span>
                            <del><em class="currency_data">$</em><span class="price_data" data="16.00">16.00</span>
                            </del>
                        </div>
                        <div class="free_shipping"></div>
                        <div class="prod_view">
                            <span class="star star_s5"></span><a class="review_count" href="pro.htm">(10)</a><span
                                class="favorite add_favorite" data="942"><i class="icon_heart"></i>(0)</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="prod_box prod_box_5 fl">
                <div class="prod_box_pic">
                    <a class="pic_box" href="pro.htm"><img src="picture/pro.jpg"/><span></span></a>
                    <em class="icon_seckill DiscountBgColor">Sale</em>
                </div>
                <div class="prod_box_info">
                    <div class="prod_box_inner">
                        <h3 class="prod_name"><a href="pro.htm">Products Name</a></h3>
                        <div class="prod_price">
                            <em class="currency_data PriceColor">$</em><span class="price_data PriceColor" data="10"
                                                                             keyid="942">10.00</span>
                            <del><em class="currency_data">$</em><span class="price_data" data="16.00">16.00</span>
                            </del>
                        </div>
                        <div class="free_shipping"></div>
                        <div class="prod_view">
                            <span class="star star_s5"></span><a class="review_count" href="pro.htm">(10)</a><span
                                class="favorite add_favorite" data="942"><i class="icon_heart"></i>(0)</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="prod_box prod_box_5 fl">
                <div class="prod_box_pic">
                    <a class="pic_box" href="pro.htm"><img src="picture/pro.jpg"/><span></span></a>
                    <em class="icon_seckill DiscountBgColor">Sale</em>
                </div>
                <div class="prod_box_info">
                    <div class="prod_box_inner">
                        <h3 class="prod_name"><a href="pro.htm">Products Name</a></h3>
                        <div class="prod_price">
                            <em class="currency_data PriceColor">$</em><span class="price_data PriceColor" data="10"
                                                                             keyid="942">10.00</span>
                            <del><em class="currency_data">$</em><span class="price_data" data="16.00">16.00</span>
                            </del>
                        </div>
                        <div class="free_shipping"></div>
                        <div class="prod_view">
                            <span class="star star_s5"></span><a class="review_count" href="pro.htm">(10)</a><span
                                class="favorite add_favorite" data="942"><i class="icon_heart"></i>(0)</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="prod_box prod_box_5 fl">
                <div class="prod_box_pic">
                    <a class="pic_box" href="pro.htm"><img src="picture/pro.jpg"/><span></span></a>
                    <em class="icon_seckill DiscountBgColor">Sale</em>
                </div>
                <div class="prod_box_info">
                    <div class="prod_box_inner">
                        <h3 class="prod_name"><a href="pro.htm">Products Name</a></h3>
                        <div class="prod_price">
                            <em class="currency_data PriceColor">$</em><span class="price_data PriceColor" data="10"
                                                                             keyid="942">10.00</span>
                            <del><em class="currency_data">$</em><span class="price_data" data="16.00">16.00</span>
                            </del>
                        </div>
                        <div class="free_shipping"></div>
                        <div class="prod_view">
                            <span class="star star_s5"></span><a class="review_count" href="pro.htm">(10)</a><span
                                class="favorite add_favorite" data="942"><i class="icon_heart"></i>(0)</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="prod_box prod_box_5 fl">
                <div class="prod_box_pic">
                    <a class="pic_box" href="pro.htm"><img src="picture/pro.jpg"/><span></span></a>
                    <em class="icon_seckill DiscountBgColor">Sale</em>
                </div>
                <div class="prod_box_info">
                    <div class="prod_box_inner">
                        <h3 class="prod_name"><a href="pro.htm">Products Name</a></h3>
                        <div class="prod_price">
                            <em class="currency_data PriceColor">$</em><span class="price_data PriceColor" data="10"
                                                                             keyid="942">10.00</span>
                            <del><em class="currency_data">$</em><span class="price_data" data="16.00">16.00</span>
                            </del>
                        </div>
                        <div class="free_shipping"></div>
                        <div class="prod_view">
                            <span class="star star_s5"></span><a class="review_count" href="pro.htm">(10)</a><span
                                class="favorite add_favorite" data="942"><i class="icon_heart"></i>(0)</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="prod_box prod_box_5 fl">
                <div class="prod_box_pic">
                    <a class="pic_box" href="pro.htm"><img src="picture/pro.jpg"/><span></span></a>
                    <em class="icon_seckill DiscountBgColor">Sale</em>
                </div>
                <div class="prod_box_info">
                    <div class="prod_box_inner">
                        <h3 class="prod_name"><a href="pro.htm">Products Name</a></h3>
                        <div class="prod_price">
                            <em class="currency_data PriceColor">$</em><span class="price_data PriceColor" data="10"
                                                                             keyid="942">10.00</span>
                            <del><em class="currency_data">$</em><span class="price_data" data="16.00">16.00</span>
                            </del>
                        </div>
                        <div class="free_shipping"></div>
                        <div class="prod_view">
                            <span class="star star_s5"></span><a class="review_count" href="pro.htm">(10)</a><span
                                class="favorite add_favorite" data="942"><i class="icon_heart"></i>(0)</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="prod_box prod_box_5 fl">
                <div class="prod_box_pic">
                    <a class="pic_box" href="pro.htm"><img src="picture/pro.jpg"/><span></span></a>
                    <em class="icon_seckill DiscountBgColor">Sale</em>
                </div>
                <div class="prod_box_info">
                    <div class="prod_box_inner">
                        <h3 class="prod_name"><a href="pro.htm">Products Name</a></h3>
                        <div class="prod_price">
                            <em class="currency_data PriceColor">$</em><span class="price_data PriceColor" data="10"
                                                                             keyid="942">10.00</span>
                            <del><em class="currency_data">$</em><span class="price_data" data="16.00">16.00</span>
                            </del>
                        </div>
                        <div class="free_shipping"></div>
                        <div class="prod_view">
                            <span class="star star_s5"></span><a class="review_count" href="pro.htm">(10)</a><span
                                class="favorite add_favorite" data="942"><i class="icon_heart"></i>(0)</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="prod_box prod_box_5 fl">
                <div class="prod_box_pic">
                    <a class="pic_box" href="pro.htm"><img src="picture/pro.jpg"/><span></span></a>
                    <em class="icon_seckill DiscountBgColor">Sale</em>
                </div>
                <div class="prod_box_info">
                    <div class="prod_box_inner">
                        <h3 class="prod_name"><a href="pro.htm">Products Name</a></h3>
                        <div class="prod_price">
                            <em class="currency_data PriceColor">$</em><span class="price_data PriceColor" data="10"
                                                                             keyid="942">10.00</span>
                            <del><em class="currency_data">$</em><span class="price_data" data="16.00">16.00</span>
                            </del>
                        </div>
                        <div class="free_shipping"></div>
                        <div class="prod_view">
                            <span class="star star_s5"></span><a class="review_count" href="pro.htm">(10)</a><span
                                class="favorite add_favorite" data="942"><i class="icon_heart"></i>(0)</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="prod_box prod_box_5 fl">
                <div class="prod_box_pic">
                    <a class="pic_box" href="pro.htm"><img src="picture/pro.jpg"/><span></span></a>
                    <em class="icon_seckill DiscountBgColor">Sale</em>
                </div>
                <div class="prod_box_info">
                    <div class="prod_box_inner">
                        <h3 class="prod_name"><a href="pro.htm">Products Name</a></h3>
                        <div class="prod_price">
                            <em class="currency_data PriceColor">$</em><span class="price_data PriceColor" data="10"
                                                                             keyid="942">10.00</span>
                            <del><em class="currency_data">$</em><span class="price_data" data="16.00">16.00</span>
                            </del>
                        </div>
                        <div class="free_shipping"></div>
                        <div class="prod_view">
                            <span class="star star_s5"></span><a class="review_count" href="pro.htm">(10)</a><span
                                class="favorite add_favorite" data="942"><i class="icon_heart"></i>(0)</span>
                        </div>
                    </div>
                </div>
            </div>

            -->
            <!---产品列表结束--->
            <div class="clear"></div>
        </div>
        <div class="blank20"></div>
        <div id="turn_page">
            <li><font class='page_noclick'><em class='icon_page_prev'></em>Previous</font></li>
            <li><font class='page_item_current'>1</font></li>
            <li><a href='<%=basePath%>part/prolist' class='page_item'>2</a></li>
            <li><a href='<%=basePath%>part/prolist' class='page_item'>3</a></li>
            <li class='page_last'><a href='<%=basePath%>part/prolist' class='page_button'>Next<em class='icon_page_next'></em></a>
            </li>
        </div>
        <link href='<%=basePath%>css/row_4.css' rel='stylesheet' type='text/css'/>
        <script type='text/javascript' src='<%=basePath%>js/row_4.js'></script>
    </div>
    <div class="blank25"></div>
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
            <a href="javascript:void(0);" target="_blank" style="margin:0 5px;"><img src="<%=basePath%>picture/06e4596004.png"
                                                                                     alt="2"/></a>
            <a href="javascript:void(0);" target="_blank" style="margin:0 5px;"><img src="<%=basePath%>picture/a42c34df2c.png"
                                                                                     alt="3"/></a>
            <a href="javascript:void(0);" target="_blank" style="margin:0 5px;"><img src="<%=basePath%>picture/84b60e7538.png"
                                                                                     alt="4"/></a>
        </div>
        <div class="cp fr copyright"> &nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0);" target="_blank">POWERED BY
            SZJIDING</a>
        </div>
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