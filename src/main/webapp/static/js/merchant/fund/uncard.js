var uncard = new Object();
uncard.event = function (){

	
	//移除银行卡
	$('.cardList').on('click','.addBtn', function () {
		var bankCard = $(this).parents('li').find('.mydata').data("bankCard");
		
		$.confirm({
			title: '恢复绑定银行卡',
			content: '确定要恢复绑定该银行卡吗？',
			confirm: function () {
				$.ajax({
					url: ctx +'/card/remove',
					type: 'post',
					data:{
						"bankCard" : bankCard,
						"state" : 1
					},
					dataType: 'json',
					success: function (dbdata) {
						if (dbdata.code == 200) {
							imessenger.success("恢复成功");
							
							window.setTimeOut(uncard.toUrl(),1000);
						} else {
							imessenger.error("恢复失败");
						}
					}
				})
			},
		});
	});
}
uncard.toUrl  = function (){
	$('.contentBox').load('../../../templates/merchant/fund/card.html' , function() {
	      $('.contentBox').hide().fadeIn(300);
	    });
}
uncard.init = function (){
	$.ajax({
        dataType:"html",
        type:"GET",
        data:{
			"state" : 2
		},
        url:ctx + "/card/getListByUserIdHtml",
        success:function(data){
        	if(data.indexOf("li")==-1){
	        		$.alert({
	        			title: '提示',
	        			content: '您已绑定3张银行卡，无法再次进行绑定',
	        			confirm: function () {
	        				uncard.toUrl ();
	        			}
	        		});
	        		
        	}
          $(".cardList").html(data);
         
        },
        error:function(){
            console.log("请求失败");
        }
    });
}
$(function(){
	
	uncard.event();
	uncard.init();
	
})