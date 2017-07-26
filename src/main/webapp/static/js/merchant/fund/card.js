var card = new Object();
card.event = function (){
	$('[data-btn="addNewBtn"]').on('click', function () {
		/**
		 * 先检测银行卡是否超过三个
		 */
		$.ajax({
			url: ctx +'/card/findByuserId',
			type: 'post',
			
			dataType: 'json',
			success: function (dbdata) {
				if (dbdata.code == 200) {
					
					if(dbdata.data==2){//执行绑定
						 $("#rechargeForm").attr('action',ctx+ "/paymentCotronller/authentication");    //通过jquery为action属性赋值
					        $("#rechargeForm").submit();    //提交ID为myform的表单
					}else{
						   $('.contentBox').load('../../../templates/merchant/fund/addCardfund.html' , function() {
							      $('.contentBox').hide().fadeIn(300);
							    });
					}
				} else {
					imessenger.success("系统异常");
				}
			}
		})
		  
	})
	
	//移除银行卡
	$('.cardList').on('click','[data-btn="removeBtn"]', function () {
		var bankCard = $(this).parents('li').find('.mydata').data("bankCard");
		
		$.confirm({
			title: '移除银行卡',
			content: '确定要移除该银行卡吗？',
			confirm: function () {
				$.ajax({
					url: ctx +'/card/remove',
					type: 'post',
					data:{
						"bankCard" : bankCard,
						"state" : 2
					},
					dataType: 'json',
					success: function (dbdata) {
						if (dbdata.code == 200) {
							//修改默认class
							card.init();
							imessenger.success("移除成功");
						} else {
							imessenger.error("移除失败");
						}
					}
				})
			},
		});
	});
}
card.init = function (){
	$.ajax({
        dataType:"html",
        type:"GET",
        data:{
        	"state":1
        },
        url:ctx + "/card/getListByUserIdHtml",
        success:function(data){
          $(".cardList").html(data);
        },
        error:function(){
            console.log("请求失败");
        }
    });
}
$(function(){
	
	card.event();
	card.init();
	
})