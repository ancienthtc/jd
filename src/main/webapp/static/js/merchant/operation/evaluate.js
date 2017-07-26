var evaluate = new Object();
evaluate.errorMsg = {}


evaluate.init = function(){
	$.ajax({
		data:{"requestType":2},
		type:"get",
		dataType:"html",
		url:ctx+"/evaluate/listByPage",
		success:function(data){
			$("#evaluatePage").html(data);
			page.init(ctx + "/evaluate/listByPage","requestType=2","evaluatePage");
			page.pageHtml();
		},
		error:function(){
			imessenger.error("请求失败");
		}
	})
}


evaluate.event = function(){
	//模态框默认点击事件

    $("#evaluatePage").on('click','.icon-view', function() {
        event.stopPropagation();
        //清空错误提示
        $('.tips').text('');
        //清空模态框
        $('form')[0].reset();
        $("textarea").val("");
        var datas = $(this).parents('tr').find('.evaluateSpan').data()
        console.log(datas);
        $("textarea").val(datas.content);
        iform.pushForm("complainForm",datas);
        //打开模态框
        $('.evaluateModal').modal('show');
    })


// 隐藏模态框

    $('[data-btn="evaluateBtn').on('click', function() {
        $('.evaluateModal').modal('hide');
    })
    
    /**
     * 模糊查询
     */
    $(".btnGreen").on("click",function(){
		var keyWord = $( "#inlineFormInput").val();
		var evaluate = $(".ifEvaluate").val();
		if(keyWord.trim()==""){
			$.ajax({
				data:{"requestType":2},
				type:"get",
				dataType:"html",
				url:ctx+"/evaluate/listByPage",
				success:function(data){
					$("#evaluatePage").html(data);
					page.init(ctx + "/evaluate/listByPage","requestType=2","evaluatePage");
					page.pageHtml();
				},
				error:function(){
					imessenger.error("请求失败");
				}
			})
			
		}else{
			$.ajax({
				url:ctx+"/evaluate/listByKeyWordForMerchant",
				data:{"keyWord":keyWord,"evaluate":evaluate},
				type:"get",
				dataType:"html",
				success:function(data){
					$("#evaluatePage").html(data);
					page.init(ctx + "/evaluate/listByKeyWordForMerchant","keyWord="+keyWord+"&evaluate="+evaluate,"evaluatePage");
					page.pageHtml();
				},
				error:function(){
					imessenger.error("请求失败");
				}
			})
		}
	})
	
	/**
	 * 评价类型变化时查询
	 */
	$(".ifEvaluate").on("change",function(){
		var evaluate = $(".ifEvaluate").val();
		$.ajax({
			url:ctx+"/evaluate/listByEvaluateForMerchant",
			data:{"evaluate":evaluate},
			type:"get",
			dataType:"html",
			success:function(data){
				$("#evaluatePage").html(data);
				page.init(ctx + "/evaluate/listByEvaluateForMerchant","evaluate="+evaluate,"evaluatePage");
				page.pageHtml();
			},
			error:function(){
				imessenger.error("请求失败");
			}
		})
	})
	
   
}



/*// 隐藏评价
evaluate.confirmHide = function(btn) {
    btn.on('click', function() {
        $.confirm({
            title: '确认隐藏',
            content: '确定要隐藏该评价吗？',
            confirm: function() {
                $.ajax({
                    url: ctx,
                    type: 'post',
                    dataType: 'json',
                    success: function(dbdata) {
                        //修改默认class 为icon-hide
                        $(this).removeClass().addClass('iconfont icon-hide');
                        $(this).attr('data-original-title', '恢复显示')
                        if (dbdata.code == 200) {
                            alert("成功！");
                        } else {
                            alert("有错，在看看！");
                        }
                    }
                })
            },
            confirmButton: '隐藏',
            cancelButton: '算了',
        });
    });
}

//显示评价
evaluate.confirmShow = function(btn) {
    btn.on('click', function() {
        $.confirm({
            title: '确认恢复',
            content: '确定要恢复该投诉的影响吗？',
            confirm: function() {
                $.ajax({
                    url: ctx,
                    type: 'post',
                    dataType: 'json',
                    success: function(dbdata) {
                        //修改默认class 为icon-hide
                        $(this).removeClass().addClass('iconfont icon-show');
                        $(this).attr('data-original-title', '隐藏该条')
                        if (dbdata.code == 200) {
                            alert("成功！");
                        } else {
                            alert("有错，在看看！");
                        }
                    }
                })
            },
            confirmButton: '显示',
            cancelButton: '算了',
        });
    });
}*/

$(function() {
	
	evaluate.init();
	evaluate.event();
    //操作提示气泡
    $('[data-toggle="tooltip"]').tooltip();

   /* //显示模态框
    evaluate.defaultFunction($('.icon-view'), $('.evaluateModal'));
    evaluate.hideModal();

    // 消除确认
    evaluate.confirmHide($('.icon-show'));

    // 恢复确认
    evaluate.confirmShow($('.icon-hide'));*/
})
