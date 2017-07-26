var login = new Object();
login.errorMsg = new Object();
login.errorMsg.username = "未知错误"; //用户名错误信息
login.errorMsg.password = "未知错误"; //密码错误信息


//页面加载执行的方法
$(function () {
	//登录时的表单验证
	$('[data-btn="login"]').on('click', function () {
		login.submit();
	})

   
	
	$("input").keyup(function (e) {
		if (e.keyCode == 13) {
			login.submit();
		}
	});
	
	//切换登录、注册
	login.tabChange();
})

login.tabChange = function(){
	$('.loginLi li').on('click', function() {
		var obj = $(this),
		paren = obj.parents('.loginBox');
		var index = $(this).index();
		$(this).addClass('active').siblings().removeClass('active');
		paren.find('.contLi').hide();
		paren.find('.contLi').eq(index).show();
        $('.tips').text('');
        iform.cleanForm('loginForm');
        iform.cleanForm('signupForm');
	})
}


//登录时候验证
login.submit = function () {

	var formSpace = $("#loginForm");

	//获取数据结合
	var datas = iform.parseForm("loginForm");

    //检查用户名是否合法
	var usernameIsOk = login.checkUsername(datas.username);
	if (!usernameIsOk) {
			v.toError(formSpace, "username", login.errorMsg.username);
	} else {
			v.toSuccess(formSpace, "username");
	}

	//检查密码是否合法
	var passwordIsOk = login.checkPassword(datas.password);
	if (!passwordIsOk) {
			v.toError(formSpace, "password", login.errorMsg.password);
	} else {
			v.toSuccess(formSpace, "password");
	}
	
	//用户名和密码都通过验证的话，执行
	if (usernameIsOk && passwordIsOk) {
        datas.port = "pc";
        datas.userType = 2;
		//提交请求
		$.ajax({
			dataType: "json",
			type: 'post',
			url: ctx + '/login',
			async: false,
			data: datas,
			success: function (data) {
				if (data.code == 200) {
					location.href ="/merchant/index";
				} else {
                    $('.loginCont [name="password"]').nextAll('.tips').text(data.errorMsg);
				}
			},
			error: function (jqXHR, textStatus, errorThrown) {
				
			}
		})
	} else {
		
	}
}





/*
 *  忘记密码
 */


//忘记密码模态框弹出
$('[data-btn="forgetPwd"]').on('click',function() {
    $('#forgetPwdForm [name="phone"],#forgetPwdForm [name="password"]').val('');
    $('#forgetPwdForm .tips').text('');
    $('.forgetPwd').modal('show');
})

//获取验证码
$('.forgetPwdCode:first').on('click',function() {
    var _this = this;
    var datas = iform.parseForm('forgetPwdForm');
    datas.userType=2;
    console.log(datas);
    //检查手机号合法性
    var _a = c.checkMyPhone('#forgetPwdForm',login,datas.phone,"phone");
    if(_a) {
    	$.ajax({
    		data:datas,
    		type:"get",
    		dataType:"json",
    		url:"/user/isExistForMerchant",
    		success:function(data){
    			if(data.code==200){
    				$('#forgetPwdForm [name="username"]').nextAll().text("该用户不存在");
    			}else{
    				$.ajax({
    					data:datas,
    					type:"get",
    					dataType:"json",
    					url:"/user/isBindForMerchant",
    					success:function(data){
    						if(data.code!=200){
    							$('#forgetPwdForm [name="phone"]').nextAll().text("该号码不是绑定手机号");
    						}else{
    							datas.templateCode = "FIND_LOGINPWD";
    							//执行下一步提交
    							$.ajax({
    							data:datas,
    							type:"post",
    							dataType:"json",
    							url:"/sms/sendMsgForLogout",
    							success:function(data){
    								if(data.code==200){
    									imessenger.success("验证码发送成功");
    									c.wait = 60;
    									c.time(_this);
    								}else{
    									imessenger.error(data.errorMsg);
    								}
    							},
    							error:function(){
    								imessenger.error("请求失败");
    							}
    					})
    						}
    					},
    					error:function(){
    					
    					}
    				});
    				
    				
    			}
    		},
    		error:function(){
    			imessenger.error("请求失败");
    		}
    	})
    }
})

//找回按钮点击
$('[data-btn="findPwd"]').on('click',function() {
    var datas = iform.parseForm('forgetPwdForm');
    datas.userType=2;
    //检查手机号合法性
    var _a = c.checkMyPhone('#forgetPwdForm',login,datas.phone,"phone");
    //检查验证码合法性
    var _b = c.checkMyCode('#forgetPwdForm',login,datas.code,"code");
    //检查用户名合法性
    var _c = c.checkMyUsername('#forgetPwdForm',login,datas.username,"username");
    if(_a&&_b&&_c) {
    	$.ajax({
    		data:datas,
    		type:"get",
    		dataType:"json",
    		url:"/user/isExistForMerchant",
    		success:function(data){
    			if(data.code==200){
    				$('#forgetPwdForm [name="username"]').nextAll().text("该用户不存在");
    			}else{
    				$.ajax({
    					data:datas,
    					type:"get",
    					dataType:"json",
    					url:"/user/isBindForMerchant",
    					success:function(data){
    						if(data.code!=200){
    							$('#forgetPwdForm [name="phone"]').nextAll().text("该号码不是绑定手机号");
    						}else{
    							//执行下一步提交
    							$.ajax({
    							data:{"username":datas.username,"code":datas.code},
    							type:"post",
    							dataType:"json",
    							url:"/user/checkCodeByPhoneForMerchantFindLoginPwd",
    							success:function(data){
    								if(data.code==200){
    									$(".forgetPwd").modal("hide");
    									$("#usernameId2").val(datas.username);
    									$(".setNewPwd").modal("show");
    								}else{
    									$('#forgetPwdForm [name="code"]').nextAll().text(data.errorMsg);
    								}
    							},
    							error:function(){
    								imessenger.error("请求失败");
    							}
    					})
    						}
    					},
    					error:function(){
    						imessenger.error("请求失败");
    					}
    				});
    				
    				
    			}
    		},
    		error:function(){
    			imessenger.error("请求失败");
    		}
    	});  
    }
})


/*
 * 设置新密码
 */

 $('[data-btn="setNewPwd"]').on('click',function() {
    var datas = iform.parseForm('setNewPwdForm');
    //检查密码合法性
    var _a = c.checkMyPassword('#setNewPwdForm',login,datas.newPassword,"newPassword");
    //检查密码是否一致
    var _b = c.checkMyAllPwd('#setNewPwdForm',login,datas.newPassword,datas.newPasswordx,"newPasswordx");
    datas.auType="3";
    datas.password = datas.newPassword;
    if(_a&&_b) {
        $.ajax({
            type:'post',
            dataType:"json",
            async:false,
            data:datas,
            url:"/user/findPasswordRorMerchant",
            success:function(data) {
            	if(data.code==200){
            		imessenger.success("密码修改成功，即将跳转至登录页面");
            		setTimeout("location.reload()",2000);
            	}else{
            		imessenger.error(data.errorMsg);
            	}
            },
            error:function() {
            	imessenger.error("请求失败");
            }
        })
    }
 })















/**
 * 登录时检查用户名的合法性
 * @param username
 */
login.checkUsername = function (username) {
    //定义一个全局的检测值,用于存储当前方法的最终返回值
    var usernameIsOk = false;
    /*
     * 用户名不能为空
     */
    var isNullOk = !v.isNull(username);
    if (!isNullOk) {
        login.errorMsg.username = "用户名不能为空";
        return false;
    }

    /*
     * 用户名不能包含特殊字符
     */
    var hasSpecialCharOk = !v.hasSpecialChar(username);
    if (!hasSpecialCharOk) {
        login.errorMsg.username = "用户名不能包含特殊字符";
        return false;
    }

    /*
     * 用户名不能少于6位
     */
    var shortThanOk = !v.shortThan(username, 6);
    if (!shortThanOk) {
        login.errorMsg.username = "用户名不能小于六位";
        return false;
    }

    /*
     * 用户名不能大于32位
     */
    var longThanOk = !v.longThan(username, 32);
    if (!longThanOk) {
        login.errorMsg.username = "用户名不能大于32位";
        return false;
    }


    /*
     * 判断当前用户名是否满足所有验证条件
     * 是  ==>  true
     * 否  ==>  false
     */
    if (isNullOk && hasSpecialCharOk && shortThanOk && longThanOk) {
        usernameIsOk = true;
        login.errorMsg.username = "";
    }

    return usernameIsOk;
}

/**
 * 登录时检查密码的合法性
 * @param pwd
 */
login.checkPassword = function (pwd) {
    //定义一个全局的检测值,用于存储当前方法的最终返回值
    var userpwdIsOk = false;

    /*
     * 密码不能为空
     */
    var isNullOk = !v.isNull(pwd);
    if (!isNullOk) {
        login.errorMsg.password = "密码不能为空";
        return false;
    }

    /*
     * 密码不能包含特殊字符
     */
    var hasSpecialCharOk = !v.hasSpecialChar(pwd);
    if (!hasSpecialCharOk) {
        login.errorMsg.password = "密码不能包含特殊字符";
        return false;
    }

    /*
     * 密码不能少于4位
     */
    var shortThanOk = !v.shortThan(pwd, 4);
    if (!shortThanOk) {
        login.errorMsg.password = "密码不能小于四位";
        return false;
    }

    /*
     * 密码不能大于32位
     */
    var longThanOk = !v.longThan(pwd, 32);
    if (!longThanOk) {
        login.errorMsg.password = "密码不能大于32位";
        return false;
    }


    /*
     * 判断当前用户名是否满足所有验证条件
     * 是  ==>  true
     * 否  ==>  false
     */
    if (isNullOk && hasSpecialCharOk && shortThanOk && longThanOk) {
        userpwdIsOk = true;
        login.errorMsg.password = "密码验证通过";
    }

    return userpwdIsOk;
}

/**
 * 敲回车提交表单
 * @param username
 */
// login.openKeyup = function (userName) {
// 	$(document).on('keyup', userName, function () {
// 		login.checkUsername(userName);
// 	});

// 	$(document).on('keyup', pwd, function (pwd) {
// 		login.checkPassword(pwd);
// 	});
// }


