//通知详情模态框打开
$(".icon-view").on('click',function(){
	$('.messageModal').modal('show');
})

//全选和反选功能
$('#selectAll').on('click',function() {
	var flag = $(this).prop('checked');
	$('#messageDiv tbody input[name="messages"]').each(function() {
		$(this).prop('checked',flag);
	})
})

//系统消息点击控制全选的按钮
$('#messageDiv tbody input[name="messages"]').on('click',function() {
	var flag = true;
	$('#messageDiv tbody input[name="messages"]').each(function() {
		if($(this).prop('checked') == false) {
			flag = false;
		}
	})
	$('#selectAll').prop('checked',flag);
})