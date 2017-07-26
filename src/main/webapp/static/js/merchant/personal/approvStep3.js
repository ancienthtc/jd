var approvStep3 = new Object();

approvStep3.event = function(){
	
	

	/**
	 * 取消按钮
	 * 
	 *//*
	$('.cancel').on("click",function(){	
		$("#contentBoxId").load("../../../templates/merchant/personal/safe.html");
	})
	
	*//**
	 * 跳转至步骤二
	 *//*
	$(".actions .before3").on("click",function(){
		$.ajax({
			data:{"sign":2},
			type:"get",
			dataType:"html",
			url:ctx+"businessApprove/businessApproveBefore",
			success:function(data){
				$("#contentBoxId").html(data);
			},
			error:function(){
				imessenger.error("请求失败");
			}
		})
	})*/
	
	

	
	
	
	
}

$(function(){
	approvStep3.event();
})