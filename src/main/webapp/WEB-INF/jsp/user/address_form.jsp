<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/10/16
  Time: 14:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>AddressForm</title>

    <%--<link href='<%=basePath%>css/global.css' rel='stylesheet' type='text/css'/>--%>
    <%--<link href='<%=basePath%>css/global_1.css' rel='stylesheet' type='text/css'/>--%>
    <%--<link href='<%=basePath%>css/user.css' rel='stylesheet' type='text/css'/>--%>
    <%--<link href='<%=basePath%>css/style.css' rel='stylesheet' type='text/css'/>--%>

    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/addressform/style.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/addressform/css.css" />
    <script type='text/javascript' src='<%=basePath%>js/jquery-1.7.2.min.js' ></script>
    <script type='text/javascript' src='<%=basePath%>js/form.js' ></script>

    <!-- layer -->
    <script type="text/javascript" src="<%=basePath%>js/layer.js" ></script>

    <script type="text/javascript">
        $(function () {
            //新增
            $("#sub_new").on("click",function () {
                $("#subForm").ajaxSubmit({
                    beforeSubmit: function () {

                    },
                    success:function (date) {
                        console.log(date);
                        if(date=="false")
                        {
                            parent.window.location.reload();
                            var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                            parent.layer.close(index);
                            window.location.href="<%=basePath%>login_register";
                        }
                        else if(date=="true")
                        {
                            alert("添加成功");
                            parent.window.location.reload();
                            var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                            parent.layer.close(index);
                        }

                    },
                    error : function(data) {
                        alert("错误");
                    }
                })

            });

            //修改
            $("#sub_edit").on("click",function () {
                //地址id
                //var id=$("#address_id").val();
                //设置action
                $("#subForm").attr("action", "<%=basePath%>address/editAddressForm");

                $("#subForm").ajaxSubmit({
                    beforeSubmit: function () {

                    },
                    success:function (date) {
                        console.log(date);
                        if(date=="false")
                        {
                            parent.window.location.reload();
                            var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                            parent.layer.close(index);
                            window.location.href="<%=basePath%>login_register";
                        }
                        else if(date=="true")
                        {
                            alert("修改成功");
                            parent.window.location.reload();
                            var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                            parent.layer.close(index);
                        }

                    },
                    error : function(data) {
                        alert("错误");
                    }
                })

            });

            //设置默认
            $("#sub_default").on("click",function () {
                //地址id
                var id=$("#address_id").val();

                $.post("<%=basePath%>address/setDefault/"+id,function(result){
                    parent.window.location.reload();
                    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                    parent.layer.close(index);
                    window.location.href="<%=basePath%>address/AddressEdit";
                })

                <%--$.ajax({--%>
                    <%--url: "<%=basePath%>address/setDefault",--%>
                    <%--data: {"id": id},--%>
                    <%--type: "get",--%>
                    <%--dataType: "json",--%>
                    <%--success: function (data) {--%>
                        <%--if (data.msg == 'success') {--%>
                            <%--alert("删除成功");--%>
                            <%--window.location.href="<%=basePath%>address/AddressEdit";--%>
                        <%--} else {--%>
                            <%--alert("删除失败");--%>
                        <%--}--%>
                    <%--},--%>
                    <%--error: function () {--%>
                        <%--alert("请求失败");--%>
                    <%--}--%>
                <%--})--%>

            });


        })
    </script>
</head>
<body style="height: 100%">
    <form action="<%=basePath%>address/addNew" method="post" id="subForm">
        <c:if test="${not empty address}">
            <input type="hidden" id="address_id" name="id" value="${address.id}">
        </c:if>
        <div class="col-xs-12">
            <span class="span_style" id="area">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区</span>
            <input class="input_style" type="area" name="area" id="region" value="<c:if test="${not empty address}">${address.area}</c:if>" placeholder="&nbsp;&nbsp;请输入您的所在地区">
        </div>
        <div class="col-xs-12">
            <span class="span_style" id="province">省&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
            <input class="input_style" type="" name="province" id="province_" value="<c:if test="${not empty address}">${address.province}</c:if>" placeholder="&nbsp;&nbsp;请输入您的省">
        </div>
        <div class="col-xs-12">
            <span class="span_style" id="city">市&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
            <input class="input_style" type="" name="city" id="city_" value="<c:if test="${not empty address}">${address.city}</c:if>" placeholder="&nbsp;&nbsp;请输入您的市">
        </div>
        <div class="col-xs-12">
            <span class="span_style" id="detail">详细地址</span>
            <input class="input_style" type="" name="detail" id="address" value="<c:if test="${not empty address}">${address.detail}</c:if>" placeholder="&nbsp;&nbsp;请输入您的详细地址">
        </div>
        <div class="col-xs-12">
            <span class="span_style" id="zip">邮政编号</span>
            <input class="input_style" type="" name="zip" id="number_this" value="<c:if test="${not empty address}">${address.zip}</c:if>" placeholder="&nbsp;&nbsp;请输入您的邮政编号">
        </div>
        <div class="col-xs-12">
            <span class="span_style" id="recipient">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</span>
            <input class="input_style" type="" name="recipient" id="name_" value="<c:if test="${not empty address}">${address.recipient}</c:if>" placeholder="&nbsp;&nbsp;请输入您的姓名">
        </div>
        <div class="col-xs-12">
            <span class="span_style" id="tel">手机号码</span>
            <input class="input_style" type="" name="tel" id="tel_" value="<c:if test="${not empty address}">${address.tel}</c:if>" placeholder="&nbsp;&nbsp;请输入您的手机号码">
        </div>
        <div class="col-xs-12">
            <span class="span_style" id="phone">电话号码</span>
            <input class="input_style" type="" name="phone" id="phone_" value="<c:if test="${not empty address}">${address.phone}</c:if>" placeholder="&nbsp;&nbsp;请输入您的电话号码">
        </div>
        <div class="col-xs-12">
            <c:if test="${empty address}">
                <input type="button" class="sub_set" id="sub_new" value="提交">
            </c:if>
            <c:if test="${not empty address}">
                <input type="button" class="sub_set" id="sub_edit" value="修改">
                <c:if test="${address.ismain==0}">
                    <input type="button" class="sub_set" id="sub_default" value="设为默认">
                </c:if>

            </c:if>

        </div>
    </form>
<%--<div id="addressForm">--%>
    <%--<h3 class="big">Your Billing Address</h3>--%>
    <%--<div class="editAddr">--%>
        <%--<form id="address" method="post" action="<%=basePath%>address/test">--%>
            <%--<input id="addressId" type="hidden" name="edit_address_id" value="0">--%>
            <%--<a id="cancelAddr" class="cancel" href="javascript:;" style="display:;">Cancel</a>--%>
            <%--<p><span class="required">*</span>&nbsp;<span--%>
                    <%--class="indicates">Indicates required fields.</span></p>--%>
            <%--<table class="tb-shippingAddr">--%>
                <%--<tbody>--%>
                <%--<tr>--%>
                    <%--<th></th>--%>
                    <%--<td></td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<th><label>Your Name:</label></th>--%>
                    <%--<td class="recipient">--%>
                        <%--<div>--%>
                            <%--<input type="text" name="FirstName" maxlength="32" class="elmbBlur"/>--%>
                            <%--<p><span class="required">*</span>&nbsp;First Name</p>--%>
                            <%--<p class="errorInfo"></p>--%>
                        <%--</div>--%>
                        <%--<div>--%>
                            <%--<input type="text" name="LastName" maxlength="32" class="elmbBlur"/>--%>
                            <%--<p><span class="required">*</span>&nbsp;Last Name</p>--%>
                            <%--<p class="errorInfo"></p>--%>
                        <%--</div>--%>
                    <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<th><span class="required">*</span><label>ZIP / Postal Code:</label></th>--%>
                    <%--<td><input type="text" name="zip" maxlength="10" class="elmbBlur"/>--%>
                        <%--<p class="errorInfo"></p></td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<th><span class="required">*</span><label>Destination Country/Region:</label></th>--%>
                    <%--<td>--%>
                        <%--<select name="area" id="country" placeholder="Please Choose Your Country"--%>
                                <%--style="display:none;" class="chzn-done">--%>
                            <%--<option value="-1"></option>--%>
                            <%--<optgroup label="---------">--%>
                                <%--<option value="1">Afghanistan</option>--%>
                                <%--<option value="13">Australia</option>--%>
                                <%--<option value="30">Brazil</option>--%>
                                <%--<option value="38">Canada</option>--%>
                                <%--<option value="74">France</option>--%>
                                <%--<option value="81">Germany</option>--%>
                                <%--<option value="106">Italy</option>--%>
                                <%--<option value="199">Spain</option>--%>
                                <%--<option value="206">Switzerland</option>--%>
                                <%--<option value="224">United Kingdom</option>--%>
                                <%--<option value="226">United States</option>--%>
                            <%--</optgroup>--%>
                            <%--<optgroup label="---------">--%>
                                <%--<option value="1">Afghanistan</option>--%>
                                <%--<option value="2">Albania</option>--%>
                                <%--<option value="3">Algeria</option>--%>
                                <%--<option value="4">American Samoa</option>--%>
                                <%--<option value="5">Andorra</option>--%>
                                <%--<option value="6">Angola</option>--%>
                                <%--<option value="7">Anguilla</option>--%>
                                <%--<option value="9">Antigua and Barbuda</option>--%>
                                <%--<option value="10">Argentina</option>--%>
                                <%--<option value="11">Armenia</option>--%>
                                <%--<option value="12">Aruba</option>--%>
                                <%--<option value="13">Australia</option>--%>
                                <%--<option value="14">Austria</option>--%>
                                <%--<option value="15">Azerbaijan</option>--%>
                                <%--<option value="16">Bahamas</option>--%>
                                <%--<option value="17">Bahrain</option>--%>
                                <%--<option value="18">Bangladesh</option>--%>
                                <%--<option value="19">Barbados</option>--%>
                                <%--<option value="20">Belarus</option>--%>
                                <%--<option value="21">Belgium</option>--%>
                                <%--<option value="22">Belize</option>--%>
                                <%--<option value="23">Benin</option>--%>
                                <%--<option value="24">Bermuda</option>--%>
                                <%--<option value="25">Bhutan</option>--%>
                                <%--<option value="26">Bolivia</option>--%>
                                <%--<option value="27">Bosnia and Herzegovina</option>--%>
                                <%--<option value="28">Botswana</option>--%>
                                <%--<option value="29">Bouvet Island</option>--%>
                                <%--<option value="30">Brazil</option>--%>
                                <%--<option value="31">British Indian Ocean Territory</option>--%>
                                <%--<option value="32">Brunei Darussalam</option>--%>
                                <%--<option value="33">Bulgaria</option>--%>
                                <%--<option value="34">Burkina Faso</option>--%>
                                <%--<option value="35">Burundi</option>--%>
                                <%--<option value="36">Cambodia</option>--%>
                                <%--<option value="37">Cameroon</option>--%>
                                <%--<option value="38">Canada</option>--%>
                                <%--<option value="39">Cape Verde</option>--%>
                                <%--<option value="40">Cayman Islands</option>--%>
                                <%--<option value="41">Central African Republic</option>--%>
                                <%--<option value="42">Chad</option>--%>
                                <%--<option value="43">Chile</option>--%>
                                <%--<option value="44">China</option>--%>
                                <%--<option value="45">Christmas Island</option>--%>
                                <%--<option value="46">Cocos Islands</option>--%>
                                <%--<option value="47">Colombia</option>--%>
                                <%--<option value="48">Comoros</option>--%>
                                <%--<option value="49">Congo</option>--%>
                                <%--<option value="51">Cook Islands</option>--%>
                                <%--<option value="52">Costa Rica</option>--%>
                                <%--<option value="53">Cote D'ivoire</option>--%>
                                <%--<option value="55">Cuba</option>--%>
                                <%--<option value="56">Cyprus</option>--%>
                                <%--<option value="57">Czech Republic</option>--%>
                                <%--<option value="114">Democratic People's Republic of Korea</option>--%>
                                <%--<option value="50">Democratic Republic of the Congo</option>--%>
                                <%--<option value="58">Denmark</option>--%>
                                <%--<option value="59">Djibouti</option>--%>
                                <%--<option value="60">Dominica</option>--%>
                                <%--<option value="62">East Timor</option>--%>
                                <%--<option value="63">Ecuador</option>--%>
                                <%--<option value="64">Egypt</option>--%>
                                <%--<option value="65">El Salvador</option>--%>
                                <%--<option value="66">Equatorial Guinea</option>--%>
                                <%--<option value="67">Eritrea</option>--%>
                                <%--<option value="68">Estonia</option>--%>
                                <%--<option value="69">Ethiopia</option>--%>
                                <%--<option value="70">Falkland Islands</option>--%>
                                <%--<option value="71">Faroe Islands</option>--%>
                                <%--<option value="72">Fiji</option>--%>
                                <%--<option value="73">Finland</option>--%>
                                <%--<option value="74">France</option>--%>
                                <%--<option value="75">French Guiana</option>--%>
                                <%--<option value="76">French Polynesia</option>--%>
                                <%--<option value="77">French Southern Territories</option>--%>
                                <%--<option value="78">Gabon</option>--%>
                                <%--<option value="79">Gambia</option>--%>
                                <%--<option value="80">Georgia</option>--%>
                                <%--<option value="81">Germany</option>--%>
                                <%--<option value="82">Ghana</option>--%>
                                <%--<option value="83">Gibraltar</option>--%>
                                <%--<option value="84">Greece</option>--%>
                                <%--<option value="85">Greenland</option>--%>
                                <%--<option value="86">Grenada</option>--%>
                                <%--<option value="87">Guadeloupe</option>--%>
                                <%--<option value="88">Guam</option>--%>
                                <%--<option value="89">Guatemala</option>--%>
                                <%--<option value="90">Guinea</option>--%>
                                <%--<option value="91">Guinea-Bissau</option>--%>
                                <%--<option value="92">Guyana</option>--%>
                                <%--<option value="93">Haiti</option>--%>
                                <%--<option value="94">Heard Island and Mcdonald Islands</option>--%>
                                <%--<option value="96">Honduras</option>--%>
                                <%--<option value="97">Hong Kong, China</option>--%>
                                <%--<option value="98">Hungary</option>--%>
                                <%--<option value="99">Iceland</option>--%>
                                <%--<option value="100">India</option>--%>
                                <%--<option value="101">Indonesia</option>--%>
                                <%--<option value="102">Iran</option>--%>
                                <%--<option value="103">Iraq</option>--%>
                                <%--<option value="104">Ireland</option>--%>
                                <%--<option value="105">Israel</option>--%>
                                <%--<option value="106">Italy</option>--%>
                                <%--<option value="107">Jamaica</option>--%>
                                <%--<option value="108">Japan</option>--%>
                                <%--<option value="109">Jordan</option>--%>
                                <%--<option value="110">Kazakhstan</option>--%>
                                <%--<option value="111">Kenya</option>--%>
                                <%--<option value="112">Kiribati</option>--%>
                                <%--<option value="113">Korea</option>--%>
                                <%--<option value="115">Kuwait</option>--%>
                                <%--<option value="116">Kyrgyzstan</option>--%>
                                <%--<option value="117">Laos</option>--%>
                                <%--<option value="118">Latvia</option>--%>
                                <%--<option value="119">Lebanon</option>--%>
                                <%--<option value="120">Lesotho</option>--%>
                                <%--<option value="121">Liberia</option>--%>
                                <%--<option value="123">Liechtenstein</option>--%>
                                <%--<option value="124">Lithuania</option>--%>
                                <%--<option value="125">Luxembourg</option>--%>
                                <%--<option value="126">Macau, China</option>--%>
                                <%--<option value="127">Macedonia</option>--%>
                                <%--<option value="128">Madagascar</option>--%>
                                <%--<option value="129">Malawi</option>--%>
                                <%--<option value="130">Malaysia</option>--%>
                                <%--<option value="131">Maldives</option>--%>
                                <%--<option value="132">Mali</option>--%>
                                <%--<option value="133">Malta</option>--%>
                                <%--<option value="134">Marshall Islands</option>--%>
                                <%--<option value="135">Martinique</option>--%>
                                <%--<option value="136">Mauritania</option>--%>
                                <%--<option value="137">Mauritius</option>--%>
                                <%--<option value="138">Mayotte</option>--%>
                                <%--<option value="139">Mexico</option>--%>
                                <%--<option value="140">Micronesia</option>--%>
                                <%--<option value="141">Moldova</option>--%>
                                <%--<option value="142">Monaco</option>--%>
                                <%--<option value="143">Mongolia</option>--%>
                                <%--<option value="144">Montserrat</option>--%>
                                <%--<option value="145">Morocco</option>--%>
                                <%--<option value="146">Mozambique</option>--%>
                                <%--<option value="147">Myanmar</option>--%>
                                <%--<option value="148">Namibia</option>--%>
                                <%--<option value="149">Nauru</option>--%>
                                <%--<option value="150">Nepal</option>--%>
                                <%--<option value="151">Netherlands</option>--%>
                                <%--<option value="153">New Caledonia</option>--%>
                                <%--<option value="154">New Zealand</option>--%>
                                <%--<option value="155">Nicaragua</option>--%>
                                <%--<option value="156">Niger</option>--%>
                                <%--<option value="157">Nigeria</option>--%>
                                <%--<option value="158">Niue</option>--%>
                                <%--<option value="159">Norfolk Island</option>--%>
                                <%--<option value="160">Northern Mariana Islands</option>--%>
                                <%--<option value="161">Norway</option>--%>
                                <%--<option value="162">Oman</option>--%>
                                <%--<option value="163">Pakistan</option>--%>
                                <%--<option value="164">Palau</option>--%>
                                <%--<option value="165">Palestine</option>--%>
                                <%--<option value="166">Panama</option>--%>
                                <%--<option value="167">Papua New Guinea</option>--%>
                                <%--<option value="168">Paraguay</option>--%>
                                <%--<option value="169">Peru</option>--%>
                                <%--<option value="170">Philippines</option>--%>
                                <%--<option value="171">Pitcairn Islands</option>--%>
                                <%--<option value="172">Poland</option>--%>
                                <%--<option value="173">Portugal</option>--%>
                                <%--<option value="174">Puerto Rico</option>--%>
                                <%--<option value="175">Qatar</option>--%>
                                <%--<option value="176">Reunion</option>--%>
                                <%--<option value="177">Romania</option>--%>
                                <%--<option value="178">Russia</option>--%>
                                <%--<option value="179">Rwanda</option>--%>
                                <%--<option value="180">Saint Helena</option>--%>
                                <%--<option value="181">Saint Kitts and Nevis</option>--%>
                                <%--<option value="182">Saint Lucia</option>--%>
                                <%--<option value="184">Saint Pierre and Miquelon</option>--%>
                                <%--<option value="152">Saint Vincent and the Grenadines</option>--%>
                                <%--<option value="185">San Marino</option>--%>
                                <%--<option value="186">Sao Tome and Principe</option>--%>
                                <%--<option value="187">Saudi Arabia</option>--%>
                                <%--<option value="188">Senegal</option>--%>
                                <%--<option value="189">Serbia</option>--%>
                                <%--<option value="190">Seychelles</option>--%>
                                <%--<option value="191">Sierra Leone</option>--%>
                                <%--<option value="192">Singapore</option>--%>
                                <%--<option value="193">Slovakia</option>--%>
                                <%--<option value="194">Slovenia</option>--%>
                                <%--<option value="233">Socialist Republic of Vietnam</option>--%>
                                <%--<option value="195">Solomon Islands</option>--%>
                                <%--<option value="196">Somalia</option>--%>
                                <%--<option value="197">South Africa</option>--%>
                                <%--<option value="198">South Georgia and The South Sandwich Islands--%>
                                <%--</option>--%>
                                <%--<option value="199">Spain</option>--%>
                                <%--<option value="200">Sri Lanka</option>--%>
                                <%--<option value="122">State of Libya</option>--%>
                                <%--<option value="201">Sudan</option>--%>
                                <%--<option value="202">Suriname</option>--%>
                                <%--<option value="203">Svalbard and Jan Mayen</option>--%>
                                <%--<option value="204">Swaziland</option>--%>
                                <%--<option value="205">Sweden</option>--%>
                                <%--<option value="206">Switzerland</option>--%>
                                <%--<option value="207">Syrian Arab Republic</option>--%>
                                <%--<option value="208">TaiWan, China</option>--%>
                                <%--<option value="209">Tajikistan</option>--%>
                                <%--<option value="210">Tanzania</option>--%>
                                <%--<option value="211">Thailand</option>--%>
                                <%--<option value="54">The Republic of Croatia</option>--%>
                                <%--<option value="212">Togo</option>--%>
                                <%--<option value="213">Tokelau</option>--%>
                                <%--<option value="214">Tonga</option>--%>
                                <%--<option value="215">Trinidad and Tobago</option>--%>
                                <%--<option value="216">Tunisia</option>--%>
                                <%--<option value="217">Turkey</option>--%>
                                <%--<option value="218">Turkmenistan</option>--%>
                                <%--<option value="219">Turks and Caicos Islands</option>--%>
                                <%--<option value="220">Tuvalu</option>--%>
                                <%--<option value="221">Uganda</option>--%>
                                <%--<option value="222">Ukraine</option>--%>
                                <%--<option value="223">United Arab Emirates</option>--%>
                                <%--<option value="224">United Kingdom</option>--%>
                                <%--<option value="226">United States</option>--%>
                                <%--<option value="225">United States Minor Outlying Islands</option>--%>
                                <%--<option value="227">Uruguay</option>--%>
                                <%--<option value="228">US Virgin Islands</option>--%>
                                <%--<option value="230">Uzbekistan</option>--%>
                                <%--<option value="231">Vanuatu</option>--%>
                                <%--<option value="238">Vatican City State</option>--%>
                                <%--<option value="232">Venezuela</option>--%>
                                <%--<option value="234">Wallis and Futuna Islands</option>--%>
                                <%--<option value="235">Western Sahara</option>--%>
                                <%--<option value="236">Western Samoa</option>--%>
                                <%--<option value="237">Yemen</option>--%>
                                <%--<option value="239">Zambia</option>--%>
                                <%--<option value="240">Zimbabwe</option>--%>
                                <%--<option value="260">中国</option>--%>
                            <%--</optgroup>--%>
                        <%--</select>--%>
                        <%--<div id="country_chzn" class="chzn-container chzn-container-single"--%>
                             <%--style="width:310px">--%>
                            <%--<a href="javascript:void(0)"--%>
                               <%--class="chzn-single"><span>Please select---</span>--%>
                                <%--<div><b></b></div>--%>
                            <%--</a>--%>
                            <%--<div class="chzn-drop" style="left: -9000px; width: 308px;">--%>
                                <%--<div class="chzn-search clearfix"><input type="text" autocomplete="off"--%>
                                                                         <%--class=""></div>--%>
                                <%--<ul class="chzn-results">--%>
                                    <%--<li class="group-result active-result">---------</li>--%>
                                    <%--<li class="group-option active-result">Afghanistan</li>--%>
                                    <%--<li class="group-option active-result">Australia</li>--%>
                                    <%--<li class="group-option active-result">Brazil</li>--%>
                                    <%--<li class="group-option active-result">Canada</li>--%>
                                    <%--<li class="group-option active-result">France</li>--%>
                                    <%--<li class="group-option active-result">Germany</li>--%>
                                    <%--<li class="group-option active-result">Italy</li>--%>
                                    <%--<li class="group-option active-result">Spain</li>--%>
                                    <%--<li class="group-option active-result">Switzerland</li>--%>
                                    <%--<li class="group-option active-result">United Kingdom</li>--%>
                                    <%--<li class="group-option active-result">United States</li>--%>
                                    <%--<li class="group-result active-result">---------</li>--%>
                                    <%--<li class="group-option active-result">Afghanistan</li>--%>
                                    <%--<li class="group-option active-result">Albania</li>--%>
                                    <%--<li class="group-option active-result">Algeria</li>--%>
                                    <%--<li class="group-option active-result">American Samoa</li>--%>
                                    <%--<li class="group-option active-result">Andorra</li>--%>
                                    <%--<li class="group-option active-result">Angola</li>--%>
                                    <%--<li class="group-option active-result">Anguilla</li>--%>
                                    <%--<li class="group-option active-result">Antigua and Barbuda</li>--%>
                                    <%--<li class="group-option active-result">Argentina</li>--%>
                                    <%--<li class="group-option active-result">Armenia</li>--%>
                                    <%--<li class="group-option active-result">Aruba</li>--%>
                                    <%--<li class="group-option active-result">Australia</li>--%>
                                    <%--<li class="group-option active-result">Austria</li>--%>
                                    <%--<li class="group-option active-result">Azerbaijan</li>--%>
                                    <%--<li class="group-option active-result">Bahamas</li>--%>
                                    <%--<li class="group-option active-result">Bahrain</li>--%>
                                    <%--<li class="group-option active-result">Bangladesh</li>--%>
                                    <%--<li class="group-option active-result">Barbados</li>--%>
                                    <%--<li class="group-option active-result">Belarus</li>--%>
                                    <%--<li class="group-option active-result">Belgium</li>--%>
                                    <%--<li class="group-option active-result">Belize</li>--%>
                                    <%--<li class="group-option active-result">Benin</li>--%>
                                    <%--<li class="group-option active-result">Bermuda</li>--%>
                                    <%--<li class="group-option active-result">Bhutan</li>--%>
                                    <%--<li class="group-option active-result">Bolivia</li>--%>
                                    <%--<li class="group-option active-result">Bosnia and Herzegovina</li>--%>
                                    <%--<li class="group-option active-result">Botswana</li>--%>
                                    <%--<li class="group-option active-result">Bouvet Island</li>--%>
                                    <%--<li class="group-option active-result">Brazil</li>--%>
                                    <%--<li class="group-option active-result">British Indian Ocean--%>
                                        <%--Territory--%>
                                    <%--</li>--%>
                                    <%--<li class="group-option active-result">Brunei Darussalam</li>--%>
                                    <%--<li class="group-option active-result">Bulgaria</li>--%>
                                    <%--<li class="group-option active-result">Burkina Faso</li>--%>
                                    <%--<li class="group-option active-result">Burundi</li>--%>
                                    <%--<li class="group-option active-result">Cambodia</li>--%>
                                    <%--<li class="group-option active-result">Cameroon</li>--%>
                                    <%--<li class="group-option active-result">Canada</li>--%>
                                    <%--<li class="group-option active-result">Cape Verde</li>--%>
                                    <%--<li class="group-option active-result">Cayman Islands</li>--%>
                                    <%--<li class="group-option active-result">Central African Republic</li>--%>
                                    <%--<li class="group-option active-result">Chad</li>--%>
                                    <%--<li class="group-option active-result">Chile</li>--%>
                                    <%--<li class="group-option active-result">China</li>--%>
                                    <%--<li class="group-option active-result">Christmas Island</li>--%>
                                    <%--<li class="group-option active-result">Cocos Islands</li>--%>
                                    <%--<li class="group-option active-result">Colombia</li>--%>
                                    <%--<li class="group-option active-result">Comoros</li>--%>
                                    <%--<li class="group-option active-result">Congo</li>--%>
                                    <%--<li class="group-option active-result">Cook Islands</li>--%>
                                    <%--<li class="group-option active-result">Costa Rica</li>--%>
                                    <%--<li class="group-option active-result">Cote D'ivoire</li>--%>
                                    <%--<li class="group-option active-result">Cuba</li>--%>
                                    <%--<li class="group-option active-result">Cyprus</li>--%>
                                    <%--<li class="group-option active-result">Czech Republic</li>--%>
                                    <%--<li class="group-option active-result">Democratic People's Republic--%>
                                        <%--of Korea--%>
                                    <%--</li>--%>
                                    <%--<li class="group-option active-result">Democratic Republic of the--%>
                                        <%--Congo--%>
                                    <%--</li>--%>
                                    <%--<li class="group-option active-result">Denmark</li>--%>
                                    <%--<li class="group-option active-result">Djibouti</li>--%>
                                    <%--<li class="group-option active-result">Dominica</li>--%>
                                    <%--<li class="group-option active-result">East Timor</li>--%>
                                    <%--<li class="group-option active-result">Ecuador</li>--%>
                                    <%--<li class="group-option active-result">Egypt</li>--%>
                                    <%--<li class="group-option active-result">El Salvador</li>--%>
                                    <%--<li class="group-option active-result">Equatorial Guinea</li>--%>
                                    <%--<li class="group-option active-result">Eritrea</li>--%>
                                    <%--<li class="group-option active-result">Estonia</li>--%>
                                    <%--<li class="group-option active-result">Ethiopia</li>--%>
                                    <%--<li class="group-option active-result">Falkland Islands</li>--%>
                                    <%--<li class="group-option active-result">Faroe Islands</li>--%>
                                    <%--<li class="group-option active-result">Fiji</li>--%>
                                    <%--<li class="group-option active-result">Finland</li>--%>
                                    <%--<li class="group-option active-result">France</li>--%>
                                    <%--<li class="group-option active-result">French Guiana</li>--%>
                                    <%--<li class="group-option active-result">French Polynesia</li>--%>
                                    <%--<li class="group-option active-result">French Southern Territories--%>
                                    <%--</li>--%>
                                    <%--<li class="group-option active-result">Gabon</li>--%>
                                    <%--<li class="group-option active-result">Gambia</li>--%>
                                    <%--<li class="group-option active-result">Georgia</li>--%>
                                    <%--<li class="group-option active-result">Germany</li>--%>
                                    <%--<li class="group-option active-result">Ghana</li>--%>
                                    <%--<li class="group-option active-result">Gibraltar</li>--%>
                                    <%--<li class="group-option active-result">Greece</li>--%>
                                    <%--<li class="group-option active-result">Greenland</li>--%>
                                    <%--<li class="group-option active-result">Grenada</li>--%>
                                    <%--<li class="group-option active-result">Guadeloupe</li>--%>
                                    <%--<li class="group-option active-result">Guam</li>--%>
                                    <%--<li class="group-option active-result">Guatemala</li>--%>
                                    <%--<li class="group-option active-result">Guinea</li>--%>
                                    <%--<li class="group-option active-result">Guinea-Bissau</li>--%>
                                    <%--<li class="group-option active-result">Guyana</li>--%>
                                    <%--<li class="group-option active-result">Haiti</li>--%>
                                    <%--<li class="group-option active-result">Heard Island and Mcdonald--%>
                                        <%--Islands--%>
                                    <%--</li>--%>
                                    <%--<li class="group-option active-result">Honduras</li>--%>
                                    <%--<li class="group-option active-result">Hong Kong, China</li>--%>
                                    <%--<li class="group-option active-result">Hungary</li>--%>
                                    <%--<li class="group-option active-result">Iceland</li>--%>
                                    <%--<li class="group-option active-result">India</li>--%>
                                    <%--<li class="group-option active-result">Indonesia</li>--%>
                                    <%--<li class="group-option active-result">Iran</li>--%>
                                    <%--<li class="group-option active-result">Iraq</li>--%>
                                    <%--<li class="group-option active-result">Ireland</li>--%>
                                    <%--<li class="group-option active-result">Israel</li>--%>
                                    <%--<li class="group-option active-result">Italy</li>--%>
                                    <%--<li class="group-option active-result">Jamaica</li>--%>
                                    <%--<li class="group-option active-result">Japan</li>--%>
                                    <%--<li class="group-option active-result">Jordan</li>--%>
                                    <%--<li class="group-option active-result">Kazakhstan</li>--%>
                                    <%--<li class="group-option active-result">Kenya</li>--%>
                                    <%--<li class="group-option active-result">Kiribati</li>--%>
                                    <%--<li class="group-option active-result">Korea</li>--%>
                                    <%--<li class="group-option active-result">Kuwait</li>--%>
                                    <%--<li class="group-option active-result">Kyrgyzstan</li>--%>
                                    <%--<li class="group-option active-result">Laos</li>--%>
                                    <%--<li class="group-option active-result">Latvia</li>--%>
                                    <%--<li class="group-option active-result">Lebanon</li>--%>
                                    <%--<li class="group-option active-result">Lesotho</li>--%>
                                    <%--<li class="group-option active-result">Liberia</li>--%>
                                    <%--<li class="group-option active-result">Liechtenstein</li>--%>
                                    <%--<li class="group-option active-result">Lithuania</li>--%>
                                    <%--<li class="group-option active-result">Luxembourg</li>--%>
                                    <%--<li class="group-option active-result">Macau, China</li>--%>
                                    <%--<li class="group-option active-result">Macedonia</li>--%>
                                    <%--<li class="group-option active-result">Madagascar</li>--%>
                                    <%--<li class="group-option active-result">Malawi</li>--%>
                                    <%--<li class="group-option active-result">Malaysia</li>--%>
                                    <%--<li class="group-option active-result">Maldives</li>--%>
                                    <%--<li class="group-option active-result">Mali</li>--%>
                                    <%--<li class="group-option active-result">Malta</li>--%>
                                    <%--<li class="group-option active-result">Marshall Islands</li>--%>
                                    <%--<li class="group-option active-result">Martinique</li>--%>
                                    <%--<li class="group-option active-result">Mauritania</li>--%>
                                    <%--<li class="group-option active-result">Mauritius</li>--%>
                                    <%--<li class="group-option active-result">Mayotte</li>--%>
                                    <%--<li class="group-option active-result">Mexico</li>--%>
                                    <%--<li class="group-option active-result">Micronesia</li>--%>
                                    <%--<li class="group-option active-result">Moldova</li>--%>
                                    <%--<li class="group-option active-result">Monaco</li>--%>
                                    <%--<li class="group-option active-result">Mongolia</li>--%>
                                    <%--<li class="group-option active-result">Montserrat</li>--%>
                                    <%--<li class="group-option active-result">Morocco</li>--%>
                                    <%--<li class="group-option active-result">Mozambique</li>--%>
                                    <%--<li class="group-option active-result">Myanmar</li>--%>
                                    <%--<li class="group-option active-result">Namibia</li>--%>
                                    <%--<li class="group-option active-result">Nauru</li>--%>
                                    <%--<li class="group-option active-result">Nepal</li>--%>
                                    <%--<li class="group-option active-result">Netherlands</li>--%>
                                    <%--<li class="group-option active-result">New Caledonia</li>--%>
                                    <%--<li class="group-option active-result">New Zealand</li>--%>
                                    <%--<li class="group-option active-result">Nicaragua</li>--%>
                                    <%--<li class="group-option active-result">Niger</li>--%>
                                    <%--<li class="group-option active-result">Nigeria</li>--%>
                                    <%--<li class="group-option active-result">Niue</li>--%>
                                    <%--<li class="group-option active-result">Norfolk Island</li>--%>
                                    <%--<li class="group-option active-result">Northern Mariana Islands</li>--%>
                                    <%--<li class="group-option active-result">Norway</li>--%>
                                    <%--<li class="group-option active-result">Oman</li>--%>
                                    <%--<li class="group-option active-result">Pakistan</li>--%>
                                    <%--<li class="group-option active-result">Palau</li>--%>
                                    <%--<li class="group-option active-result">Palestine</li>--%>
                                    <%--<li class="group-option active-result">Panama</li>--%>
                                    <%--<li class="group-option active-result">Papua New Guinea</li>--%>
                                    <%--<li class="group-option active-result">Paraguay</li>--%>
                                    <%--<li class="group-option active-result">Peru</li>--%>
                                    <%--<li class="group-option active-result">Philippines</li>--%>
                                    <%--<li class="group-option active-result">Pitcairn Islands</li>--%>
                                    <%--<li class="group-option active-result">Poland</li>--%>
                                    <%--<li class="group-option active-result">Portugal</li>--%>
                                    <%--<li class="group-option active-result">Puerto Rico</li>--%>
                                    <%--<li class="group-option active-result">Qatar</li>--%>
                                    <%--<li class="group-option active-result">Reunion</li>--%>
                                    <%--<li class="group-option active-result">Romania</li>--%>
                                    <%--<li class="group-option active-result">Russia</li>--%>
                                    <%--<li class="group-option active-result">Rwanda</li>--%>
                                    <%--<li class="group-option active-result">Saint Helena</li>--%>
                                    <%--<li class="group-option active-result">Saint Kitts and Nevis</li>--%>
                                    <%--<li class="group-option active-result">Saint Lucia</li>--%>
                                    <%--<li class="group-option active-result">Saint Pierre and Miquelon--%>
                                    <%--</li>--%>
                                    <%--<li class="group-option active-result">Saint Vincent and the--%>
                                        <%--Grenadines--%>
                                    <%--</li>--%>
                                    <%--<li class="group-option active-result">San Marino</li>--%>
                                    <%--<li class="group-option active-result">Sao Tome and Principe</li>--%>
                                    <%--<li class="group-option active-result">Saudi Arabia</li>--%>
                                    <%--<li class="group-option active-result">Senegal</li>--%>
                                    <%--<li class="group-option active-result">Serbia</li>--%>
                                    <%--<li class="group-option active-result">Seychelles</li>--%>
                                    <%--<li class="group-option active-result">Sierra Leone</li>--%>
                                    <%--<li class="group-option active-result">Singapore</li>--%>
                                    <%--<li class="group-option active-result">Slovakia</li>--%>
                                    <%--<li class="group-option active-result">Slovenia</li>--%>
                                    <%--<li class="group-option active-result">Socialist Republic of--%>
                                        <%--Vietnam--%>
                                    <%--</li>--%>
                                    <%--<li class="group-option active-result">Solomon Islands</li>--%>
                                    <%--<li class="group-option active-result">Somalia</li>--%>
                                    <%--<li class="group-option active-result">South Africa</li>--%>
                                    <%--<li class="group-option active-result">South Georgia and The South--%>
                                        <%--Sandwich Islands--%>
                                    <%--</li>--%>
                                    <%--<li class="group-option active-result">Spain</li>--%>
                                    <%--<li class="group-option active-result">Sri Lanka</li>--%>
                                    <%--<li class="group-option active-result">State of Libya</li>--%>
                                    <%--<li class="group-option active-result">Sudan</li>--%>
                                    <%--<li class="group-option active-result">Suriname</li>--%>
                                    <%--<li class="group-option active-result">Svalbard and Jan Mayen</li>--%>
                                    <%--<li class="group-option active-result">Swaziland</li>--%>
                                    <%--<li class="group-option active-result">Sweden</li>--%>
                                    <%--<li class="group-option active-result">Switzerland</li>--%>
                                    <%--<li class="group-option active-result">Syrian Arab Republic</li>--%>
                                    <%--<li class="group-option active-result">TaiWan, China</li>--%>
                                    <%--<li class="group-option active-result">Tajikistan</li>--%>
                                    <%--<li class="group-option active-result">Tanzania</li>--%>
                                    <%--<li class="group-option active-result">Thailand</li>--%>
                                    <%--<li class="group-option active-result">The Republic of Croatia</li>--%>
                                    <%--<li class="group-option active-result">Togo</li>--%>
                                    <%--<li class="group-option active-result">Tokelau</li>--%>
                                    <%--<li class="group-option active-result">Tonga</li>--%>
                                    <%--<li class="group-option active-result">Trinidad and Tobago</li>--%>
                                    <%--<li class="group-option active-result">Tunisia</li>--%>
                                    <%--<li class="group-option active-result">Turkey</li>--%>
                                    <%--<li class="group-option active-result">Turkmenistan</li>--%>
                                    <%--<li class="group-option active-result">Turks and Caicos Islands</li>--%>
                                    <%--<li class="group-option active-result">Tuvalu</li>--%>
                                    <%--<li class="group-option active-result">Uganda</li>--%>
                                    <%--<li class="group-option active-result">Ukraine</li>--%>
                                    <%--<li class="group-option active-result">United Arab Emirates</li>--%>
                                    <%--<li class="group-option active-result">United Kingdom</li>--%>
                                    <%--<li class="group-option active-result">United States</li>--%>
                                    <%--<li class="group-option active-result">United States Minor Outlying--%>
                                        <%--Islands--%>
                                    <%--</li>--%>
                                    <%--<li class="group-option active-result">Uruguay</li>--%>
                                    <%--<li class="group-option active-result">US Virgin Islands</li>--%>
                                    <%--<li class="group-option active-result">Uzbekistan</li>--%>
                                    <%--<li class="group-option active-result">Vanuatu</li>--%>
                                    <%--<li class="group-option active-result">Vatican City State</li>--%>
                                    <%--<li class="group-option active-result">Venezuela</li>--%>
                                    <%--<li class="group-option active-result">Wallis and Futuna Islands--%>
                                    <%--</li>--%>
                                    <%--<li class="group-option active-result">Western Sahara</li>--%>
                                    <%--<li class="group-option active-result">Western Samoa</li>--%>
                                    <%--<li class="group-option active-result">Yemen</li>--%>
                                    <%--<li class="group-option active-result">Zambia</li>--%>
                                    <%--<li class="group-option active-result">Zimbabwe</li>--%>
                                    <%--<li class="group-option active-result">中国</li>--%>
                                <%--</ul>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                        <%--<p class="errorInfo"></p>--%>
                    <%--</td>--%>
                <%--</tr>--%>
                <%--<tr id="taxCode" style="display: none;">--%>
                    <%--<th><span class="required">*</span><label>CPF or CNPJ code:</label></th>--%>
                    <%--<td>--%>
                        <%--<select name="tax_code_type" class="taxCodeOption" id="taxCodeOption"--%>
                                <%--disabled="">--%>
                            <%--<option value="1" selected="selected">CPF (personal order)</option>--%>
                            <%--<option value="2">CNPJ (company order)</option>--%>
                        <%--</select>--%>
                        <%--<input type="text" name="tax_code_value" id="taxCodeValue" maxlength="11"--%>
                               <%--class="taxCodeValue elmbBlur" disabled=""/>--%>
                        <%--<p class="lightGray">Please only input numbers, no dots, dashes or other--%>
                            <%--characters.</p>--%>
                        <%--<p class="errorInfo"></p>--%>
                    <%--</td>--%>
                <%--</tr>--%>
                <%--<tr id="tariffCode" style="display: none;">--%>
                    <%--<th><span class="required">*</span><label>Personal or VAT ID</label></th>--%>
                    <%--<td>--%>
                        <%--<select name="tax_code_type" class="tariffCodeOption" id="tariffCodeOption"--%>
                                <%--disabled="">--%>
                            <%--<option value="3" selected="selected">My personal details</option>--%>
                            <%--<option value="4">VAT ID number (company order)</option>--%>
                        <%--</select>--%>
                        <%--<input type="text" name="tax_code_value" id="tariffCodeValue" maxlength="14"--%>
                               <%--class="tariffCodeValue elmbBlur" disabled=""/>--%>
                        <%--<a href="javascript:void(0);" class="lightGray askTipsTariff"--%>
                           <%--title="Your Personal ID/VAT ID number is required to ensure successful delivery of your order.">Why--%>
                            <%--ask?</a>--%>
                        <%--<p class="lightGray">Please only input numbers, no dots, dashes or other--%>
                            <%--characters.</p>--%>
                        <%--<p class="errorInfo"></p>--%>
                    <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<th><span class="required">*</span><label>State / Province / Region:</label></th>--%>
                    <%--<td>--%>
                        <%--<input type="text" name="province" maxlength="32" class="elmbBlur"/>--%>
                        <%--<p class="errorInfo"></p>--%>
                    <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<th><span class="required">*</span><label>City:</label></th>--%>
                    <%--<td>--%>
                        <%--<input type="text" name="city" maxlength="30" class="elmbBlur"/>--%>
                        <%--<p class="errorInfo"></p>--%>
                    <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<th><span class="required">*</span><label>Address Line 1:</label></th>--%>
                    <%--<td>--%>
                        <%--<input type="text" name="detail" maxlength="100" class="elmbBlur"/>--%>
                        <%--<p class="errorInfo"></p>--%>
                    <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<th><label>Address Line 2:</label></th>--%>
                    <%--<td>--%>
                        <%--<input type="text" name="AddressLine2" maxlength="100" class="elmbBlur"/>--%>
                        <%--<p class="lightGray">Example: apartment, suite, unit, building, floor</p>--%>
                    <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<th><span class="required">*</span><label>Phone Number:</label></th>--%>
                    <%--<td>--%>
                        <%--<input id="countryCode" class="left countryCode" name="CountryCode" type="text"--%>
                               <%--value="+0000" readonly>--%>
                        <%--<div class="left editableSelect hasLayout">--%>
                            <%--<input type="text" name="phone" class="phoneNum elmbBlur"--%>
                                   <%--maxlength="15" autocomplete="off"/>--%>
                            <%--<ul id="otherPhones"></ul>--%>
                            <%--<p class="errorInfo"></p>--%>
                        <%--</div>--%>
                        <%--<a href="javascript:void(0);" class="lightGray askTips"--%>
                           <%--title="We ask for your phone number just in case we need to reach you regarding your order.">Why--%>
                            <%--ask?</a>--%>
                        <%--<p id="phoneSample" class="lightGray clearfix">Example: +<span>0000</span>--%>
                            <%--9549031647-535</p>--%>
                    <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<th></th>--%>
                    <%--<td>--%>
                        <%--<button id="useAddress" type="submit" class="textbtn">Save</button>--%>
                    <%--</td>--%>
                <%--</tr>--%>
                <%--</tbody>--%>
            <%--</table>--%>
            <%--<input type="reset" id="resetAddr" style="display:none;">--%>
            <%--<input type="hidden" name="typeAddr" value="0"/>--%>
        <%--</form>--%>
    <%--</div>--%>
<%--</div>--%>



</body>
</html>
