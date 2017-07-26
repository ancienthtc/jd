var other = new Object();
other.errorMsg = {};
other.pageInit = function (){
    $.ajax({
        dataType:"html",
        type:"GET",
        url:ctx + "/subsidiary/getListByUserId",
        success:function(data){
            $("#otherDiv").html(data);
            page.init(ctx + "/subsidiary/getListByUserId","","otherDiv");
            page.pageHtml();
        },
        error:function(){
            console.log("请求失败");
        }
    });
}

//删除
$("#otherDiv").on('click','.icon-del',function() {
    var mydata = $(this).parents('tr').find('.mydata').data();
	$.confirm({
		title: '确认删除',
		content: '确定要删除吗？',
		confirm: function () {
            $.ajax({
                url: ctx+"/subsidiary/remove",
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
$("#otherDiv").on('click','.icon-putaway',function() {
    var mydata = $(this).parents('tr').find('.mydata').data();
	$.confirm({
		title: '上架商品',
		content: '确定要上架该商品吗？',
		confirm: function () {
            $.ajax({
                url: ctx+"/subsidiary/shelves",
                type: 'post',
                dataType: 'json',
                data:{"subsidiaryId":mydata.id,"isShelves":1},
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
$("#otherDiv").on('click','.icon-soldout',function() {
    var mydata = $(this).parents('tr').find('.mydata').data();
	$.confirm({
		title: '下架商品',
		content: '确定要下架该商品吗？',
		confirm: function () {
            $.ajax({
                url: ctx+"/subsidiary/shelves",
                type: 'post',
                dataType: 'json',
                data:{"subsidiaryId":mydata.id,"isShelves":2},
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
$("#otherDiv").on('click','.icon-showcase',function() {
    var mydata = $(this).parents('tr').find('.mydata').data();
	$.confirm({
		title: '设置橱窗推荐',
		content: '确定要给该商品设置橱窗位吗？',
		confirm: function () {
            $.ajax({
                url: ctx+"/subsidiary/setDisplay",
                type: 'post',
                dataType: 'json',
                data:{"subsidiaryId":mydata.id,"displayWindow":1},
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
$("#otherDiv").on('click','.icon-hidecase',function() {
    var mydata = $(this).parents('tr').find('.mydata').data();
    $.confirm({
        title: '设置橱窗推荐',
        content: '确定要给该商品设置橱窗位吗？',
        confirm: function () {
            $.ajax({
                url: ctx+"/subsidiary/setDisplay",
                type: 'post',
                dataType: 'json',
                data:{"subsidiaryId":mydata.id,"displayWindow":2},
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

//入库的模态框打开
$("#otherDiv").on('click','.icon-stock',function() {
	var mydata = $(this).parents('tr').find('.mydata').data();
	iform.pushForm('stockForm',mydata);
	$('.stockModal').modal('show');
})

//入库保存验证
$('[data-btn="stockBtn"]').on('click',function() {
	var datas = iform.parseForm('stockForm');
	var _a = c.checkMyNum('#stockForm',other,datas.number,'number',0,Infinity);
	//通过验证
	if(_a) {
        $.ajax({
            url: ctx+"/subsidiary/setStock",
            type: 'post',
            dataType: 'json',
            data:datas,
            success: function (dbdata) {
                if (dbdata.code == 200) {
                    imessenger.success("入库成功");
                    $('.stockModal').modal('hide');
                    page.paging();
                } else {
                    imessenger.error("入库失败");
                }
            }
        })
	}
})
$("#otherDiv").on('click','.icon-edit',function() {
    var mydata = $(this).parents('tr').find('.mydata').data();
    $('.contentBox').load("/subsidiary/getSubsidiary?id="+mydata.id);
})
$("#otherDiv").on('click','.icon-add',function() {
    $('.contentBox').load("/subsidiary/getSubsidiary");
})
$(function(){
    other.pageInit();
    $('.btnGreen').on('click',function() {
        var content = $("#inlineFormInput").val();
        page.init(ctx + "/subsidiary/getListByUserId","content="+content,"otherDiv");
        page.page=1;
        page.paging();
        page.pageHtml();
    })
})
