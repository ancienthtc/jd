var approvStep2 = new Object();
approvStep2.errorMsg = {};

approvStep2.event = function(){
	
	/**
	 * 上传三证合一照
	 */
	uploadImg("#codeKey",3,".photoGroup");

	/**
	 * 取消按钮
	 * 
	 */
	$('.cancel').on("click",function(){	
		$("#contentBoxId").load("../../../templates/merchant/personal/safe.html");
	})
	
	/**
	 * 跳转至步骤一
	 */
	$('.actions .before2').on("click",function(){
		$.ajax({
			data:{"sign":1},
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
	})
	
	/**
	 * 商家认证信息
	 */
	/*$('[data-btn="getApproveNextBtn"]').on("click",function(){
		var datas = iform.parseForm('getApproveNextForm');
		//检测公司名称
		var _a = c.checkMyDes('#getApproveNextForm',approvStep2,datas.busName,'busName',2,15);
		//检测公司地址
		var _b = c.checkMyDes('#getApproveNextForm',approvStep2,datas.companyAddress,'companyAddress',2,15);
		//检测三证合一编码
		var _c = c.checkMyCreditCode('#getApproveNextForm',approvStep2,datas.code,'code');
		//检测图片
		// var _d = c.checkMyImg('#getApproveNextForm',approvStep2,datas.myfiles,'myfiles');
		var _d = approvStep2.checkImg();
		if(_a&&_b&&_c&&_d) {
			$.ajax({
				data:datas,
				type:"post",
				dataType:"json",
				url:ctx+"businessApprove/saveCompany",
				success:function(data){
					if(data.code==200){
						$("#contentBoxId").load("../../../templates/merchant/personal/approvStep3.html");
					}else{
						imessenger.error(data.errorMsg);
					}
				},
				error:function(){
					imessenger.error("请求失败");
				}
			})	
		}
	})*/
	
		/**
	 * 全部认证完成
	 */
	$('.actions .finish').on("click",function(){
		var datas = iform.parseForm('getApproveNextForm');
		$.confirm({
		        title: '提示',
		        content: '审核过程中将无法修改认证信息,确认提交?',
		        confirm: function() {
		        	var datas = iform.parseForm('getApproveNextForm');
					//检测公司名称
					var _a = c.checkMyDes('#getApproveNextForm',approvStep2,datas.busName,'busName',2,15);
					//检测公司地址
					var _b = c.checkMyDes('#getApproveNextForm',approvStep2,datas.companyAddress,'companyAddress',2,15);
					//检测三证合一编码
					var _c = c.checkMyCreditCode('#getApproveNextForm',approvStep2,datas.code,'code');
					//检测图片
					// var _d = c.checkMyImg('#getApproveNextForm',approvStep2,datas.myfiles,'myfiles');
					var _d = approvStep2.checkImg();
					if(_a&&_b&&_c&&_d) {
			        	$.ajax({
			        		data:datas,
			    			type:"post",
			    			dataType:"json",
			    			url:ctx+"/businessApprove/saveCompany",
			    			success:function(data){
			    				if(data.code==200){
			    					imessenger.success("修改成功,请等待审核");
			    					$("#contentBoxId").load("../../../templates/merchant/personal/safe.html");
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
		 });
		
	})
	
	/**
	 * 上传图片
	 */
	function uploadImg(node,imgNo,insertNode){
		
		$("#contentBoxId").on("change",node,function(){
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
		});
	}
}

$(function(){
	approvStep2.event();
})



//图片的验证
approvStep2.checkImg = function() {
	var flag = false;
	var img = $('#codeKey').prevAll('.img').attr('src');
	console.info(img)
	if(img==undefined) {
		$('#codeKey').nextAll('.tips').text('请上传图片');
	} else {
		$('#codeKey').nextAll('.tips').text('');
		flag = true;
	}
	return flag;

}