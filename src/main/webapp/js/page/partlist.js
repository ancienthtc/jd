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
	    			$(tr).append('<td></td>');
	    			$(tr).append('<td>'+row.pname+'</td>');
	    			$(tr).append('<td>'+row.type+'</td>');
	    			$(tr).append('<td>'+row.describe+'</td>');
	    			$(tr).append('<td>'+row.priority+'</td>');
	    			//$(tr).append('<td>'+row.phone1+'</td>');
	    			//$(tr).append('<td>'+row.email+'</td>');
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
});