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

    <!-- layer -->
    <script type="text/javascript" src="<%=basePath%>js/layer.js" ></script>

    <!-- Facebook Pixel Code -->
    <script type="text/javascript">
        $.fn.fbq_checkout = function () {
            fbq('track', 'InitiateCheckout', {currency: 'USD'});
        }
    </script>
    <!-- End Facebook Pixel Code -->

    <script type="text/javascript">
        function palpal() {
            var form = $("<form></form>");
            form.attr('action', "https://www.paypal.com/cgi-bin/webscr");
            form.attr('method', 'post');
            form.attr('target', '_self');

            var input1 = $("<input type='hidden' name='cmd' />");
            input1.attr('value', '_s-xclick');
            form.append(input1);

            var input2 = $("<input type='hidden' name='hosted_button_id' />");
            input2.attr('value', 'WZFVVSXV9KAPY');
            form.append(input2);

            var input3 = $("<input type='hidden' name='amount' />");
            input3.attr('value',  $("#ot_total").text() );
            form.append(input3);

            form.appendTo("body");
            form.css('display', 'none');
            form.submit();
        }
        
        function paypal2(uuid) {
            var url = "<%=basePath%>order/gotopay";
            //uuid acount userid
            var user_id=${sessionScope.user.id};
            if(user_id==null || user_id.length<=0)
            {
                return false;
            }
            var account=$("#ot_total").text();
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

            <!-- 转移 from use -->
            //user_obj.user_address();

            //生成订单 并跳转
            $("#buy").click(function () {
                var json=$("#cart_json").val();//待提交  -->商品信息
                console.log(json);//testOK
                json=json.toString();
                var list= $('input:radio[name="choice"]:checked').val();
                if(list==null){
                    alert("请选中一个!");
                    return false;
                }

                var tablerow = $('input:radio[name="choice"]:checked').parent();
                var aid = tablerow.find("[name='aid']").attr("value");//待提交,收货地址
                console.log(aid);

                //var all=$("#all").attr("value");
                //console.log(all);
                var freight=$("#ot_combine_shippnig_insurance").text();

                console.log(json);
                var date=json.substr(0,json.length-1);
                //json=json.substr(0,json.length-1);
                date=date+",'aid':'"+aid+"','freight':'"+freight+"'}";
                //var dates='{json:'+json+',aid:'+aid+',all:'+all+'}';
                console.log(date);
                $.ajax( {
                    type : 'POST',
                    contentType : 'application/json; charset=UTF-8',
                    url : '<%=basePath%>order/create',
                    data : date,
                    dataType : 'text',
                    success : function(data) {
                        console.log(data);
                        //if(data==true || data=="true")
                        if(data.length==36)
                        {
                            alert("下单成功");
                            <%--window.location.href="<%=basePath%>user/toShopCenter";--%>
                            //palpal();
                            paypal2(data);
                        }
                        else
                        {
                            alert(data);
                        }
                    },
                    error : function(data) {
                        console.log(data);
                        alert("错误");
                        //alert(data.responseText);
                    }
                });
            });

            //增加地址

        })

//        $(document).ready(function () {
//            $("#addAddress").click(function () {
//                user_obj.user_address();
//            });
//
//        });
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
                <li class="fr border_r"><a href="<%=basePath%>member_favorite.htm">Wish List</a></li>
                <li class="fr border_r"><a href="<%=basePath%>member_index.htm">My Account</a></li>
            </ul>
        </div>
    </div>

    <div class="FontBgColor">
        <div class="wide">
            <div class="logo fl"><h1><a href="<%=basePath%>index.htm"><img src="<%=basePath%>picture/logo.png" alt="lywebsite"/></a></h1></div>
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
    <script type="text/javascript">
        var address_count = 1;
        var address_perfect = 0;
        $(document).ready(function () {
            cart_obj.checkout_init()
        });
        $('html').loginOrVisitors('/cart/checkout.html', 0, function () {
            ueeshop_config['_login'] = 1;
            return false;
        });
    </script>
    <div id="lib_cart">
        <div class="step">
            <div class="step_1"></div>
        </div>
        <div class="cartFrom">
            <table width="100%" align="center" cellpadding="12" cellspacing="0" border="0" class="itemFrom">
                <thead>
                <tr>
                    <td width="50%" class="first">Item</td>
                    <td width="16%">Price</td>
                    <td width="16%" class="quantity">Quantity</td>
                    <td width="18%">Total</td>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${goodslist}">
                    <tr cid="${item.get("gid")}">
                        <td class="prList">
                            <dl>
                                <dt>
                                    <a href="<%=basePath%>goods/NewGoodsDetail/${item.get("gid")}">
                                        <img src="<%=basePath%>image/show?pic=${item.get("title")}"/>
                                    </a>
                                </dt>
                                <dd>
                                    <h4><a href="<%=basePath%>goods/NewGoodsDetail/${item.get("gid")}">${item.get("name")}</a></h4>
                                    <p>${item.get("ciid")}</p>
                                </dd>
                            </dl>
                            <dl>
                                <dd>
                                    <p class="remark">Remark: <input type="text" name="Remark[]" value="" maxlength="200"
                                                                     data="" cid="474" proid="938"/></p>
                                </dd>
                            </dl>
                        </td>
                        <td class="prPrice"><p>$${item.get("price")}</p></td>
                        <td class="prQuant"><p>${item.get("amount")} / ${item.get("gclass")}</p></td>
                        <td class="prAmount"><p>$${item.get("all")}</p></td>
                    </tr>
                </c:forEach>

                <%--<tr cid="474">--%>
                    <%--<td class="prList">--%>
                        <%--<dl>--%>
                            <%--<dt><a href="<%=basePath%>pro.htm"><img src="<%=basePath%>picture/pro.jpg"/></a></dt>--%>
                            <%--<dd>--%>
                                <%--<h4><a href="<%=basePath%>pro.htm">Product Name</a></h4>--%>
                                <%--<p>079</p>--%>
                            <%--</dd>--%>
                        <%--</dl>--%>
                        <%--<dl>--%>
                            <%--<dd>--%>
                                <%--<p class="remark">Remark: <input type="text" name="Remark[]" value="" maxlength="200"--%>
                                                                 <%--data="" cid="474" proid="938"/></p>--%>
                            <%--</dd>--%>
                        <%--</dl>--%>
                    <%--</td>--%>
                    <%--<td class="prPrice"><p>$7.99</p></td>--%>
                    <%--<td class="prQuant"><p>1</p></td>--%>
                    <%--<td class="prAmount"><p>$7.99</p></td>--%>
                <%--</tr>--%>

                </tbody>
            </table>
            <div class="edit_shopping_cart"><a href="<%=basePath%>cart/toCart/${sessionScope.user.id}">Edit Shopping Cart</a></div>
        </div>
        <div class="cartBox" id="addressObj">
            <h2>Shopping Address</h2>
            <div class="contents address">
                <ul id="lib_address">
                    <c:if test="${not empty addresses}">
                        <c:forEach var="item" items="${addresses}" varStatus="i">
                            <li>
                                <input type="radio" name="choice" id="address_${i}"  value="1" CId="13"/>
                                <input type="hidden" name="aid" value="${item.id}"/>
                                <label for="address_${i}">
                                    <strong>${item.area}</strong>
                                    (${item.detail} Phone: ${item.phone}
                                    Recipients: ${item.recipient} Zip: ${item.zip})
                                </label>
                                <a href="javascript:;" class="edit_address_info">Edit</a>
                            </li>
                        </c:forEach>
                    </c:if>
                    <%--<li>--%>
                        <%--<input type="radio" name="shipping_address_id" id="address_1" value="1" CId="13"/>--%>
                        <%--<label for="address_1">--%>
                            <%--<strong>11 11</strong>--%>
                            <%--(adfafd 11111 asfda, Australian Capital Territory 111asdfasd Australia)--%>
                        <%--</label>--%>
                        <%--<a href="javascript:;" class="edit_address_info">Edit</a>--%>
                    <%--</li>--%>

                    <li style="display:;">
                        <a id="addAddress" href="javascript:void(0);" class="textbtn">Add a New Shipping Address</a>
                    </li>
                    <li id="addressInfo" style="display:none;"></li>
                    <li id="addressForm">
                        <script type="text/javascript">
                            $(document).ready(function () {
                                user_obj.user_address()
                            });
                        </script>
                        <div class="editAddr">
                            <form method="post" action="">
                                <input id="addressId" type="hidden" name="edit_address_id" value="0">
                                <a id="cancelAddr" class="cancel" href="javascript:;" style="display:;">Cancel</a>
                                <p>
                                    <span class="required">*</span>&nbsp;<span class="indicates">Indicates required fields.</span>
                                </p>
                                <table class="tb-shippingAddr">
                                    <tbody>
                                    <tr>
                                        <th></th>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th><label>Your Name:</label></th>
                                        <td class="recipient">
                                            <div>
                                                <input type="text" name="FirstName" maxlength="32" class="elmbBlur"/>
                                                <p><span class="required">*</span>&nbsp;First Name</p>
                                                <p class="errorInfo"></p>
                                            </div>
                                            <div>
                                                <input type="text" name="LastName" maxlength="32" class="elmbBlur"/>
                                                <p><span class="required">*</span>&nbsp;Last Name</p>
                                                <p class="errorInfo"></p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th><span class="required">*</span><label>ZIP / Postal Code:</label></th>
                                        <td><input type="text" name="ZipCode" maxlength="10" class="elmbBlur"/>
                                            <p class="errorInfo"></p></td>
                                    </tr>
                                    <tr>
                                        <th><span class="required">*</span><label>Destination Country/Region:</label>
                                        </th>
                                        <td>
                                            <select name="country_id" id="country"
                                                    placeholder="Please Choose Your Country" style="display:none;"
                                                    class="chzn-done">
                                                <option value="-1"></option>
                                                <optgroup label="---------">
                                                    <option value="1">Afghanistan</option>
                                                    <option value="13">Australia</option>
                                                    <option value="30">Brazil</option>
                                                    <option value="38">Canada</option>
                                                    <option value="74">France</option>
                                                    <option value="81">Germany</option>
                                                    <option value="106">Italy</option>
                                                    <option value="199">Spain</option>
                                                    <option value="206">Switzerland</option>
                                                    <option value="224">United Kingdom</option>
                                                    <option value="226">United States</option>
                                                </optgroup>
                                                <optgroup label="---------">
                                                    <option value="1">Afghanistan</option>
                                                    <option value="2">Albania</option>
                                                    <option value="3">Algeria</option>
                                                    <option value="4">American Samoa</option>
                                                    <option value="5">Andorra</option>
                                                    <option value="6">Angola</option>
                                                    <option value="7">Anguilla</option>
                                                    <option value="9">Antigua and Barbuda</option>
                                                    <option value="10">Argentina</option>
                                                    <option value="11">Armenia</option>
                                                    <option value="12">Aruba</option>
                                                    <option value="13">Australia</option>
                                                    <option value="14">Austria</option>
                                                    <option value="15">Azerbaijan</option>
                                                    <option value="16">Bahamas</option>
                                                    <option value="17">Bahrain</option>
                                                    <option value="18">Bangladesh</option>
                                                    <option value="19">Barbados</option>
                                                    <option value="20">Belarus</option>
                                                    <option value="21">Belgium</option>
                                                    <option value="22">Belize</option>
                                                    <option value="23">Benin</option>
                                                    <option value="24">Bermuda</option>
                                                    <option value="25">Bhutan</option>
                                                    <option value="26">Bolivia</option>
                                                    <option value="27">Bosnia and Herzegovina</option>
                                                    <option value="28">Botswana</option>
                                                    <option value="29">Bouvet Island</option>
                                                    <option value="30">Brazil</option>
                                                    <option value="31">British Indian Ocean Territory</option>
                                                    <option value="32">Brunei Darussalam</option>
                                                    <option value="33">Bulgaria</option>
                                                    <option value="34">Burkina Faso</option>
                                                    <option value="35">Burundi</option>
                                                    <option value="36">Cambodia</option>
                                                    <option value="37">Cameroon</option>
                                                    <option value="38">Canada</option>
                                                    <option value="39">Cape Verde</option>
                                                    <option value="40">Cayman Islands</option>
                                                    <option value="41">Central African Republic</option>
                                                    <option value="42">Chad</option>
                                                    <option value="43">Chile</option>
                                                    <option value="44">China</option>
                                                    <option value="45">Christmas Island</option>
                                                    <option value="46">Cocos Islands</option>
                                                    <option value="47">Colombia</option>
                                                    <option value="48">Comoros</option>
                                                    <option value="49">Congo</option>
                                                    <option value="51">Cook Islands</option>
                                                    <option value="52">Costa Rica</option>
                                                    <option value="53">Cote D'ivoire</option>
                                                    <option value="55">Cuba</option>
                                                    <option value="56">Cyprus</option>
                                                    <option value="57">Czech Republic</option>
                                                    <option value="114">Democratic People's Republic of Korea</option>
                                                    <option value="50">Democratic Republic of the Congo</option>
                                                    <option value="58">Denmark</option>
                                                    <option value="59">Djibouti</option>
                                                    <option value="60">Dominica</option>
                                                    <option value="62">East Timor</option>
                                                    <option value="63">Ecuador</option>
                                                    <option value="64">Egypt</option>
                                                    <option value="65">El Salvador</option>
                                                    <option value="66">Equatorial Guinea</option>
                                                    <option value="67">Eritrea</option>
                                                    <option value="68">Estonia</option>
                                                    <option value="69">Ethiopia</option>
                                                    <option value="70">Falkland Islands</option>
                                                    <option value="71">Faroe Islands</option>
                                                    <option value="72">Fiji</option>
                                                    <option value="73">Finland</option>
                                                    <option value="74">France</option>
                                                    <option value="75">French Guiana</option>
                                                    <option value="76">French Polynesia</option>
                                                    <option value="77">French Southern Territories</option>
                                                    <option value="78">Gabon</option>
                                                    <option value="79">Gambia</option>
                                                    <option value="80">Georgia</option>
                                                    <option value="81">Germany</option>
                                                    <option value="82">Ghana</option>
                                                    <option value="83">Gibraltar</option>
                                                    <option value="84">Greece</option>
                                                    <option value="85">Greenland</option>
                                                    <option value="86">Grenada</option>
                                                    <option value="87">Guadeloupe</option>
                                                    <option value="88">Guam</option>
                                                    <option value="89">Guatemala</option>
                                                    <option value="90">Guinea</option>
                                                    <option value="91">Guinea-Bissau</option>
                                                    <option value="92">Guyana</option>
                                                    <option value="93">Haiti</option>
                                                    <option value="94">Heard Island and Mcdonald Islands</option>
                                                    <option value="96">Honduras</option>
                                                    <option value="97">Hong Kong, China</option>
                                                    <option value="98">Hungary</option>
                                                    <option value="99">Iceland</option>
                                                    <option value="100">India</option>
                                                    <option value="101">Indonesia</option>
                                                    <option value="102">Iran</option>
                                                    <option value="103">Iraq</option>
                                                    <option value="104">Ireland</option>
                                                    <option value="105">Israel</option>
                                                    <option value="106">Italy</option>
                                                    <option value="107">Jamaica</option>
                                                    <option value="108">Japan</option>
                                                    <option value="109">Jordan</option>
                                                    <option value="110">Kazakhstan</option>
                                                    <option value="111">Kenya</option>
                                                    <option value="112">Kiribati</option>
                                                    <option value="113">Korea</option>
                                                    <option value="115">Kuwait</option>
                                                    <option value="116">Kyrgyzstan</option>
                                                    <option value="117">Laos</option>
                                                    <option value="118">Latvia</option>
                                                    <option value="119">Lebanon</option>
                                                    <option value="120">Lesotho</option>
                                                    <option value="121">Liberia</option>
                                                    <option value="123">Liechtenstein</option>
                                                    <option value="124">Lithuania</option>
                                                    <option value="125">Luxembourg</option>
                                                    <option value="126">Macau, China</option>
                                                    <option value="127">Macedonia</option>
                                                    <option value="128">Madagascar</option>
                                                    <option value="129">Malawi</option>
                                                    <option value="130">Malaysia</option>
                                                    <option value="131">Maldives</option>
                                                    <option value="132">Mali</option>
                                                    <option value="133">Malta</option>
                                                    <option value="134">Marshall Islands</option>
                                                    <option value="135">Martinique</option>
                                                    <option value="136">Mauritania</option>
                                                    <option value="137">Mauritius</option>
                                                    <option value="138">Mayotte</option>
                                                    <option value="139">Mexico</option>
                                                    <option value="140">Micronesia</option>
                                                    <option value="141">Moldova</option>
                                                    <option value="142">Monaco</option>
                                                    <option value="143">Mongolia</option>
                                                    <option value="144">Montserrat</option>
                                                    <option value="145">Morocco</option>
                                                    <option value="146">Mozambique</option>
                                                    <option value="147">Myanmar</option>
                                                    <option value="148">Namibia</option>
                                                    <option value="149">Nauru</option>
                                                    <option value="150">Nepal</option>
                                                    <option value="151">Netherlands</option>
                                                    <option value="153">New Caledonia</option>
                                                    <option value="154">New Zealand</option>
                                                    <option value="155">Nicaragua</option>
                                                    <option value="156">Niger</option>
                                                    <option value="157">Nigeria</option>
                                                    <option value="158">Niue</option>
                                                    <option value="159">Norfolk Island</option>
                                                    <option value="160">Northern Mariana Islands</option>
                                                    <option value="161">Norway</option>
                                                    <option value="162">Oman</option>
                                                    <option value="163">Pakistan</option>
                                                    <option value="164">Palau</option>
                                                    <option value="165">Palestine</option>
                                                    <option value="166">Panama</option>
                                                    <option value="167">Papua New Guinea</option>
                                                    <option value="168">Paraguay</option>
                                                    <option value="169">Peru</option>
                                                    <option value="170">Philippines</option>
                                                    <option value="171">Pitcairn Islands</option>
                                                    <option value="172">Poland</option>
                                                    <option value="173">Portugal</option>
                                                    <option value="174">Puerto Rico</option>
                                                    <option value="175">Qatar</option>
                                                    <option value="176">Reunion</option>
                                                    <option value="177">Romania</option>
                                                    <option value="178">Russia</option>
                                                    <option value="179">Rwanda</option>
                                                    <option value="180">Saint Helena</option>
                                                    <option value="181">Saint Kitts and Nevis</option>
                                                    <option value="182">Saint Lucia</option>
                                                    <option value="184">Saint Pierre and Miquelon</option>
                                                    <option value="152">Saint Vincent and the Grenadines</option>
                                                    <option value="185">San Marino</option>
                                                    <option value="186">Sao Tome and Principe</option>
                                                    <option value="187">Saudi Arabia</option>
                                                    <option value="188">Senegal</option>
                                                    <option value="189">Serbia</option>
                                                    <option value="190">Seychelles</option>
                                                    <option value="191">Sierra Leone</option>
                                                    <option value="192">Singapore</option>
                                                    <option value="193">Slovakia</option>
                                                    <option value="194">Slovenia</option>
                                                    <option value="233">Socialist Republic of Vietnam</option>
                                                    <option value="195">Solomon Islands</option>
                                                    <option value="196">Somalia</option>
                                                    <option value="197">South Africa</option>
                                                    <option value="198">South Georgia and The South Sandwich Islands
                                                    </option>
                                                    <option value="199">Spain</option>
                                                    <option value="200">Sri Lanka</option>
                                                    <option value="122">State of Libya</option>
                                                    <option value="201">Sudan</option>
                                                    <option value="202">Suriname</option>
                                                    <option value="203">Svalbard and Jan Mayen</option>
                                                    <option value="204">Swaziland</option>
                                                    <option value="205">Sweden</option>
                                                    <option value="206">Switzerland</option>
                                                    <option value="207">Syrian Arab Republic</option>
                                                    <option value="208">TaiWan, China</option>
                                                    <option value="209">Tajikistan</option>
                                                    <option value="210">Tanzania</option>
                                                    <option value="211">Thailand</option>
                                                    <option value="54">The Republic of Croatia</option>
                                                    <option value="212">Togo</option>
                                                    <option value="213">Tokelau</option>
                                                    <option value="214">Tonga</option>
                                                    <option value="215">Trinidad and Tobago</option>
                                                    <option value="216">Tunisia</option>
                                                    <option value="217">Turkey</option>
                                                    <option value="218">Turkmenistan</option>
                                                    <option value="219">Turks and Caicos Islands</option>
                                                    <option value="220">Tuvalu</option>
                                                    <option value="221">Uganda</option>
                                                    <option value="222">Ukraine</option>
                                                    <option value="223">United Arab Emirates</option>
                                                    <option value="224">United Kingdom</option>
                                                    <option value="226">United States</option>
                                                    <option value="225">United States Minor Outlying Islands</option>
                                                    <option value="227">Uruguay</option>
                                                    <option value="228">US Virgin Islands</option>
                                                    <option value="230">Uzbekistan</option>
                                                    <option value="231">Vanuatu</option>
                                                    <option value="238">Vatican City State</option>
                                                    <option value="232">Venezuela</option>
                                                    <option value="234">Wallis and Futuna Islands</option>
                                                    <option value="235">Western Sahara</option>
                                                    <option value="236">Western Samoa</option>
                                                    <option value="237">Yemen</option>
                                                    <option value="239">Zambia</option>
                                                    <option value="240">Zimbabwe</option>
                                                    <option value="260">中国</option>
                                                </optgroup>
                                            </select>
                                            <div id="country_chzn" class="chzn-container chzn-container-single"
                                                 style="width:310px">
                                                <a href="javascript:void(0)"
                                                   class="chzn-single"><span>Please select---</span>
                                                    <div><b></b></div>
                                                </a>
                                                <div class="chzn-drop" style="left: -9000px; width: 308px;">
                                                    <div class="chzn-search clearfix"><input type="text"
                                                                                             autocomplete="off"
                                                                                             class=""></div>
                                                    <ul class="chzn-results">
                                                        <li class="group-result active-result">---------</li>
                                                        <li class="group-option active-result">Afghanistan</li>
                                                        <li class="group-option active-result">Australia</li>
                                                        <li class="group-option active-result">Brazil</li>
                                                        <li class="group-option active-result">Canada</li>
                                                        <li class="group-option active-result">France</li>
                                                        <li class="group-option active-result">Germany</li>
                                                        <li class="group-option active-result">Italy</li>
                                                        <li class="group-option active-result">Spain</li>
                                                        <li class="group-option active-result">Switzerland</li>
                                                        <li class="group-option active-result">United Kingdom</li>
                                                        <li class="group-option active-result">United States</li>
                                                        <li class="group-result active-result">---------</li>
                                                        <li class="group-option active-result">Afghanistan</li>
                                                        <li class="group-option active-result">Albania</li>
                                                        <li class="group-option active-result">Algeria</li>
                                                        <li class="group-option active-result">American Samoa</li>
                                                        <li class="group-option active-result">Andorra</li>
                                                        <li class="group-option active-result">Angola</li>
                                                        <li class="group-option active-result">Anguilla</li>
                                                        <li class="group-option active-result">Antigua and Barbuda</li>
                                                        <li class="group-option active-result">Argentina</li>
                                                        <li class="group-option active-result">Armenia</li>
                                                        <li class="group-option active-result">Aruba</li>
                                                        <li class="group-option active-result">Australia</li>
                                                        <li class="group-option active-result">Austria</li>
                                                        <li class="group-option active-result">Azerbaijan</li>
                                                        <li class="group-option active-result">Bahamas</li>
                                                        <li class="group-option active-result">Bahrain</li>
                                                        <li class="group-option active-result">Bangladesh</li>
                                                        <li class="group-option active-result">Barbados</li>
                                                        <li class="group-option active-result">Belarus</li>
                                                        <li class="group-option active-result">Belgium</li>
                                                        <li class="group-option active-result">Belize</li>
                                                        <li class="group-option active-result">Benin</li>
                                                        <li class="group-option active-result">Bermuda</li>
                                                        <li class="group-option active-result">Bhutan</li>
                                                        <li class="group-option active-result">Bolivia</li>
                                                        <li class="group-option active-result">Bosnia and Herzegovina
                                                        </li>
                                                        <li class="group-option active-result">Botswana</li>
                                                        <li class="group-option active-result">Bouvet Island</li>
                                                        <li class="group-option active-result">Brazil</li>
                                                        <li class="group-option active-result">British Indian Ocean
                                                            Territory
                                                        </li>
                                                        <li class="group-option active-result">Brunei Darussalam</li>
                                                        <li class="group-option active-result">Bulgaria</li>
                                                        <li class="group-option active-result">Burkina Faso</li>
                                                        <li class="group-option active-result">Burundi</li>
                                                        <li class="group-option active-result">Cambodia</li>
                                                        <li class="group-option active-result">Cameroon</li>
                                                        <li class="group-option active-result">Canada</li>
                                                        <li class="group-option active-result">Cape Verde</li>
                                                        <li class="group-option active-result">Cayman Islands</li>
                                                        <li class="group-option active-result">Central African
                                                            Republic
                                                        </li>
                                                        <li class="group-option active-result">Chad</li>
                                                        <li class="group-option active-result">Chile</li>
                                                        <li class="group-option active-result">China</li>
                                                        <li class="group-option active-result">Christmas Island</li>
                                                        <li class="group-option active-result">Cocos Islands</li>
                                                        <li class="group-option active-result">Colombia</li>
                                                        <li class="group-option active-result">Comoros</li>
                                                        <li class="group-option active-result">Congo</li>
                                                        <li class="group-option active-result">Cook Islands</li>
                                                        <li class="group-option active-result">Costa Rica</li>
                                                        <li class="group-option active-result">Cote D'ivoire</li>
                                                        <li class="group-option active-result">Cuba</li>
                                                        <li class="group-option active-result">Cyprus</li>
                                                        <li class="group-option active-result">Czech Republic</li>
                                                        <li class="group-option active-result">Democratic People's
                                                            Republic of Korea
                                                        </li>
                                                        <li class="group-option active-result">Democratic Republic of
                                                            the Congo
                                                        </li>
                                                        <li class="group-option active-result">Denmark</li>
                                                        <li class="group-option active-result">Djibouti</li>
                                                        <li class="group-option active-result">Dominica</li>
                                                        <li class="group-option active-result">East Timor</li>
                                                        <li class="group-option active-result">Ecuador</li>
                                                        <li class="group-option active-result">Egypt</li>
                                                        <li class="group-option active-result">El Salvador</li>
                                                        <li class="group-option active-result">Equatorial Guinea</li>
                                                        <li class="group-option active-result">Eritrea</li>
                                                        <li class="group-option active-result">Estonia</li>
                                                        <li class="group-option active-result">Ethiopia</li>
                                                        <li class="group-option active-result">Falkland Islands</li>
                                                        <li class="group-option active-result">Faroe Islands</li>
                                                        <li class="group-option active-result">Fiji</li>
                                                        <li class="group-option active-result">Finland</li>
                                                        <li class="group-option active-result">France</li>
                                                        <li class="group-option active-result">French Guiana</li>
                                                        <li class="group-option active-result">French Polynesia</li>
                                                        <li class="group-option active-result">French Southern
                                                            Territories
                                                        </li>
                                                        <li class="group-option active-result">Gabon</li>
                                                        <li class="group-option active-result">Gambia</li>
                                                        <li class="group-option active-result">Georgia</li>
                                                        <li class="group-option active-result">Germany</li>
                                                        <li class="group-option active-result">Ghana</li>
                                                        <li class="group-option active-result">Gibraltar</li>
                                                        <li class="group-option active-result">Greece</li>
                                                        <li class="group-option active-result">Greenland</li>
                                                        <li class="group-option active-result">Grenada</li>
                                                        <li class="group-option active-result">Guadeloupe</li>
                                                        <li class="group-option active-result">Guam</li>
                                                        <li class="group-option active-result">Guatemala</li>
                                                        <li class="group-option active-result">Guinea</li>
                                                        <li class="group-option active-result">Guinea-Bissau</li>
                                                        <li class="group-option active-result">Guyana</li>
                                                        <li class="group-option active-result">Haiti</li>
                                                        <li class="group-option active-result">Heard Island and Mcdonald
                                                            Islands
                                                        </li>
                                                        <li class="group-option active-result">Honduras</li>
                                                        <li class="group-option active-result">Hong Kong, China</li>
                                                        <li class="group-option active-result">Hungary</li>
                                                        <li class="group-option active-result">Iceland</li>
                                                        <li class="group-option active-result">India</li>
                                                        <li class="group-option active-result">Indonesia</li>
                                                        <li class="group-option active-result">Iran</li>
                                                        <li class="group-option active-result">Iraq</li>
                                                        <li class="group-option active-result">Ireland</li>
                                                        <li class="group-option active-result">Israel</li>
                                                        <li class="group-option active-result">Italy</li>
                                                        <li class="group-option active-result">Jamaica</li>
                                                        <li class="group-option active-result">Japan</li>
                                                        <li class="group-option active-result">Jordan</li>
                                                        <li class="group-option active-result">Kazakhstan</li>
                                                        <li class="group-option active-result">Kenya</li>
                                                        <li class="group-option active-result">Kiribati</li>
                                                        <li class="group-option active-result">Korea</li>
                                                        <li class="group-option active-result">Kuwait</li>
                                                        <li class="group-option active-result">Kyrgyzstan</li>
                                                        <li class="group-option active-result">Laos</li>
                                                        <li class="group-option active-result">Latvia</li>
                                                        <li class="group-option active-result">Lebanon</li>
                                                        <li class="group-option active-result">Lesotho</li>
                                                        <li class="group-option active-result">Liberia</li>
                                                        <li class="group-option active-result">Liechtenstein</li>
                                                        <li class="group-option active-result">Lithuania</li>
                                                        <li class="group-option active-result">Luxembourg</li>
                                                        <li class="group-option active-result">Macau, China</li>
                                                        <li class="group-option active-result">Macedonia</li>
                                                        <li class="group-option active-result">Madagascar</li>
                                                        <li class="group-option active-result">Malawi</li>
                                                        <li class="group-option active-result">Malaysia</li>
                                                        <li class="group-option active-result">Maldives</li>
                                                        <li class="group-option active-result">Mali</li>
                                                        <li class="group-option active-result">Malta</li>
                                                        <li class="group-option active-result">Marshall Islands</li>
                                                        <li class="group-option active-result">Martinique</li>
                                                        <li class="group-option active-result">Mauritania</li>
                                                        <li class="group-option active-result">Mauritius</li>
                                                        <li class="group-option active-result">Mayotte</li>
                                                        <li class="group-option active-result">Mexico</li>
                                                        <li class="group-option active-result">Micronesia</li>
                                                        <li class="group-option active-result">Moldova</li>
                                                        <li class="group-option active-result">Monaco</li>
                                                        <li class="group-option active-result">Mongolia</li>
                                                        <li class="group-option active-result">Montserrat</li>
                                                        <li class="group-option active-result">Morocco</li>
                                                        <li class="group-option active-result">Mozambique</li>
                                                        <li class="group-option active-result">Myanmar</li>
                                                        <li class="group-option active-result">Namibia</li>
                                                        <li class="group-option active-result">Nauru</li>
                                                        <li class="group-option active-result">Nepal</li>
                                                        <li class="group-option active-result">Netherlands</li>
                                                        <li class="group-option active-result">New Caledonia</li>
                                                        <li class="group-option active-result">New Zealand</li>
                                                        <li class="group-option active-result">Nicaragua</li>
                                                        <li class="group-option active-result">Niger</li>
                                                        <li class="group-option active-result">Nigeria</li>
                                                        <li class="group-option active-result">Niue</li>
                                                        <li class="group-option active-result">Norfolk Island</li>
                                                        <li class="group-option active-result">Northern Mariana
                                                            Islands
                                                        </li>
                                                        <li class="group-option active-result">Norway</li>
                                                        <li class="group-option active-result">Oman</li>
                                                        <li class="group-option active-result">Pakistan</li>
                                                        <li class="group-option active-result">Palau</li>
                                                        <li class="group-option active-result">Palestine</li>
                                                        <li class="group-option active-result">Panama</li>
                                                        <li class="group-option active-result">Papua New Guinea</li>
                                                        <li class="group-option active-result">Paraguay</li>
                                                        <li class="group-option active-result">Peru</li>
                                                        <li class="group-option active-result">Philippines</li>
                                                        <li class="group-option active-result">Pitcairn Islands</li>
                                                        <li class="group-option active-result">Poland</li>
                                                        <li class="group-option active-result">Portugal</li>
                                                        <li class="group-option active-result">Puerto Rico</li>
                                                        <li class="group-option active-result">Qatar</li>
                                                        <li class="group-option active-result">Reunion</li>
                                                        <li class="group-option active-result">Romania</li>
                                                        <li class="group-option active-result">Russia</li>
                                                        <li class="group-option active-result">Rwanda</li>
                                                        <li class="group-option active-result">Saint Helena</li>
                                                        <li class="group-option active-result">Saint Kitts and Nevis
                                                        </li>
                                                        <li class="group-option active-result">Saint Lucia</li>
                                                        <li class="group-option active-result">Saint Pierre and
                                                            Miquelon
                                                        </li>
                                                        <li class="group-option active-result">Saint Vincent and the
                                                            Grenadines
                                                        </li>
                                                        <li class="group-option active-result">San Marino</li>
                                                        <li class="group-option active-result">Sao Tome and Principe
                                                        </li>
                                                        <li class="group-option active-result">Saudi Arabia</li>
                                                        <li class="group-option active-result">Senegal</li>
                                                        <li class="group-option active-result">Serbia</li>
                                                        <li class="group-option active-result">Seychelles</li>
                                                        <li class="group-option active-result">Sierra Leone</li>
                                                        <li class="group-option active-result">Singapore</li>
                                                        <li class="group-option active-result">Slovakia</li>
                                                        <li class="group-option active-result">Slovenia</li>
                                                        <li class="group-option active-result">Socialist Republic of
                                                            Vietnam
                                                        </li>
                                                        <li class="group-option active-result">Solomon Islands</li>
                                                        <li class="group-option active-result">Somalia</li>
                                                        <li class="group-option active-result">South Africa</li>
                                                        <li class="group-option active-result">South Georgia and The
                                                            South Sandwich Islands
                                                        </li>
                                                        <li class="group-option active-result">Spain</li>
                                                        <li class="group-option active-result">Sri Lanka</li>
                                                        <li class="group-option active-result">State of Libya</li>
                                                        <li class="group-option active-result">Sudan</li>
                                                        <li class="group-option active-result">Suriname</li>
                                                        <li class="group-option active-result">Svalbard and Jan Mayen
                                                        </li>
                                                        <li class="group-option active-result">Swaziland</li>
                                                        <li class="group-option active-result">Sweden</li>
                                                        <li class="group-option active-result">Switzerland</li>
                                                        <li class="group-option active-result">Syrian Arab Republic</li>
                                                        <li class="group-option active-result">TaiWan, China</li>
                                                        <li class="group-option active-result">Tajikistan</li>
                                                        <li class="group-option active-result">Tanzania</li>
                                                        <li class="group-option active-result">Thailand</li>
                                                        <li class="group-option active-result">The Republic of Croatia
                                                        </li>
                                                        <li class="group-option active-result">Togo</li>
                                                        <li class="group-option active-result">Tokelau</li>
                                                        <li class="group-option active-result">Tonga</li>
                                                        <li class="group-option active-result">Trinidad and Tobago</li>
                                                        <li class="group-option active-result">Tunisia</li>
                                                        <li class="group-option active-result">Turkey</li>
                                                        <li class="group-option active-result">Turkmenistan</li>
                                                        <li class="group-option active-result">Turks and Caicos
                                                            Islands
                                                        </li>
                                                        <li class="group-option active-result">Tuvalu</li>
                                                        <li class="group-option active-result">Uganda</li>
                                                        <li class="group-option active-result">Ukraine</li>
                                                        <li class="group-option active-result">United Arab Emirates</li>
                                                        <li class="group-option active-result">United Kingdom</li>
                                                        <li class="group-option active-result">United States</li>
                                                        <li class="group-option active-result">United States Minor
                                                            Outlying Islands
                                                        </li>
                                                        <li class="group-option active-result">Uruguay</li>
                                                        <li class="group-option active-result">US Virgin Islands</li>
                                                        <li class="group-option active-result">Uzbekistan</li>
                                                        <li class="group-option active-result">Vanuatu</li>
                                                        <li class="group-option active-result">Vatican City State</li>
                                                        <li class="group-option active-result">Venezuela</li>
                                                        <li class="group-option active-result">Wallis and Futuna
                                                            Islands
                                                        </li>
                                                        <li class="group-option active-result">Western Sahara</li>
                                                        <li class="group-option active-result">Western Samoa</li>
                                                        <li class="group-option active-result">Yemen</li>
                                                        <li class="group-option active-result">Zambia</li>
                                                        <li class="group-option active-result">Zimbabwe</li>
                                                        <li class="group-option active-result">中国</li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <p class="errorInfo"></p>
                                        </td>
                                    </tr>
                                    <tr id="taxCode" style="display: none;">
                                        <th><span class="required">*</span><label>CPF or CNPJ code:</label></th>
                                        <td>
                                            <select name="tax_code_type" class="taxCodeOption" id="taxCodeOption"
                                                    disabled="">
                                                <option value="1" selected="selected">CPF (personal order)</option>
                                                <option value="2">CNPJ (company order)</option>
                                            </select>
                                            <input type="text" name="tax_code_value" id="taxCodeValue" maxlength="11"
                                                   class="taxCodeValue elmbBlur" disabled=""/>
                                            <p class="lightGray">Please only input numbers, no dots, dashes or other
                                                characters.</p>
                                            <p class="errorInfo"></p>
                                        </td>
                                    </tr>
                                    <tr id="tariffCode" style="display: none;">
                                        <th><span class="required">*</span><label>Personal or VAT ID</label></th>
                                        <td>
                                            <select name="tax_code_type" class="tariffCodeOption" id="tariffCodeOption"
                                                    disabled="">
                                                <option value="3" selected="selected">My personal details</option>
                                                <option value="4">VAT ID number (company order)</option>
                                            </select>
                                            <input type="text" name="tax_code_value" id="tariffCodeValue" maxlength="14"
                                                   class="tariffCodeValue elmbBlur" disabled=""/>
                                            <a href="javascript:void(0);" class="lightGray askTipsTariff"
                                               title="Your Personal ID/VAT ID number is required to ensure successful delivery of your order.">Why
                                                ask?</a>
                                            <p class="lightGray">Please only input numbers, no dots, dashes or other
                                                characters.</p>
                                            <p class="errorInfo"></p>
                                        </td>
                                    </tr>
                                    <tr id="zoneId" style="">
                                        <th><span class="required">*</span><label>State / Province / Region:</label>
                                        </th>
                                        <td>
                                            <select name="Province" placeholder="Please select---" class="chzn-done"
                                                    style="display:none;">
                                                <option value="-1"></option>
                                            </select>
                                            <div class="chzn-container chzn-container-single" style="width:310px">
                                                <a href="javascript:void(0)" class="chzn-single" tabindex="0">
                                                    <span>Please select---</span>
                                                    <div><b></b></div>
                                                </a>
                                                <div class="chzn-drop" style="left: -9000px; width: 308px;">
                                                    <div class="chzn-search clearfix">
                                                        <input type="text" autocomplete="off" tabindex="-1" class="">
                                                    </div>
                                                    <ul class="chzn-results"></ul>
                                                </div>
                                            </div>
                                            <p class="errorInfo"></p>
                                        </td>
                                    </tr>
                                    <tr id="state" style="display: none;">
                                        <th><label>State / Province / Region:</label></th>
                                        <td>
                                            <input type="text" name="State" maxlength="32" class="elmbBlur" disabled=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th><span class="required">*</span><label>City:</label></th>
                                        <td>
                                            <input type="text" name="City" maxlength="30" class="elmbBlur"/>
                                            <p class="errorInfo"></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th><span class="required">*</span><label>Address Line 1:</label></th>
                                        <td>
                                            <input type="text" name="AddressLine1" maxlength="100" class="elmbBlur"/>
                                            <p class="errorInfo"></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th><label>Address Line 2:</label></th>
                                        <td><input type="text" name="AddressLine2" maxlength="100" class="elmbBlur"/>
                                            <p class="lightGray">Example: apartment, suite, unit, building, floor</p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th><span class="required">*</span><label>Phone Number:</label></th>
                                        <td>
                                            <input id="countryCode" class="left countryCode" name="CountryCode"
                                                   type="text" value="+0000" readonly>
                                            <div class="left editableSelect hasLayout">
                                                <input type="text" name="PhoneNumber" class="phoneNum elmbBlur" maxlength="15" autocomplete="off"/>
                                                <ul id="otherPhones"></ul>
                                                <p class="errorInfo"></p>
                                            </div>
                                            <a href="javascript:void(0);" class="lightGray askTips"
                                               title="We ask for your phone number just in case we need to reach you regarding your order.">Why
                                                ask?
                                            </a>
                                            <p id="phoneSample" class="lightGray clearfix">Example: +<span>0000</span>
                                                9549031647-535</p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th></th>
                                        <td>
                                            <button id="useAddress" type="submit" class="textbtn">Save</button>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <input type="reset" id="resetAddr" style="display:none;">
                                <input type="hidden" name="typeAddr" value="0"/>


                            </form>
                        </div>
                    </li>
                </ul>
                <div class="clear"></div>
            </div>
        </div>
        <div class="cartBox" id="shippingObj">
            <h2>Shipping & Delivery</h2>
            <div class="contents shipping">
                <ul data-id="1">
                    <li class="title">China</li>
                    <li class="list">
                        <dl>
                            <dt>Shipping Method:</dt>
                            <dd>
                                <ul class="shipping_method_list"></ul>
                            </dd>
                        </dl>
                    </li>
                    <li class="insurance">
                        <dl>
                            <dt>Insurance:</dt>
                            <dd>
                                <input type="checkbox" name="_shipping_method_insurance" class="shipping_insurance"
                                       value="1" checked="checked"/>
                                <label for="shipping_insurance">Add Shipping Insurance to your order</label>
                                <a class="delivery_ins" href="javascript:;"
                                   content="Shipping insurance offers premium protection and safety for your valuable items during international shipping. We'll reship your package immediately at no extra charge if it's reported lost or damaged.">Why
                                    get insurance?</a>
                            </dd>
                            <dd class="price">$<em>0.99</em></dd>
                        </dl>
                    </li>
                    <li class="tips">When will my order arrive?</li>
                    <li class="editor_txt"></li>
                </ul>
            </div>
        </div>
        <div class="cartBox" id="paymentObj">
            <h2>Payment Method</h2>
            <div class="contents payment">
                <h3>Choose payment method:</h3>
                <select name="_payment_method">
                    <option value="-1">Please select your payment method</option>
                    <option value="1" min="0" max="0">Paypal</option>
                    <option value="5" min="0" max="0">PayEasy</option>
                    <option value="6" min="0" max="0">DHpay</option>
                    <option value="7" min="0" max="0">Western Union</option>
                    <option value="8" min="0" max="0">Money Gram</option>
                    <option value="10" min="0" max="0">T/T</option>
                    <option value="11" min="0" max="0">Bank Transfer</option>
                    <option value="9" min="0" max="0">Cash On Delivery</option>
                </select>
                <div class="blank12"></div>
                <ul>
                    <li style="display:block;">Please select your payment method</li>
                    <li class="editor_txt" id="payment_contents_1" fee="0.00" affix="0.00"><p>Paypal</p></li>
                    <li class="editor_txt" id="payment_contents_5" fee="3.00" affix="0.00"><p>PayEasy en</p></li>
                    <li class="editor_txt" id="payment_contents_6" fee="0.00" affix="0.00"><p>DHpay en</p></li>
                    <li class="editor_txt" id="payment_contents_7" fee="0.00" affix="0.00">
                        <table class="cartInfo" width="100%">
                            <tbody>
                            <tr class="firstRow">
                                <th>NAME:</th>
                                <td>LIGHT IN THE BOX LIMITED</td>
                            </tr>
                            <tr>
                                <th>ACCOUNT:</th>
                                <td>808-383277-838</td>
                            </tr>
                            <tr>
                                <th>BANK NAME:</th>
                                <td>THE HONGKONG AND SHANGHAI BANKING CORPORATION LIMITED</td>
                            </tr>
                            <tr>
                                <th>SWIFT CODE:</th>
                                <td>HSBCHKHHHKH</td>
                            </tr>
                            <tr>
                                <th>BANK ADDRESS:</th>
                                <td>1 QUEEN&#39;S ROAD CENTRAL, HONG KONG</td>
                            </tr>
                            </tbody>
                        </table>
                        <p><strong>Note:</strong> <br/>
                            1. Our international banking partner, HSBC, doesn&#39;t require an IBAN number, please use
                            the information above for your wire transfer.<br/>
                            2. We recommend using your local HSBC bank for the wire transfer to reduce international
                            transaction fees.<br/>
                            3. Customers choosing wire transfer are responsible for all local handling fees and
                            intermediary bank handling fees.</p></li>
                    <li class="editor_txt" id="payment_contents_8" fee="0.00" affix="0.00"><p>Money Gram</p></li>
                    <li class="editor_txt" id="payment_contents_10" fee="0.00" affix="0.00"><p>T/T</p></li>
                    <li class="editor_txt" id="payment_contents_11" fee="0.00" affix="0.00"><p>Bank Transfer</p></li>
                    <li class="editor_txt" id="payment_contents_9" fee="0.00" affix="0.00"><p>Cash On Delivery</p></li>
                </ul>
                <div class="new-coupon">
                    <p id="new-coupon-valid">
                        <span class="valid" style="display:none;">The coupon code "<strong></strong>" is valid! Your discount is <span
                                class="red"></span> (expiration date: <strong></strong>)<br/></span>
                    </p>
                    <p><a href="javascript:;" class="u" id="removeCoupon">Remove</a></p>
                    <p id="new-cp"><a href="javascript:;" id="to-use-coupon">Apply Coupon Code<i> </i> </a></p>
                    <p id="link-error"><span class="netError red" style="display: none;"></span></p>
                </div>
            </div>
        </div>
        <form id="PlaceOrderFrom" method="post" action="/cart/" amountPrice="7.99" userPrice="0" userRatio="100">
            <div class="NoteBox">
                <h2>Note: If you choose Paypal as payment method, please leave us your Paypal email address right here
                    for payment confirmation on our end.</h2>
                <div class="notes"><textarea name="Note"></textarea></div>
            </div>
            <div class="CartAmountSum">
                <table id="subTotal" cellpadding="0" cellspacing="0" border="0" width="100%">
                    <!-- Grand Total -->
                    <tfoot>
                    <tr id="cartAmount" style="display: table-row;">
                        <th width="100%">Grand Total:<em>$</em></th>
                        <td><strong id="ot_total">${total+freight}</strong></td>
                    </tr>
                    </tfoot>
                    <tbody>

                    <tr style="display: table-row;">
                        <!-- subtotal -->
                        <th>Subtotal( ${goodslist.size()} items ):<em>$</em></th>
                        <td><strong id="ot_subtotal">${total}</strong></td>
                    </tr>


                    <tr id="shippingCharges" style="display: none;">
                        <!-- Shipping Charges-->
                        <th>(+) Shipping Charges:<em>$</em></th>
                        <td><strong id="ot_shipping"></strong></td>
                    </tr>

                    <tr id="shippingInsuranceCombine" style="display: table-row;">
                        <!-- Shipping Insurance combine-->
                        <th>(+) Shipping Charges &amp; Insurance:<em>$</em></th>
                        <td><strong id="ot_combine_shippnig_insurance">${freight}</strong></td>
                    </tr>

                    <tr id="couponSavings" style="display: none;">
                        <!-- Coupon Savings -->
                        <th>(-) Coupon Savings:<em>- $</em></th>
                        <td><strong id="ot_coupon">0.00</strong></td>
                    </tr>

                    <tr id="serviceCharge" style="display: none;">
                        <!-- Service Charge -->
                        <th>(+) Service Charge:<em>$</em></th>
                        <td><strong id="ot_fee">0.00</strong></td>
                    </tr>

                    </tbody>
                </table>

                <input type="button" id="buy" class="paypal_checkout_button fr" onclick="javascript:void(0);"/>
                <%--<button class="paypal_checkout_button fr" onclick="javascript:void(0);"></button>--%>


                <%--<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">--%>
                    <%--<input type="hidden" name="cmd" value="_s-xclick">--%>
                    <%--<input type="hidden" name="hosted_button_id" value="9EXYX7WPS89PG">--%>
                    <%--<input type="image" src="https://www.paypalobjects.com/zh_XC/C2/i/btn/btn_buynowCC_LG.gif" border="0" name="submit" alt="PayPal——最安全便捷的在线支付方式！">--%>
                    <%--<img alt="" border="0" src="https://www.paypalobjects.com/zh_XC/i/scr/pixel.gif" width="1" height="1">--%>
                <%--</form>--%>


                <fieldset id="submitCart" class="clearfix">
                    <a href="javascript:;" class="fr"><input type="button" id="orderFormSubmit"
                                                             class="litb-btn placeOrderBtn"></a>
                    <p class="clearfix">Every order you place with us is safe and secure.</p>
                </fieldset>
            </div>
            <input type="hidden" name="order_coupon_code" value="" cutprice="0"/>
            <input type="hidden" name="order_discount_price" value="0"/>
            <input type="hidden" name="order_shipping_address_aid" value="-1"/>
            <input type="hidden" name="order_shipping_address_cid" value="-1"/>
            <input type="hidden" name="order_shipping_method_sid" value="[]"/>
            <input type="hidden" name="order_shipping_method_type" value="[]"/>
            <input type="hidden" name="order_shipping_price" value="[]"/>
            <input type="hidden" name="order_shipping_insurance" value="[]" price="[]"/>
            <input type="hidden" name="order_payment_method_pid" value="-1"/>
        </form>
    </div>
    <form name="paypal_checkout_form" method="POST" action="" class="hide">
        <input id="paypal_payment_option" value="paypal_express" type="radio" name="paymentMethod"
               title="PayPal Checkout" class="radio" style="display:none;" checked/>
        <input type="submit" value="Submit" id="paypal_now_checkout_button"/>
    </form>
    <script src="<%=basePath%>js/checkout.js" async></script> <!-- PayPal -->
    <script>
        window.paypalCheckoutReady = function () {
            paypal.checkout.setup("320006220@qq.com", {
                button: "paypal_now_checkout_button",
                environment: "production",
                condition: function () {
                    return document.getElementById("paypal_payment_option").checked === true;
                }
            });
        };
    </script>
</div>

<!-- 商品json -->
<input type="hidden" id="cart_json" value='${cart}'/>

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

<script type='text/javascript' src='<%=basePath%>js/user.js'></script>

</body>
</html>