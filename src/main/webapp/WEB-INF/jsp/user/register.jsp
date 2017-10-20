<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ShangHai Heavy·Foot International Trade Co.,Ltd.</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href='css/global.css' rel='stylesheet' type='text/css'  />
<link href='css/global_1.css' rel='stylesheet' type='text/css'  />
<link href='css/user.css' rel='stylesheet' type='text/css'  />
<link href='css/style.css' rel='stylesheet' type='text/css'  />
<script type='text/javascript' src='js/jquery-1.7.2.min.js' ></script>
<script type='text/javascript' src='js/en.js' ></script>
<script type='text/javascript' src='js/global.js' ></script>
<script type='text/javascript' src='js/user.js' ></script>
<script type='text/javascript' src='js/main.js' ></script>
	<!-- Facebook Pixel Code -->
	<script type="text/javascript">
	!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,document,'script','https://connect.facebook.net/en_US/fbevents.js');
	fbq('init', '');
	fbq('track', "PageView");
	</script>
	<noscript><img height="1" width="1" style="display:none" src="picture/66acf3e1beb24285ba5622f4e3820124.gif" /></noscript>
	<!-- End Facebook Pixel Code -->
<script type="text/javascript">
$(document).ready(function(){
	user_obj.sign_in_init();
	user_obj.sign_up_init();
});
</script>
</head>

<body>
<div id="customer">
<link href='css/nav.css' rel='stylesheet' type='text/css'  />
<script type="text/javascript">
var ueeshop_config={
	"domain":"http://t017.shop.ueeshop.com",
	"date":"2017/09/14 14:41:39",
	"lang":"en",
	"currency":"USD",
	"currency_symbols":"$",
	"currency_rate":"1.0000",
	"FbAppId":"1594883030731762",
	"FbPixelOpen":"1",
	"UserId":"0",
	"TouristsShopping":"1",
	"PaypalExcheckout":""
}
</script>
</script>
<div class="header">
    <div class="logo fl pic_box" style="margin-left:20px;"><a href="/"><img src="picture/logo.png" /><span></span></a></div>
    <a href="index.htm" class="home fr">Return to the Home Pages >></a>
</div>    <div id="signup">
		<link href='css/daterangepicker.css' rel='stylesheet' type='text/css'  />
<script type='text/javascript' src='js/moment.min.js' ></script>
<script type='text/javascript' src='js/daterangepicker.js' ></script>
			<form class="register fl">
				<h3 class="title">Register a New Account</h3>
				<div class="clear"></div>
				<div id="error_register_box" class="error_note_box"></div>
				<div class="clear"></div>
									<div class="row fl">
						<label for="FirstName">First Name</label>
						<input name="FirstName" id="FirstName" class="lib_txt" type="text" size="30" maxlength="20" />
					</div>
					<div class="row fl">
						<label for="LastName">Last Name</label>
						<input name="LastName" id="LastName" class="lib_txt" type="text" size="30" maxlength="20" />
					</div>
					<div class="clear"></div>
								<div class="row">
					<label for="Email">Email <span class="fc_red">*</span></label>
					<input name="Email" id="Email" class="lib_txt" type="text" size="40" maxlength="100" format="Email" notnull />
					<p class="on_error">The Email address you entered is incorrect.</p>
				</div>
				<div class="row">
					<label for="Password">Create Your Password <span class="fc_red">*</span></label>
					<input name="Password" id="Password" class="lib_txt" type="password" size="40" notnull />
				</div>
				<div class="row">
					<label for="Password2">Confirm Password <span class="fc_red">*</span></label>
					<input name="Password2" id="Password2" class="lib_txt" type="password" size="40" notnull />
					<p class="on_error">Passwords do not match. Please try again.</p>
				</div>
				<div class="row">
					<label for="Country">Country <span class="fc_red">*</span></label>
					<select name="country_id">
												<option value="1" selected="selected">Afghanistan</option>
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
												<option value="198">South Georgia and The South Sandwich Islands</option>
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
											</select>
				</div>
				<div class="clear"></div>
									<div class="row">
						<label for="Gender">Gender</label>
						<select name='Gender' ><option value=''>--Select--</option><option value='0' >Mr</option><option value='1' >Ms</option></select>					</div>
									<div class="row">
						<label for="Age">Age</label>
						<input type='text' name='Age' value='' size='10' maxlength='3' class='lib_txt amount'>					</div>
												<dl class="intro">
					<dt>By clicking "Create my Account" I agree that:</dt>
					<dd></dd>
					<dd>I may receive communication emails from Us about order and delivery.</dd>
					<dd>I may receive new products and promotion emails from Us.</dd>
				</dl>
				<div class="row"><button class="signbtn signup form_button_bg" type="submit">Create my Account</button></div>
				<input type="hidden" name="jumpUrl" value="" />
				<input type="hidden" name="do_action" value="user.register" />
							</form>
			<script>
				(function(){
					$('form.register input[name=Birthday]').daterangepicker({
						showDropdowns:true,
						singleDatePicker:true,
						timePicker:false,
						format:'MM/DD/YYYY'
					});
				})();
			</script>
			<div class="info fr">
    <div class="box member">
        <p>Already have an account?</p>
        <div class="sign_btn"><a href="javascript:;" class="SignInButton signinbtn">Sign In Now</a></div>
        <script type='text/javascript' src='js/facebook.js' ></script>
            <div id="fb_button" scope="public_profile, email" onclick="checkLoginState();" class="fb_button" appid="1594883030731762">
                <i></i><span>Log In with Facebook</span><em></em>
            </div>
        <script type='text/javascript' src='js/google.js' ></script>
            <div id="google_btn" class="google_button" clientid="640892902807-64ev2hjtu0141m7lsn9k15mfm9b5nak5.apps.googleusercontent.com"><span class="icon"></span><span class="button_text">Log In with Google +</span></div>
        <script type='text/javascript' src='js/api.js' ></script>
			<div id="paypalLogin" appid="AXaj3xAfsUrUujWbtErMA7ElMc6gEeou8TMJMibnisJR21oFmbZ-4eCrvx5d" u="http://13660272395.myueeshop.com/?do_action=user.user_oauth&Type=Paypal"></div>
            </div>
    </div>		        <div class="blank20"></div>
    </div>
	<div class="footer">
    <div class="img">
	<a href="javascript:void(0);" title="2" target="_blank" style="margin:0 5px;"><img src="picture/06e4596004.png" alt="2" /></a>
	<a href="javascript:void(0);" title="3" target="_blank" style="margin:0 5px;"><img src="picture/a42c34df2c.png" alt="3" /></a>
	<a href="javascript:void(0);" title="4" target="_blank" style="margin:0 5px;"><img src="picture/84b60e7538.png" alt="4" /></a></div>
    <div class="copyright"> &nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0);" target="_blank">POWERED BY SZJIDING</a></div>
</div>

	</div>
</body>
</html>
