var approvStep1 = new Object();
approvStep1.errorMsg = {};

approvStep1.event = function(){
	/**
	 * 上传身份证正面
	 */
	 uploadImg("#cardFront",1,".photoGroup");

	/**
	 * 上传身份证反面
	 */
	 uploadImg("#cardBack",2,".photoGroup");


	/**
	 * 取消按钮
	 * 
	 */
	 $('.cancel').on("click",function(){	
	 	$("#contentBoxId").load("../../../templates/merchant/personal/safe.html");
	 })

	/**
	 * 跳转至步骤二
	 */
	// $(".actions .next").on("click",function(){
	// 	$.ajax({
	// 		data:{"sign":2},
	// 		type:"get",
	// 		dataType:"html",
	// 		url:ctx+"businessApprove/businessApproveBefore",
	// 		success:function(data){
	// 			$("#contentBoxId").html(data);
	// 		},
	// 		error:function(){
	// 			imessenger.error("请求失败");
	// 		}
	// 	})
	// })
	
	/**
	 * 个人认证信息
	 */
	 $('[data-btn="getApproveBtn"]').on("click",function(){
	 	var datas = iform.parseForm('getApproveForm');
		//检测姓名
		var _a = c.checkMyDes('#getApproveForm',approvStep1,datas.realName,'realName',2,5);
		//检测身份证
		var _b = c.checkMyIdCard('#getApproveForm',approvStep1,datas.idCard,'idCard');
		//检测图片
		var _c = approvStep1.checkImg();
		// var _c = c.checkMyImg('#getApproveForm',approvStep1,datas.myfiles,'myfiles');
		if(_a&&_b&&_c) {
			$.ajax({
				data:datas,
				type:"post",
				dataType:"json",
				url:ctx+"/businessApprove/savePerson",
				success:function(data){
					if(data.code==200){
						$.ajax({
							data:{"sign":2},
							type:"get",
							dataType:"html",
							url:ctx+"/businessApprove/businessApproveBefore",
							success:function(data){
								$("#contentBoxId").html(data);
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
	 * 上传图片
	 */
	 function uploadImg(node,imgNo,insertNode){

	 	$("#contentBoxId").on("change",node,function(e){
	 		//图片格式的验证
	 		var img = $(this).val();
	 		var extStart = img.lastIndexOf(".");
	 		var ext = img.substring(extStart,img.length).toUpperCase();
	 		if(ext!=".BMP"&&ext!=".PNG"&&ext!=".GIF"&&ext!=".JPG"&&ext!=".JPEG") {
	 			imessenger.error('图片限于bmp,png,gif,jpeg,jpg格式');
	 			return false;
	 		} else {
	 			//图片格式验证通过进行上传阿里云
		 		$.ajaxFileUpload({
			            url : ctx+'/demo/file/oss/upload?uname=photo', // 用于文件上传的服务器端请求地址
			            secureuri : false, // 一般设置为false(是否锁定这个接口)
			            async : false,//是否是异步
			            fileElementId : $("input"+node).attr("id"), // 文件上传控件的id属性 <input
			            // $("form").serialize(),表单序列化。指把所有元素的ID，NAME 等全部发过去
			            type:'POST',
			            dataType : 'json',// 返回值类型 一般设置为json
			            complete : function() {// 只要完成即执行，最后执行
			            },
			            success : function(data) {// 服务器成功响应处理函数
			            	var key=data.data.key;
			            	if(data.code==200){

			            		$.ajax({
			            			dataType: "json",
			            			type: 'POST',
			            			url: ctx + '/businessApprove/changePhoto',
			            			async: false,
			            			data: {"key":key,"imgNo":imgNo},
			            			success:function(data) {
			            				if(data.code == 200) {

			            					$.ajax({
			            						dataType: "html",
			            						data:{"imgNo":imgNo},
			            						type: 'get',
			            						url: ctx + '/businessApprove/getImg',
			            						async: false,
			            						success:function(data) {
			            							imessenger.success("上传图片成功");
			            							$(insertNode).html(data);
			            						},
			            						error:function(jqXHR, textStatus, errorThrown) {
			            							console.log('执行登录时出错');
			            						}
			            					});
			            				}else{
			            					imessenger.error(data.errorMsg);
			            				}
			            			},
			            			error:function(jqXHR, textStatus, errorThrown) {
			            				imessenger.error('请求失败');
			            			}

			            		})
			            	}else{
			            		imessenger.error(data.errorMsg);
			            	}
			            },
			            error : function(data, status, e) {// 服务器响应失败处理函数
			            	imessenger.error('请求失败');
			            }
			        })
	 		}

	 	});
	 }
	}

	$(function(){
		approvStep1.event();
	})


//图片的验证
approvStep1.checkImg = function() {
	var flag = false;
	var _a = false;
	var _b = false;
	var front = $('#cardFront').prevAll('.img').attr('src');
	var back = $('#cardBack').prevAll('.img').attr('src');
	console.info(front+" " + back)
	if(front==undefined) {
		$('#cardFront').nextAll('.tips').text('请上传图片');
	} else {
		$('#cardFront').nextAll('.tips').text('');
		_a = true;
	}

	if(back==undefined) {
		$('#cardBack').nextAll('.tips').text('请上传图片');
	} else {
		$('#cardBack').nextAll('.tips').text('');
		_b = true;
	}
	
	if(_a&&_b) {
		flag = true;
	}

	return flag;

}