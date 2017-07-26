var signup = new Object();
signup.errorMsg = {};

signup.event = function(){
	
	$('.contLi #signupForm [data-btn="signupNext"]').on("click",function(){
		//获取数据结合
		var datas = iform.parseForm('signupForm');
	    //检查用户名是否合法
	    var _a = c.checkMyUsername('#signupForm',signup,datas.username,'username');
	    //检查密码是否合法
	    var _b = c.checkMyPassword('#signupForm',signup,datas.password,'password');
	    //检查两次密码是否一致
	    var _c = c.checkMyAllPwd('#signupForm',signup,datas.password,datas.passwordx,'passwordx');
	    if(_a&&_b&&_c){
	    	$.ajax({
	    		data:datas,
	    		type:"get",
	    		dataType:"json",
	    		url:"/user/isExist",
	    		success:function(data){
	    			if(data.code==200){
	    				$("#usernameId").val(datas.username);
	    				$("#passwordId").val(datas.password);
	    				$("#passwordxId").val(datas.passwordx);
	    				$("#signupForm").hide();
	    				$("#signupNextForm").show();
	    				
	    			}else{
	    				$('#signupForm [name="username"]').nextAll().text(data.errorMsg);
	    			}
	    		},
	    		error:function(){
	    			
	    		}		
	    	})
	    }
	})
	
	//注册提交
	$('.contLi #signupNextForm .btn-success:first').on('click', function() {
		var _this = $(this);
		//获取数据结合
		var datas = iform.parseForm('signupNextForm');
	    //检查手机号的合法性
	    var _d = c.checkMyPhone('#signupNextForm',signup,datas.phone,'phone');
	    //检查验证码的合法性
	    var _e = c.checkMyCode('#signupNextForm',signup,datas.code,'code');
	    datas.userType = 2;
	    datas.port="merchant";
	    console.log(datas);
	    if(_d&&_e) {
			//验证手机号是否绑定,未绑定则发送验证码
			$.ajax({
				data:{"phone":datas.phone},
				type:"get",
				dataType:"json",
				url:"/user/isBind",
				success:function(data){
					if(data.code==200){
						//提交请求
						$.ajax({
							dataType: "json",
							type: 'post',
							url: ctx + '/signupForMerchant',
							async: false,
							data: datas,
							success: function (data) {
								$('.contLi #signupNextForm .btn-success').attr('disabled');
								if (data.code == 200) {
									$('.contLi #signupNextForm .btn-success').attr('disabled');
									imessenger.success("注册成功,即将跳转至商家主页");
									$.ajax({
										dataType: "json",
										type: 'post',
										url: ctx + '/login',
										async: false,
										data: datas,
										success: function (data) {
											if (data.code == 200) {
												imessenger.success("注册成功,即将跳转至商家主页");
												setTimeout('location.href ="/merchant/index"',1000);
											} else {
												
							                    $('#signupNextForm [name="code"]').nextAll().text(data.errorMsg);
											}
										},
										error: function (jqXHR, textStatus, errorThrown) {
											
										}
									})
									
								} else {
				                    $('#signupNextForm [name="code"]').nextAll().text(data.errorMsg);
								}
							},
							error: function (jqXHR, textStatus, errorThrown) {
								
							}
						})
					}else{
						imessenger.error(data.errorMsg);
					}
				},
				error:function(){
					imessenger.error("请求失败");
				}
			})
		
	    }
	})

	//发送验证码时候检测手机号合法性
	$('.getCode:first').on('click',function() {
		var _this = this;
		//获取数据结合
		var datas = iform.parseForm('signupNextForm');
	    //检查手机号的合法性
	    var _d = c.checkMyPhone('#signupNextForm',signup,datas.phone,'phone');
		if(_d) {
			//验证手机号是否绑定,未绑定则发送验证码
			$.ajax({
				data:{"phone":datas.phone},
				type:"get",
				dataType:"json",
				url:"/user/isBind",
				success:function(data){
					if(data.code==200){
						//执行下一步提交
						$.ajax({
							data:{"phone":datas.phone,"forMerchantSignup":1,"templateCode":"BIND_PHONE"},
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
					}else{
						imessenger.error(data.errorMsg);
					}
				},
				error:function(){
					imessenger.error("请求失败");
				}
			})
			
			
			
		}

	})
}

$(function(){
	signup.event();
})