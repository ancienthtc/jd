var product = new Object();
product.pageInit = function (){
    $.ajax({
        dataType:"html",
        type:"GET",
        url:ctx + "/product/getListByUserId",
        success:function(data){
            $("#productDiv").html(data);
            page.init(ctx + "/product/getListByUserId","","productDiv");
            page.pageHtml();
        },
        error:function(){
            console.log("请求失败");
        }
    });
}
$(function(){
    product.pageInit();

	//删除
    $("#productDiv").on('click','.icon-del',function() {
        var mydata = $(this).parents('tr').find('.mydata').data();
		$.confirm({
			title: '确认删除',
			content: '确定要删除吗？',
			confirm: function () {
				$.ajax({
					url: ctx+"/product/remove",
					type: 'post',
					dataType: 'json',
					data:{"id":mydata.id},
					success: function (dbdata) {
						if (dbdata.code == 200) {
							imessenger.success("删除成功");
                            page.paging();
						} else {
                            imessenger.error(dbdata.errorMsg);
						}
					}
				})
			},
		});
	});
	
	//上架
    $("#productDiv").on('click','.icon-putaway',function() {
        var mydata = $(this).parents('tr').find('.mydata').data();
		$.confirm({
			title: '上架商品',
			content: '确定要上架该商品吗？',
			confirm: function () {
				$.ajax({
					url: ctx+"/product/shelves",
					type: 'post',
					dataType: 'json',
					data:{"productId":mydata.id,"isShelves":1},
					success: function (dbdata) {
						if (dbdata.code == 200) {
                            imessenger.success("上架成功");
                            page.paging();
						} else {
                            imessenger.error(dbdata.errorMsg);
						}
					}
				})
			},
		});
	});
	
	//下架
    $("#productDiv").on('click','.icon-soldout',function() {
        var mydata = $(this).parents('tr').find('.mydata').data();
		$.confirm({
			title: '下架商品',
			content: '确定要下架该商品吗？',
			confirm: function () {
				$.ajax({
					url: ctx+"/product/shelves",
					type: 'post',
					dataType: 'json',
                    data:{"productId":mydata.id,"isShelves":2},
					success: function (dbdata) {
						if (dbdata.code == 200) {
                            imessenger.success("下架成功");
                            page.paging();
						} else {
                            imessenger.error(dbdata.errorMsg);
						}
					}
				})
			},
		});
	});
	
	//设置橱窗推荐
    $("#productDiv").on('click','.icon-showcase',function() {
        var mydata = $(this).parents('tr').find('.mydata').data();
		$.confirm({
			title: '设置橱窗推荐',
			content: '确定要给该商品设置橱窗位吗？',
			confirm: function () {
				$.ajax({
					url: ctx+"/product/setDisplay",
					type: 'post',
					dataType: 'json',
					data:{"productId":mydata.id,"displayWindow":1},
					success: function (dbdata) {
						if (dbdata.code == 200) {
                            imessenger.success("设置橱窗成功");
                            page.paging();
						} else {
                            imessenger.error("设置橱窗失败");
						}
					}
				})
			},
		});
	});

    //取消橱窗推荐
    $("#productDiv").on('click','.icon-hidecase',function() {
        var mydata = $(this).parents('tr').find('.mydata').data();
        $.confirm({
            title: '设置橱窗推荐',
            content: '确定要取消该橱窗位吗？',
            confirm: function () {
                $.ajax({
                    url: ctx+"/product/setDisplay",
                    type: 'post',
                    dataType: 'json',
                    data:{"productId":mydata.id,"displayWindow":2},
                    success: function (dbdata) {
                        if (dbdata.code == 200) {
                            imessenger.success("取消橱窗成功");
                            page.paging();
                        } else {
                            imessenger.error("取消橱窗失败");
                        }
                    }
                })
            },
        });
    });

    $("#productDiv").on('click','.icon-edit',function() {
        var mydata = $(this).parents('tr').find('.mydata').data();
        $('.contentBox').load("/product/getProduct?id="+mydata.id);
    })


    $('.btnGreen').on('click',function() {
        var content = $("#inlineFormInput").val();
        page.init(ctx + "/product/getListByUserId","content="+content,"productDiv");
        page.page=1;
        page.paging();
        page.pageHtml();
    })
})
