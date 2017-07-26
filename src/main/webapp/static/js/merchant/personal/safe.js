var safe = new Object();
safe.errorMsg = {
	oldPassword : "未知错误",
	newPassword : "未知错误",
	newPasswordx : "未知错误",
	phone:'未知错误',
	email:'未知错误'
} 

safe.init = function(){
	$.ajax({
		data:{"type":4},
		type:"post",
		dataType:"html",
		url:ctx+"/user/findBySession",
		success:function(data){
			$('.safety').html(data);
		},
		error:function(){
			imessenger.error("请求失败");
		}
	})
}

safe.event = function(){
	
	//修改密码模态框的弹出
	$(".safety").on('click','.changePassword',function() {
		//清空表单
		$('#changePwdForm')[0].reset();
		//清空错误提示
		$('.tips').text('');
		//模态框打开
		$('.changePwd').modal('show');
	})
	
	//修改手机号模态框的弹出
$(".safety").on('click','.changePhone',function() {
	//清空表单
	$('#changePhoneForm')[0].reset();
	$('#newPhoneForm')[0].reset();
	//清空错误提示
	$('.tips').text('');	
	var datas = $('#changeByPhoneId').text();
	$('#changePhoneForm [name="phone"]').val(datas);
	if(datas==null||datas==""){
		$('.newPhoneModal').modal('show');
	}else{
		$('.changePhoneModal').modal('show');
	}
})



//修改手机号点击验证码发送验证码
$('.getCodeOld').on('click',function() {
	var _this = this;
	var phone = $('#changePhoneForm [name="phone"]').val();
	//发送ajax请求接口
	$.ajax({
		data:{"templateCode":"ALTER_PHONE","phone":phone},
		type:"post",
		dataType:"json",
		url:ctx+"/sms/sendMsgForLoged",
		success:function(data){
			if(data.code==200){
				//重置等待时间，验证码效果
				c.wait = 60;
				c.time(_this);
				imessenger.success("验证码发送成功");
			}else{
				imessenger.error(data.errorMsg);
			}
		},
		error:function(){
			imessenger.error("请求失败");
		}
	})

	
	
})

//通过邮箱修改邮箱模态框打开
$(".safety").on('click','[data-btn="addNewEmailShow"]',function() {
	//清空模态框
	$('#changeEmailForm')[0].reset();
	//清空错误信息
	$('.tips').text('');
	var email = $("#changeEmail").text();
	if(email==null||email==''){
		//如果是未绑定邮箱
		$('.addNewEmail').modal('show');
		
	}else{
		//如果是已绑定邮箱的模态框
		$('#changeEmailForm [name="oldEmail"]').val(email);
		$('.changeEmail').modal('show');
		
	}
})

/**
 * 首次绑定邮箱
 */
//绑定新邮箱时候的验证
$('[data-btn="addNewEmail"]').on('click',function(){
	var datas = iform.parseForm('addNewEmailForm');
	var emailOk = c.checkMyEmail("#addNewEmailForm",safe,datas.email,'email');
	console.log(datas);
	if(emailOk){
		$.ajax({
			data:datas,
			type:"get",
			dataType:"json",
			url:ctx+"/user/isMailExist",
			success:function(data){
				if(data.code==200){
					datas.type="BIND_EMAIL";
					$.ajax({
						data:datas,
						type:"post",
						dataType:"json",
						url:ctx+"/mail/sendMailByRole?roleType=2",
						success:function(data){
							if(data.code==200){
								console.log(data.errorMsg);
								$('.addNewEmail').modal('hide');
								imessenger.success("激活邮件已发送,请至邮箱激活");
							}else{
								imessenger.error("激活邮件发送失败");
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

/**
 * 通过原邮箱修改绑定邮箱
 */
//修改邮箱时候获取验证码
$('.getEmailCode').on('click',function() {
	var _this = this;
	//发送ajax请求
	var email = $('#changeEmailForm [name="oldEmail"]').val();
	var datas = iform.parseForm('changeEmailForm');
	datas.email = datas.newEmail;
	//检查新邮箱格式是否正确
	var _a = c.checkMyEmail("#changeEmailForm",safe,datas.newEmail,"newEmail");
	//发送ajax请求
	if(_a) {
		$.ajax({
			data:datas,
			type:"get",
			dataType:"json",
			url:ctx+"/user/isMailExist",
			success:function(data){
				if(data.code==200){
					$.ajax({
						data:{"email":email,"type":"ALTER_EMAIL"},
						type:"post",
						dataType:"json",
						url:ctx+"/mail/sendMail",
						success:function(data){
							if(data.code==200){


								//重置等待时间，验证码效果
								c.wait = 60;
								c.time(_this);
								imessenger.success("验证码发送成功");

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

/**
 * 通过手机修改绑定邮箱
 */
//通过手机修改邮箱模态框打开
$(".safety").on('click','[data-btn="changeEamilUsePhone"]',function() {
	//清空表单
	$('#changeEmailByPhoneForm')[0].reset();
	//清空错误信息
	$('.tips').text('');

	var datas = $('#changeByPhoneId').text();
	$('#changeEmailByPhoneForm [name="phone"]').val(datas);
	$('.changeEmailByPhone').modal('show');
})


//添加支付密码的模态框弹出
$(".safety").on('click','[data-btn="setPaypassword"]',function() {
	/*//修改支付密码模态框
	$('.changePaypasswordModal').modal('show');*/
	
	//添加支付密码模态框
	$('.addNewPaypasswordModal').modal('show');
})

//修改支付密码的模态框弹出
$(".safety").on('click','[data-btn="changePaypassword"]',function() {
	var phone = $("#changeByPhoneId").text();
	$('#changePaypasswordForm [name="phone"]').val(phone);
	$('.changePaypasswordModal').modal('show');
})

//找回密码模态框弹出(未认证)
$(".safety").on('click','[data-btn="findBackPasswordForUnapprove"]',function() {
	var phone = $("#changeByPhoneId").text();
	/*$('#findBackPasswordApproveForm [name="idCard"]').val(idCard);*/
	$('#findBackPasswordForm [name="phone"]').val(phone);
	/*//已认证的模态框
	$('.findBackPasswordModal').modal('show');*/
	//未认证的模态框
	$('.findBackPasswordModal').modal('show');
	
})


//找回密码模态框弹出(已认证)
$(".safety").on('click','[data-btn="findBackPasswordForApprove"]',function() {
	var phone = $("#changeByPhoneId").text();
	$('#findBackPasswordApproveForm [name="phone"]').val(phone);
	//已认证的模态框
	$('.findBackPasswordApproveModal').modal('show');
	/*//未认证的模态框
	$('.findBackPasswordApproveModal').modal('show');*/
	
	
})

/*//商家认证的模态框打开
$(".safety").on('click','[data-btn="getApprove"]',function() {
	$.ajax({
		type:""
		dataType:
		url:
		success:
		error:
	})
	$('.getApproveModal').modal('show');
})*/


















}





//修改登录密码时候的表单验证
$('[data-btn="changePwd"]').on('click',function() {

	var datas = iform.parseForm('changePwdForm');
	
	//检测原密码的合法性
	var oldpPwdOK = c.checkMyPassword('#changePwdForm',safe,datas.oldPassword,'oldPassword');
	//检查新密码的合法性
	var newPwdOk = c.checkMyPassword('#changePwdForm',safe,datas.newPassword,'newPassword');
	//检查两个密码是否一致
	var allPwdOk = c.checkMyAllPwd('#changePwdForm',safe,datas.newPassword,datas.newPasswordx,'newPasswordx');
	if ( oldpPwdOK && newPwdOk && allPwdOk ) {
		$.ajax({
			data:datas,
			type:"post",
			dataType:"json",
			url:ctx+"/user/changePassword",
			success:function(data){
				if(data.code!=200){
					$('#changePwdForm [name="oldPassword"]').next('.tips').text(data.errorMsg);
				}else{
					imessenger.success("修改成功,即将跳转至登录页面");
					$(".changePwd").modal("hide");
					setTimeout(function(){location.href=ctx+"/merchant/login"},3000);
				}
				
			},
			error:function(){
				imessenger.error("请求失败");
			}
		})
	} else {
		
	}
})



//修改手机号点击下一步的验证
$('[data-btn="changePhone"]').on('click',function() {

	var datas = iform.parseForm('changePhoneForm');
	//检查验证码的合法性
	var codeOk = c.checkMyCode('#changePhoneForm',safe,datas.code,'code');
	
	//旧手机验证执行下一步跳转
	if(codeOk) {
		$.ajax({
			data:datas,
			type:"post",
			dataType:"json",
			url:ctx+"/user/checkCodeByPhoneForLogin",
			success:function(data){
				if(data.code==200){
					console.log(data.errorMsg);
					$('.changePhoneModal').modal('hide');
					$('.newPhoneModal').modal('show');
				}else{
					$('#changePhoneForm [name="code"]').nextAll('.tips').text(data.errorMsg);
				}
			},
			error:function(){
				imessenger.error("请求失败");
			}
		})
		
	}

})


//添加新手机号时候获取验证码验证手机号
$('.getCodeNew').on('click',function() {
	var _this = this;
	var datas = iform.parseForm('newPhoneForm');
	var phoneOk = c.checkMyPhone('#newPhoneForm',safe,datas.phone,'phone');
	//手机号正确执行下一步的ajax
	if(phoneOk) {
		datas.templateCode = "BIND_PHONE";
	//判断手机号是否绑定
	$.ajax({
		data:datas,
		type:"get",
		dataType:"json",
		url:ctx+"/user/isBind",
		success:function(data){
			if(data.code==200){
					//发送ajax请求接口
					$.ajax({
						data:datas,
						type:"post",
						dataType:"json",
						url:ctx+"/sms/sendMsgForLoged",
						success:function(data){
							if(data.code==200){
								//重置等待时间，验证码效果
								c.wait = 60;
								c.time(_this);
								imessenger.success("短信发送成功");
							} else {
								$('#newPhoneForm [name="code"]').nextAll('.tips').text(data.errorMsg);
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

//添加新手机号时候的绑定验证验证码
$('[data-btn="addPhone"]').on('click',function() {
	var datas = iform.parseForm('newPhoneForm');
	//检查手机号的合法性
	var phoneOk = c.checkMyPhone('#newPhoneForm',safe,datas.phone,'phone');
	//检查验证码的合法性
	var codeOk = c.checkMyCode('#newPhoneForm',safe,datas.code,'code');

	if(phoneOk&&codeOk) {
		//执行ajax提交
		$.ajax({
			data:datas,
			type:"post",
			dataType:"json",
			url:ctx+"/user/checkCodeByPhoneForLogin",
			success:function(data){
				if(data.code==200){
					$('.newPhoneModal').modal('hide');
					/**
					 * 验证成功执行更新数据库
					 */
					$.ajax({
						data:datas,
						type:"post",
						dataType:"json",
						url:ctx+"/user/updateManagerPhone",
						success:function(data){
							if(data.code==200){
								imessenger.success("修改成功");
								$('.newPhoneModal').modal('hide');
								safe.init();
							}else{
								imessenger.error(data.errorMsg);
							}
						},
						error:function(){
							imessenger.error("请求失败");
						}
					})
				}else{
					$('#changePhoneForm [name="code"]').nextAll('.tips').text(data.errorMsg);
					$('#newPhoneForm [name="code"]').nextAll('.tips').text(data.errorMsg);
				}
			},
			error:function(){
				imessenger.error("请求失败");
			}
		})
	}

})




//验证邮箱验证码并给新邮箱发送链接
$('[data-btn="changeEmail"]').on('click',function(){
	var datas = iform.parseForm('changeEmailForm');
	console.log(datas);
	var emailOk = c.checkMyEmail("#changeEmailForm",safe,datas.newEmail,'newEmail');
	var codeOk = c.checkMyCode("#changeEmailForm",safe,datas.code,'code')
	if(emailOk&&codeOk) {
		datas.email = datas.newEmail;
		$.ajax({
			data:datas,
			type:"get",
			dataType:"json",
			url:ctx+"/user/isMailExist",
			success:function(data){
				if(data.code==200){
					//执行提交
					$.ajax({
						data:datas,
						type:"post",
						dataType:"json",
						url:ctx+"/user/checkCodeByEmailForLogin",
						success:function(data){
							if(data.code==200){
								var type = "BIND_EMAIL";
								var email = $('#changeEmailForm [name="newEmail"]').val();
								/**
								 * 验证成功给新邮箱发送链接
								 */
								$.ajax({
									data:{"email":email,"type":type},
									type:"post",
									dataType:"json",
									url:ctx+"/mail/sendMailByRole?roleType=2",
									success:function(data){
										if(data.code==200){
											$('.changeEmail').modal('hide');
											imessenger.success("激活邮件已发送,请至邮箱激活")
										}else{
											$('#changeEmailForm [name="code"]').nextAll('.tips').text(data.errorMsg);						}
										},
									error:function(){
										imessenger.error("请求失败");
									}
								})
							}else{
								$('#changeEmailForm [name="code"]').nextAll('.tips').text(data.errorMsg);
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





//修改邮箱时候获取验证码
$('.getPhoneCode').on('click',function() {
	var _this = this;
	var datas = iform.parseForm('changeEmailByPhoneForm');
	datas.templateCode = "ALTER_EMAIL";
	datas.email = datas.newEmail;
	//发送ajax请求接口
	$.ajax({
		data:datas,
		type:"get",
		dataType:"json",
		url:ctx+"/user/isMailExist",
		success:function(data){
			if(data.code==200){
				$.ajax({
					data:datas,
					type:"post",
					dataType:"json",
					url:ctx+"/sms/sendMsgForLoged",
					success:function(data){
						if(data.code==200){
							//重置等待时间，验证码效果
							c.wait = 60;
							c.time(_this);
							imessenger.success("验证码发送成功");
						}else{
							imessenger.success(data.errorMsg);
						};
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


	
})


//验证手机号验证码,并给新邮箱发送激活邮件
$('[data-btn="changeEmailByPhone"]').on('click',function() {
	var datas = iform.parseForm('changeEmailByPhoneForm');
	var emailOk = c.checkMyEmail("#changeEmailByPhoneForm",safe,datas.newEmail,'newEmail');
	var codeOk = c.checkMyCode("#changeEmailByPhoneForm",safe,datas.code,'code')
	if(emailOk&&codeOk) {
		datas.email = datas.newEmail;
		$.ajax({
			data:datas,
			type:"get",
			dataType:"json",
			url:ctx+"/user/isMailExist",
			success:function(data){
				if(data.code==200){
					//执行提交
					$.ajax({
						data:datas,
						type:"post",
						dataType:"json",
						url:ctx+"/user/checkCodeByPhoneForLogin",
						success:function(data){
							if(data.code==200){
								console.log(data.errorMsg);
								var type = "BIND_EMAIL";
								var email = $('#changeEmailByPhoneForm [name="newEmail"]').val();
								/**
								 * 验证成功给新邮箱发送链接
								 */
								$.ajax({
									data:{"email":email,"type":type},
									type:"post",
									dataType:"json",
									url:ctx+"/mail/sendMailByRole?roleType=2",
									success:function(data){
										if(data.code==200){
											console.log(data.errorMsg);
											$('.changeEmailByPhone').modal('hide');
											imessenger.success("激活邮件已发送,请至邮箱激活")
										}else{
											imessenger.error(data.errorMsg);
										}
									},
									error:function(){
										imessenger.error("请求失败");
									}
								})
							}else{
								$('#changeEmailByPhoneForm [name="code"]').nextAll('.tips').text(data.errorMsg);
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






//添加支付密码提交
$('[data-btn="addNewPaypasswordBtn"]').on('click',function() {
	var datas = iform.parseForm('addNewPaypasswordForm');
	//密码的验证
	var _a = c.checkMyPassword('#addNewPaypasswordForm',safe,datas.newPassword,'newPassword');
	//确认密码的验证
	var _b = c.checkMyAllPwd('#addNewPaypasswordForm',safe,datas.newPassword,datas.newPasswordx,'newPasswordx');
	//通过验证
	if(_a&&_b) {
		//值为0则为新增密码模态框
		if( $('#addNewPaypasswordId').val() == 0 ) {
			$.ajax({
				data:datas,
				type:"post",
				dataType:"json",
				url:ctx+"/paypassword/save",
				success:function(data){
					if(data.code==200){
						imessenger.success(data.errorMsg);
						$('.addNewPaypasswordModal').modal('hide');
						safe.init();
					}else{
						imessenger.error(data.errorMsg);
					}
				},
				error:function(){
					imessenger.error("请求失败");
				}
			})
			//值为1则为修改密码模态框
		} else if ($('#addNewPaypasswordId').val() == 1 ) {
			$.ajax({
				data:datas,
				type:"post",
				dataType:"json",
				url:ctx+"/paypassword/saveNewPassword",
				success:function(data){
					if(data.code==200){
						imessenger.success(data.errorMsg);
						$('.addNewPaypasswordModal').modal('hide');
						safe.init();
					}else{
						imessenger.error(data.errorMsg);
					}
				},
				error:function(){
					imessenger.error("请求失败");
				}
			})
		}
	}
})

//修改支付密码提交
$('[data-btn="changePaypasswordBtn"]').on('click',function() {
	var datas = iform.parseForm('changePaypasswordForm');
	//密码的验证
	var _a = c.checkMyPassword('#changePaypasswordForm',safe,datas.oldPassword,'oldPassword');
	//验证码的验证
	var _b = c.checkMyCode('#changePaypasswordForm',safe,datas.code,'code')
	
	if(_a&&_b) {
		//首先检查验证码是否失效,然后在发送ajax请求验证旧密码是否正确
		$.ajax({
			data:datas,
			type:"post",
			dataType:"json",
			url:ctx+"/paypassword/checkVerifyCode",
			success:function(data){
				if(data.code==200){
					$.ajax({
						data:datas,
						type:"post",
						dataType:"json",
						url:ctx+"/paypassword/checkOldPassword",
						success:function(data){
							if(data.code==200){
								//如果成功,输入新密码模态框的隐藏域赋值1,模态框打开
								$('.changePaypasswordModal').modal('hide');
								$('#addNewPaypasswordId').val(1);
								$('.addNewPaypasswordModal').modal('show');
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

//修改支付密码手机号点击验证码发送验证码
$('.getPayCodeOld').on('click',function() {
	var _this = this;
	 var phone = $('#changePaypasswordForm [name="phone"]').val();
	//发送ajax请求接口
	 $.ajax({
	 	data:{"templateCode":"ALTER_PAYPWD","phone":phone},
	 	type:"post",
	 	dataType:"json",
	 	url:ctx+"/sms/sendMsgForLoged",
	 	success:function(data){
	 		if(data.code==200){
	 			//重置等待时间，验证码效果
				c.wait = 60;
				c.time(_this);
	 			imessenger.success("验证码发送成功");
	 		}else{
	 			imessenger.error(data.errorMsg);
	 		}
	 	},
	 	error:function(){
	 		imessenger.error("请求失败");
	 	}
	 })
	
})



//支付密码找回
/*$('[data-btn="findBackPassword"]').on('click',function() {
	//已认证的模态框
	$('.findBackPasswordModal').modal('show');
	//未认证的模态框
	$('.findBackPasswordApproveModal').modal('show');
})*/


//支付密码提交(已认证)
$('[data-btn="findBackPasswordApproveBtn"]').on('click',function() {
	var datas = iform.parseForm('findBackPasswordApproveForm');
	//验证码合法性
	var _a = c.checkMyCode('#findBackPasswordApproveForm',safe,datas.code,'code');
	var _b = c.checkMyIdCard('#findBackPasswordApproveForm',safe,datas.idCard,'idCard');
	if(_a&&_b) {
		//执行下一步
		$.ajax({
			data:datas,
			type:"post",
			dataType:"json",
			url:ctx+"/paypassword/checkIdCodeAndVerifyCode",
			success:function(data){
				if(data.code==200){
					$('.findBackPasswordApproveModal').modal('hide');
					$('.setNewPaypasswordModal').modal('show');
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
//获取验证码(已认证)
$('.getPayCode1').on('click',function() {
	 var _this = this;
	 var phone = $('#findBackPasswordApproveForm [name="phone"]').val();
	//发送ajax请求接口
	 $.ajax({
	 	data:{"templateCode":"FIND_PAYPWD","phone":phone},
	 	type:"post",
	 	dataType:"json",
	 	url:ctx+"/sms/sendMsgForLoged",
	 	success:function(data){
	 		if(data.code==200){
	 			//重置等待时间，验证码效果
				c.wait = 60;
				c.time(_this);
	 			imessenger.success("验证码发送成功");
	 		}else{
	 			imessenger.error(data.errorMsg);
	 		}
	 	},
	 	error:function(){
	 		imessenger.error("请求失败");
	 	}
	 })
	
})




//支付密码提交(未认证)
$('[data-btn="findBackPasswordBtn"]').on('click',function() {
	var datas = iform.parseForm('findBackPasswordForm');
	//验证码合法性
	var _a = c.checkMyCode('#findBackPasswordForm',safe,datas.code,'code');
	if(_a) {
		//执行下一步
		 $.ajax({
			 	data:datas,
			 	type:"post",
			 	dataType:"json",
			 	url:ctx+"/paypassword/checkVerifyCode",
			 	success:function(data){
			 		if(data.code==200){
			 			$('.findBackPasswordModal').modal('hide');
			 			$('.setNewPaypasswordModal').modal('show');
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

//获取验证码(未认证)
$('.getPayCode2').on('click',function() {
	 var _this = this;
	 var phone = $('#findBackPasswordForm [name="phone"]').val();
	//发送ajax请求接口
	 $.ajax({
	 	data:{"templateCode":"FIND_PAYPWD","phone":phone},
	 	type:"post",
	 	dataType:"json",
	 	url:ctx+"/sms/sendMsgForLoged",
	 	success:function(data){
	 		if(data.code==200){
	 			//重置等待时间，验证码效果
				c.wait = 60;
				c.time(_this);
	 			imessenger.success("验证码发送成功");
	 		}else{
	 			imessenger.error(data.errorMsg);
	 		}
	 	},
	 	error:function(){
	 		imessenger.error("请求失败");
	 	}
	 })
	
})




//找回密码之后重置新密码的提交
$('[data-btn="setNewPaypasswordBtn"]').on('click',function() {
	var datas = iform.parseForm('setNewPaypasswordForm');
	//密码的验证
	var _a = c.checkMyPassword('#setNewPaypasswordForm',safe,datas.newPassword,'newPassword');
	//确认密码的验证
	var _b = c.checkMyAllPwd('#setNewPaypasswordForm',safe,datas.newPassword,datas.newPasswordx,'newPasswordx');
	//通过验证
	if(_a&&_b) {
		 $.ajax({
			 	data:datas,
			 	type:"post",
			 	dataType:"json",
			 	url:ctx+"/paypassword/saveNewPassword",
			 	success:function(data){
			 		if(data.code==200){
			 			imessenger.success(data.errorMsg);
			 			$('.setNewPaypasswordModal').modal('hide');
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




//商家认证点击下一步的验证
$('[data-btn="getApproveBtn"]').on('click',function() {
	var datas = iform.parseForm('getApproveForm');
	//姓名的验证
	var _a = c.checkMyDes('#getApproveForm',safe,datas.realName,'realName',2,10);
	//身份证的验证
	var _b = c.checkMyIdCard('#getApproveForm',safe,datas.idCard,'idCard');
	//检查身份证正面合法性
	var _c = c.checkMyImg('#getApproveForm',safe,datas.cardFront,'cardFront');
	//检查身份证反面合法性
	var _d = c.checkMyImg('#getApproveForm',safe,datas.cardBack,'cardBack');
	//验证全部通过
	if(_a&&_b&&_c&&_d) {
		$('.getApproveModal').modal('hide');
		$('.getApproveNextModal').modal('show');
	}
})

//认证资质详细资料的提交
$('[data-btn="getApproveNextBtn"]').on('click',function() {
	var datas = iform.parseForm('getApproveNextForm');
	//公司名称的验证
	var _a = c.checkMyDes('#getApproveNextForm',safe,datas.name,'name',2,15);
	//公司电话的验证
	var _b = c.checkMyTel('#getApproveNextForm',safe,datas.phone,'phone');
	//公司地址的验证
	var _c = c.checkMyDes('#getApproveNextForm',safe,datas.address,'address',2,30);
	//三证合一编码认证
	var _d = c.checkMyCreditCode('#getApproveNextForm',safe,datas.code,'code');
	//三证合一照片认证
	var _e = c.checkMyImg('#getApproveNextForm',safe,datas.cardFront,'cardFront');
	//验证全部通过
	if(_a&&_b&&_c&&_d&&_e) {
		//执行下一步
	}
})



$(function(){
	safe.init();
	safe.event();
})