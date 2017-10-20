<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6 lt8"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7 lt8"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8 lt8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="UTF-8" />
        <!-- <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">  -->
        <title>Login and Registration Form with HTML5 and CSS3</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <meta name="description" content="Login and Registration Form with HTML5 and CSS3" />
        <meta name="keywords" content="html5, css3, form, switch, animation, :target, pseudo-class" />
        <meta name="author" content="Codrops" />
        <link rel="shortcut icon" href="<%=basePath%>favicon.ico">
        <link rel="stylesheet" type="text/css" href="<%=basePath%>css/login/demo.css" />
        <link rel="stylesheet" type="text/css" href="<%=basePath%>css/login/style.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/login/animate-custom.css" />
        <script type='text/javascript' src='<%=basePath%>js/jquery-1.7.2.min.js' ></script>
        <script type='text/javascript' src='<%=basePath%>js/form.js' ></script>
        <script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>

        <!-- 确认框的js -->
        <script src="<%=basePath%>static/libs/jquery-confirm/jquery-confirm.js"></script>

        <!-- 提示框的js -->
        <script src="<%=basePath%>static/libs/messenger/js/messenger.min.js"></script>
        <script src="<%=basePath%>static/util/imessenger.js"></script>

        <script type='text/javascript'>
            $(function () {
                $("#loginSub").on("click",function () {
                    $("#loginForm").ajaxSubmit
                    ({
                        beforeSubmit: function () {
                            //alert("我在提交表单之前被调用！");
                        },
                        success:function (data) {
                            if(data=="true")
                            {
                                imessenger.success("登陆成功");
                                //alert("登陆成功");
                                window.location.href="<%=basePath%>login/view";
                            }
                            else if(data=="false")
                            {
                                imessenger.error("登陆失败");
                                //alert("登陆失败");
                                window.location.href="<%=basePath%>login_register";
                            }
                        }
                    })
                });

                $("#registerSub").on("click",function () {

                    $("#registerForm").ajaxSubmit
                    ({
                        beforeSubmit: function () {
                            //console.log($("#username").text()+"/"+$("#pass1").val()+"/"+$("#tel").val());
                            //alert("我在提交表单之前被调用！");
//                            if( $("#username").val().length<3 || $("#username").val().length>10 )
//                            {
//                                alert("用户名格式不正确");
//                                return false;
//                            }
                            if( $("#pass1").val() != $("#pass2").val() )
                            {
                                imessenger.error("两次密码不一致");
                                //alert("两次密码不一致");
                                return false;
                            }
                            if( $("#tel").val().length != 11 )
                            {
                                imessenger.error("手机号不正确");
                                //alert("手机号不正确");
                                return false;
                            }


                        },
                        success:function (data) {
                            if(data=="0")
                            {
                                imessenger.error("注册失败");
                                //alert("注册失败");
                                window.location.href="<%=basePath%>login_register#toregister";
                            }
                            else if(data=="-1")
                            {
                                imessenger.error("用户名已存在");
                                //alert("用户名已存在");
                                window.location.href="<%=basePath%>login_register#toregister";
                            }
                            else if(data=="1")
                            {
                                imessenger.success("注册成功请登录");
                                //alert("注册成功请登录");
                                window.location.href="<%=basePath%>login_register";
                            }
                        }
                    })

                });

            })

        </script>

    </head>
    <body>
        <div class="container">
            <!-- Codrops top bar -->
            <div class="codrops-top">
                <span class="right">
                </span>
                <div class="clr"></div>
            </div><!--/ Codrops top bar -->
            <header>
                <h1>Login and Registration Form </h1>
				<nav class="codrops-demos">
					
				</nav>
            </header>
            <section>				
                <div id="container_demo" >
                    <!-- hidden anchor to stop jump http://www.css3create.com/Astuce-Empecher-le-scroll-avec-l-utilisation-de-target#wrap4  -->
                    <a class="hiddenanchor" id="toregister"></a>
                    <a class="hiddenanchor" id="tologin"></a>
                    <div id="wrapper">
                        <div id="login" class="animate form">
                            <form id="loginForm" action="<%=basePath%>login/ton" method="post" autocomplete="on">
                                <h1>Log in</h1> 
                                <p> 
                                    <label for="username" class="uname" data-icon="u" > Your tel or username </label>
                                    <input id="username" name="username" required="required" type="text" placeholder="myusername or 13351550000"/>
                                </p>
                                <p> 
                                    <label for="password" class="youpasswd" data-icon="p"> Your password </label>
                                    <input id="password" name="password" required="required" type="password" placeholder="eg. X8df!90EO" /> 
                                </p>
                                <p class="keeplogin"> 
									<input type="checkbox" name="loginkeeping" id="loginkeeping" value="loginkeeping" /> 
									<label for="loginkeeping">Use tel login</label>
								</p>
                                <p class="login button"> 
                                    <input type="button" id="loginSub" value="Login" onclick=" javascript:void(0);" />
								</p>
                                <p class="change_link">
									Not a member yet ?
									<a href="#toregister" class="to_register">Join us</a>
								</p>
                            </form>
                        </div>

                        <div id="register" class="animate form">
                            <form id="registerForm"  action="<%=basePath%>user/register" method="post" autocomplete="on">
                                <h1> Sign up </h1> 
                                <p> 
                                    <label for="usernamesignup" class="uname" data-icon="u">Your username</label>
                                    <input id="usernamesignup" name="nickname" required="required" type="text" placeholder="mysuperusername690" />
                                </p>
                                <p> 
                                    <label for="tel" class="uname" data-icon="e" > Your tel</label>
                                    <input id="tel" name="tel" required="required" type="number" placeholder="13555655535"/>
                                </p>
                                <p> 
                                    <label for="pass1" class="youpasswd" data-icon="p">Your password </label>
                                    <input id="pass1" name="pass" required="required" type="password" placeholder="eg. X8df!90EO"/>
                                </p>
                                <p>
                                    <label for="pass2" class="youpasswd" data-icon="p">Please confirm your password </label>
                                    <input id="pass2" name="repass" required="required" type="password" placeholder="eg. X8df!90EO"/>
                                </p>
                                <p>
                                    <input type="radio"  name="sex" id="sex1" value="男" />男
                                    <input type="radio"  name="sex" id="sex2" value="女" />女
                                </p>
                                <p>
                                    <label for="live" class="uname" data-icon="u">Your live place</label>
                                    <input id="live" name="live" type="text" placeholder="Tokyo" />
                                </p>
                                <p>
                                    <label for="birth" class="uname" data-icon="u">Choose Your birthday</label>
                                    <input id="birth" name="birth" type="text" onclick="WdatePicker({dateFmt:'yyyy-MM-dd '})" placeholder="1993-9-7" />
                                </p>

                                <p class="signin button"> 
									<input type="button" id="registerSub" value="Sign up" onclick="javascript:void(0);"/>
								</p>
                                <p class="change_link">  
									Already a member ?
									<a href="#tologin" class="to_register"> Go and log in </a>
								</p>
                            </form>
                        </div>
						
                    </div>
                </div>  
            </section>
        </div>
    </body>
</html>