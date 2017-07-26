var messageList = new Object();

/**
 * 页面首次加载
 */
messageList.init = function(){
	$.ajax({
		data:{"state":4},
		dataType: "html",
		type: 'get',
		url: ctx + '/message/getIsReadList',
		async: false,
		success:function(data) {
			$("#messageDiv").html(data);
			
			page.init(ctx + "/message/getIsReadList","state=4","messageDiv");
			page.pageHtml();
			
		},
		error:function(jqXHR, textStatus, errorThrown) {
			imessenger.error("请求失败");
		}
	});
}


messageList.event = function(){
	
	//全选和反选功能
$("#messageDiv").on('click','#selectAll',function() {
	var flag = $(this).prop('checked');
	$('#messageDiv tbody input[name="messages"]').each(function() {
		$(this).prop('checked',flag);
	})
})

//系统消息点击控制全选的按钮
$("#messageDiv").on('click','tbody input[name="messages"]',function() {
	var flag = true;
	$('#messageDiv tbody input[name="messages"]').each(function() {
		if($(this).prop('checked') == false) {
			flag = false;
		}
	})
	$('#selectAll').prop('checked',flag);
})


	
	/**
	 * 详情查看
	 */
	$("#messageDiv").on("click",".icon-view",function(){
		//清空错误提示
		$('.tips').text('');
		//清空模态框
		$('form')[0].reset();
		//填充模态框
		var mydata = $(this).parents('tr').find('.mydata').data();
		console.log(mydata);
		iform.pushForm('messageForm',mydata);
		//模态框弹出
		$('.messageModal').modal('show');
		var messageId = $(this).parents('tr').find('.mydata').text();
		$.ajax({
			data:{"messageId":messageId},
			dataType: "json",
			type: 'post',
			url: ctx + '/message/isRead',
			async: false,
			success:function(data) {
				if(data.code==200){
					page.paging();
					$.ajax({
						dataType: "json",
						type: 'get',
						url: ctx + '/message/getByIsReadNum',
						async: false,
						success:function(data) {
							if(data.code==200){
								$(this).parents('tr').removeClass("on");
								if(data.data==0){
									$(".addForUnderSpan").remove();
								}else{
									$('.msgNum').text(data.data);
								}
							}
						},
						error:function(jqXHR, textStatus, errorThrown) {
							imessenger.error("请求失败");
						}
					});
				}
			},
			error:function(jqXHR, textStatus, errorThrown) {
				imessenger.error("请求失败");
			}
		});
	})
	
	/**
	 * 模糊查询
	 */
	$(".location .btnGreen").on("click",function(){
		var msg = $("#inlineFormInput").val();
		$.ajax({
			data:{"msg":msg,"state":4},
			dataType: "html",
			type: 'get',
			url: ctx + '/message/search',
			async: false,
			success:function(data) {
				$("#messageDiv").html(data);
				page.init(ctx + "/message/search","msg="+msg+"&state=4","messageDiv");
				page.pageHtml();
				
			},
			error:function(jqXHR, textStatus, errorThrown) {
				imessenger.error("请求失败");
			}
		});
	})
	
	/**
	 * 批量标记已读
	 */
	$("#messageDiv").on("click",'[data-btn="readed"]',function(){
		var ids = "0";
		$('#messageDiv tbody input[name="messages"]').each(function() {
			if($(this).prop('checked') == true) {
				ids = ids+","+$(this).parents("tr").find(".mydata").text();
			}
		})
		console.log(ids);
		$.ajax({
			data:{"ids":ids},
			dataType: "json",
			type: 'post',
			url: ctx + '/message/batchIsRead',
			async: false,
			success:function(data) {
				if(data.code==200){
					page.paging();
					$.ajax({
						dataType: "json",
						type: 'get',
						url: ctx + '/message/getByIsReadNum',
						async: false,
						success:function(data) {
							if(data.code==200){
								$(this).parents('tr').removeClass("on");
								if(data.data==0){
									$(".addForUnderSpan").remove();
								}else{
									$('.msgNum').text(data.data);
								}
							}
						},
						error:function(jqXHR, textStatus, errorThrown) {
							imessenger.error("请求失败");
						}
					});
				}
			},
			error:function(jqXHR, textStatus, errorThrown) {
				imessenger.error("请求失败");
			}
		});
	})
	
}


$(function(){
	messageList.init();
	messageList.event();
})