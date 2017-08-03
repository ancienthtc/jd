var good =  new Object();
good.event = function(){
	/*编辑产品页面*/
    $("#dataGridTableJson").on("click",".icon-view",function(){
    	var id = $(this).parent().nextAll("span").text();
		$.ajax({
			url:"../goods/toGoodDetail",
			data:{"id":id},
			type:"get",
			dataType:"html",
			success:function(data){
                $("#contentBoxId").html(data);
			},
			error:function(){
				alert("请求失败");
			}
		})
    });

    /*删除商品*/
    $("#dataGridTableJson").on("click",".icon-del",function(){
        var id = $(this).parent().nextAll("span").text();
        $.confirm({
            title: '提示',
            content: '确定要删除商品吗？',
            confirm: function() {
                $.ajax({
                    url:"../goods/goodsdel",
                    data:{"id":id},
                    type:"get",
                    dataType:"json",
                    success:function(data){
                        if(data==true){
                            imessenger.success("删除成功");
                            $.ajax({
                                url:"../goods/toGoodsList2",
                                type:"get",
                                dataType:"html",
                                success:function(data){
                                    $("#contentBoxId").html(data);
                                    // layer.open({
                                    //     type: 2,
                                    //     area: ['800px', '800px'],
                                    //     //content: '../goods/toGoodDetail'
                                    //     content: data
                                    // });
                                },
                                error:function(){
                                    alert("页面出错");
                                }
                            });
                        }else{
                            imessenger.error("删除失败");
                        }
                    },
                    error:function(){
                        alert("请求失败");
                    }
                })
            },
        });

    });

    /*添加商品*/
    $('[data-btn="addNew"]').click(function(){
        $.ajax({
            url:"../goods/toGoodAdd",
            type:"get",
            dataType:"html",
            success:function(data){
                $("#contentBoxId").html(data);
            },
            error:function(){
                alert("请求失败");
            }
        })
    });



}

$(function(){

	//$('#page1').bPage({
	//    url : '/JDWebShop/part/list2',
	//    totalPage : "<%=totalpages%>",
	//    totalRow : "${pageParts.total}",
	//    pageSize : "${pageParts.pageSize}",
	//    pageNo : "${pageParts.pageNo}",
	//    params : function(){
	//        return {
	//            userName : 'zhangsan',
	//            age : 42
	//        };
	//    }
	//});
	//$('#page2').bPage({
	//    url : 'https://terryz.github.io/js/bpage/html.html',
	//    asyncLoad : true,
	//    asyncType : 'GET',
	//    serverSidePage : true,
	//    asyncTarget : '#pageContent',
	//    params : function(){
	//        return {
	//            userName : 'zhangsan',
	//            age : 42
	//        };
	//    }
	//});
	$('#page3').bPage({
	    url : '/JDWebShop/goods/goodslist',
	    asyncLoad : true,
	    asyncType : 'GET',
	    serverSidePage : false,
	    render : function(data){
	    	var tb = $('#dataGridTableJson tbody');
	    	$(tb).empty();
	    	if(data && data.dataList && data.dataList.length > 0){
	    		$.each(data.dataList,function(i,row){
                    for (var s in row) {
                        if(row[s]==null||row[s]==""||row[s]==undefined){
                        	row[s]="";
						}
                    };
                    if(row.shelf!=""&&row.shelf!=undefined){
                        /*将时间戳转化为日期*/
                        var time = new Date(row.shelf);
                        row.shelf = time.getFullYear() + "-" + (time.getMonth() + 1) + "-" + time.getDate();
                    }else{
                        row.shelf="";
					}


	    			var tr = $('<tr>');
	    			$(tr).append('<td>'+row.name+'</td>');
	    			$(tr).append('<td>'+row.price+'</td>');
	    			$(tr).append('<td>'+row.gclass+'</td>');
	    			$(tr).append('<td>'+row.parameter1+'</td>');
	    			$(tr).append('<td>'+row.parameter2+'</td>');
	    			$(tr).append('<td>'+row.parameter3+'</td>');
	    			$(tr).append('<td>'+row.freight+'</td>');
	    			$(tr).append('<td>'+row.detail+'</td>');
                    $(tr).append('<td>'+row.sales+'</td>');
                    $(tr).append('<td>'+row.stock+'</td>');
                    $(tr).append('<td>'+row.shelf+'</td>');
                    $(tr).append('<td>'+'<span class="iconfont icon-view"></span>'+'</td>');
                    $(tr).append('<td>'+'<span class="iconfont icon-del"></span>'+'</td>');
                    $(tr).append('<span  style="display:none">'+row.id+'</span>');
	    			$(tb).append(tr);
	    		});
	    	}
	    },
	    params : function(){
	        return {
	            userName : 'zhangsan',
	            age : 42
	        };
	    }
	});
    good.event();
});