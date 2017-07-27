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
	    			var tr = $('<tr>');
	    			$(tr).append('<td></td>');
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
});