var part =  new Object();
part.event = function(){
	/*编辑产品页面*/
    $("#dataGridTableJson").on("click",".icon-view",function(){
        var id = $(this).parent().nextAll("span").text();
        $.ajax({
            url:"../part/partDetail",
            data:{"id":id},
            type:"get",
            dataType:"html",
            success:function(data){
                $("#contentBoxId").html(data);
            },
            error:function(){
                alert("请求失败");
            }
        });

        // var url = "../part/partDetail";
        // $.post(url, {"pid":id}, function(str){
        //     layer.open({
        //         type: 1,
        //         skin : "layui-layer-molv",
        //         area : ['50%','90%'],
        //         content: str //注意，如果str是object，那么需要字符拼接。
        //     });
        // });

    });

    $("#dataGridTableJson").on("click",".icon-del",function () {
        var id = $(this).parent().nextAll("span").text();

        $.confirm({
            title: '提示',
            content: '确定要删除吗？',
            confirm: function() {
                $.ajax({
                    url:"../part/partdel",
                    data:{"pid":id},
                    type:"get",
                    dataType:"json",
                    success:function(data){
                        console.log(data)
                        if(data=='true' || data==true){
                            imessenger.success("删除成功");
                        }else if(data=='false' || data==false){
                            imessenger.error("删除失败，请检查商品");
                        }
                        else {
                            imessenger.error("删除失败");
                        }

                        $.ajax({
                            url:"../part/toPartList",
                            type:"get",
                            dataType:"html",
                            success:function(data){
                                $("#contentBoxId").html(data);
                            },
                            error:function(){
                                alert("页面出错");
                            }

                        });
                    },
                    error:function(){
                        imessenger.error("请求失败");
                    }
                })

            },
        });
    });

    $("#addPart").click(function () {
        var url = "../part/partadd";
        $.post(url,function(result){ //通过Ajax发送请求到后台
            layer.open({
                type : 1,  //获取页面层信息
                skin : "layui-layer-molv",
                border : [1],
                area : ['43%','70%'],
                content : result    //把result转为jQuery对象
            });
        });
    });

}


$(function(){
	$('#page3').bPage({
	    url : '/JDWebShop/part/list_get',
	    asyncLoad : true,
	    asyncType : 'GET',
	    serverSidePage : false,
	    render : function(data){
	    	var tb = $('#dataGridTableJson tbody');
	    	$(tb).empty();
	    	if(data && data.dataList && data.dataList.length > 0){
	    		$.each(data.dataList,function(i,row){
	    			var tr = $('<tr>');
	    			$(tr).append('<td>'+row.pname+'</td>');
	    			$(tr).append('<td>'+row.type+'</td>');
	    			$(tr).append('<td>'+row.describe+'</td>');
	    			$(tr).append('<td>'+row.priority+'</td>');
	    			//$(tr).append("<td><a href='/JDWebShop/part/alter?pid="+row.id+"'>修改</a></td>");
	    			//$(tr).append("<td><a href='/JDWebShop/part/####?###="+row.id+"'>删除</a></td>");
                    $(tr).append('<td>'+'<span class="iconfont icon-view"></span>'+'</td>');
                    $(tr).append('<td>'+'<span class="iconfont icon-del"></span>'+'</td>');
                    $(tr).append('<span  style="display:none">'+row.id+'</span>');
                    $(tr).append('</tr>');
	    			//$(tr).append('<td>'+row.statusName+'</td>');
	    			//$(tr).append('<td>'+row.update_time+'</td>');
	    			$(tb).append(tr);
	    		});
	    	}
	    }
	    // ,
	    // params : function(){
	    //     return {
	    //         userName : 'zhangsan',
	    //         age : 42
	    //     };
	    // }
	});
    part.event();
});