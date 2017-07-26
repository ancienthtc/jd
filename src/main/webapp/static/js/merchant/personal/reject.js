var reject = new Object();

reject.event = function(){
	$(".location .rejectBack").on("click",function(){
		$.ajax({
			data:{},
			type:"post",
			dataType:"json",
			url:ctx+"/businessApprove/recertification",
			success:function(data){
				if(data.code==200){
					$.ajax({
						type:"get",
						dataType:"html",
						url:ctx+"/businessApprove/businessApprovePage",
						success:function(data){
							$('.contentBox').html(data);
						},
						error:function(){
							imessenger.error("请求失败");
						}
					})
				}else{
					imessenger.error(data.errorMsg)
				}
			},
			error:function(){
				imessenger.error("请求失败")
			}
		})
	})
}

$(function(){
	reject.event();
})