var personal = new Object();



personal.init = function(){
	$('#avatarInput').on('change',function(e) {
		//判断图片的类型是否正确
		var img = $(this).val();
		var extStart = img.lastIndexOf(".");
		var ext = img.substring(extStart,img.length).toUpperCase();
		/*var maxsize = 1024;//上传图片最大值
		var filesize = img.files[0].size;*/
		if(ext!=".BMP"&&ext!=".PNG"&&ext!=".GIF"&&ext!=".JPG"&&ext!=".JPEG") {
			imessenger.error('图片限于bmp,png,gif,jpeg,jpg格式');
			$(this).val("");
			return false;
		}/*else if(filesize>maxsize){
			
			alert("no");
			imessenger.error("上传图片大小不能超过1M，请重新选择图片");
			$(this).val("");
			return false;
		}*/
	})
	
	/**
	 * 上传头像
	 */
	$('#contentBoxId').on("click",'.avatar-save:first',function(){
		var url = $("#avatarInput").val();
		/*var datas =eval('(' + $(".avatar-data").val() + ')');*/
		if(url==null||url==''){
			imessenger.error("请选择图片！");
		}else {
			var datas = JSON.parse($(".avatar-data").val());
			//console.log(datas);
			var width = Math.floor(datas.width);
			var height = Math.floor(datas.height);
			var left = Math.floor(datas.x);
			var top = Math.floor(datas.y);
			//console.log(width+","+height+","+left+","+top);
			$.ajaxFileUpload({
	            url : ctx+'/demo/file/oss/upload2?uname=photo&width='+width+"&height="+height+"&left="+left+"&top="+top, // 用于文件上传的服务器端请求地址
	            secureuri : false, // 一般设置为false(是否锁定这个接口)
	            async : false,//是否是异步
	            fileElementId : $("input#avatarInput").attr("id"), // 文件上传控件的id属性 <input
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
	                		url: ctx + '/user/changePhoto',
	                		async: false,
	                		data: {"key":key},
	                		success:function(data) {
	                			if(data.code == 200) {
	                				
	                				$("#avatar-modal").modal("hide");
	                				setTimeout("personal.load()",500);
	                				$.ajax({
	                					data:{"state":1},
	                					type:"get",
	                					dataType:"html",
	                					url:ctx+"/message/getUnReadNum",
	                					success:function(data){
	                						$(".topNav").html(data);
	                					},
	                					error:function(){
	                						// imessenger.error("请求失败");
	                					}
	                				})
	                			}else{
	                				// imessenger.error(data.errorMsg);
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
	            	// imessenger.error('请求失败');
	            }
	})
		}
	});
	
	$('[data-btn="saveChange"]').on("click",function(){
		var realName = $("#realname").val();
		var sex = $("input[name='sex']:checked").val();
		var birthday = $("#datetimepicker").val();
		var nickname = $("#nickname").val();
		var brief = $("#brief").val();
		$.ajax({
			dataType: "json",
			data:{"sex":sex,"realName":realName,"birthday":birthday,"nickname":nickname,"brief":brief,"roleType":2},
			type: 'POST',
			url: ctx + '/user/changePersonMsg',
			async: false,
			success:function(data) {
				if(data.code==200){
					imessenger.success(data.errorMsg);
					
				}else{
					imessenger.error(data.errorMsg);
				}
				
			},
			error:function(jqXHR, textStatus, errorThrown) {
				imessenger.error("请求失败");
			}
		});
	});
	
	/**
	 * 修改管理员性别
	 *//*
	$("input[name='sex']").on("change",function(){
		var sex = $("input[name='sex']:checked").val();
		$.ajax({
			dataType: "json",
			data:{"sex":sex},
			type: 'POST',
			url: ctx + '/user/updateSex',
			async: false,
			success:function(data) {
				console.log(data.errorMsg);
			},
			error:function(jqXHR, textStatus, errorThrown) {
				console.log('执行登录时出错');
			}
		});
	})
	
	*//**
	 * 修改管理员出生日期
	 *//*
	$("#datetimepicker").on("change",function(){
		var birthday = $("#datetimepicker").val();
		var birthday = Date.parse(date);
		birthday = birthday / 1000;
		$.ajax({
			dataType: "json",
			data:{"birthday":birthday},
			type: 'POST',
			url: ctx + '/user/updateBirthday',
			async: false,
			success:function(data) {
				console.log(data.errorMsg);
			},
			error:function(jqXHR, textStatus, errorThrown) {
				console.log('执行登录时出错');
			}
		});
	})*/

};


personal.load = function(){
	$.ajax({
		dataType: "html",
		data:{"type":3},
		type: 'POST',
		url: ctx + '/user/findBySession',
		async: false,
		success:function(data) {
			$("#personalFiles").html(data);
			personal.init();
		},
		error:function(jqXHR, textStatus, errorThrown) {
			console.log('执行登录时出错');
		}
	});
}	

$(function(){
	//personal.init();
	personal.load();
})



