var part =  new Object();
part.event = function(){
	/*编辑产品页面*/
    $("#dataGridTableJson").on("click",".icon-view",function(){
        // $.ajax({
        //     url:"../goods/toGoodDetail",
        //     type:"get",
        //     dataType:"html",
        //     success:function(data){
        //         $("#contentBoxId").html(data);
        //     },
        //     error:function(){
        //         alert("请求失败");
        //     }
        // });
        var url = "../part/alter";
        $.post(url, {}, function(str){
            layer.open({
                type: 1,
                skin : "layui-layer-molv",
                area : ['50%','90%'],
                content: str //注意，如果str是object，那么需要字符拼接。
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
	    },
	    params : function(){
	        return {
	            userName : 'zhangsan',
	            age : 42
	        };
	    }
	});
    part.event();
});