
var page = new Object();
//设置默认当前页数
page.page = 1;
//设置每页显示的个数
page.pageSize =3;
//设置总条数
page.total = 0;
//设置转向url
page.url="";
//设置请求参数
page.data;
//请求切换页面的id
page.htmlId;
//绑定事件的方法
page.bind;

page.init = function(url,data,htmlId,bindEvent){
	var pageSize = $(".pageData").data("pageSize");
	var total = $(".pageData").data("total");
	page.pageSize  = pageSize;
	page.total  = total;
	page.url = url;
	page.data = data;
	page.htmlId = htmlId;
	page.bind = bindEvent;

}
/**
 * 上一页
 */
page.previousPage = function(){
	
	if(page.page==1){
		page.page = 1;
	}else{
		page.page -=1;
		page.paging();
	}
	
}
/**
 * 下一页
 */
page.nextPage = function(){
	   var num = Math.ceil(page.total/page.pageSize);
	 
	if(page.page==num){
		page.page = num;
	}else{
		page.page +=1;
		page.paging();
	}
	
}
/**
 * 跳转指定页数
 */
page.toPageNo = function(num){
	  
	page.page = num;
	
	page.paging();
	
	
}
page.paging = function(){
	 var num = Math.ceil(page.total/page.pageSize);
	if(page.page>=num){
		page.page = num;
	}
	if(page.page==0){
        page.page=1;
	}
	$.ajax({
		dataType:"html",
		type:"GET",
		data:page.data+"&page="+page.page,
		url:page.url,
		success:function(data){
			//替换页面
			$("#"+page.htmlId).html(data);
			page.bind;
			//执行分页
			page.pageHtml();
		},
		error:function(){
			console.log("请求失败");
		}
	})
}
page.pageHtml = function() {
    var pageSize = $("#" + page.htmlId + " .pageData").data("pageSize");
    var total = $("#" + page.htmlId + " .pageData").data("total");
    page.pageSize = pageSize;
    page.total = total;

    if (total == 0) {
        $(".nav").html("");
        return;
    }
    /**
     * 算出总页数
     */
    var num = Math.ceil(page.total / page.pageSize);
    /**
     * 分页html
     */
    var html = "<span class='paginationTotal'>共有" + total + "条， 每页显示：" + pageSize + "条,共" + num + "页</span>"
    html += "<ul class='pagination'>" +
        "<li class=\"page-item\">" +
        "<a class=\"page-link\"  href=\"javascript:void(0);\" onClick ='page.previousPage()' aria-label=\"Previous\">" +
        "	<span aria-hidden=\"true\">&laquo;</span>" +
        "	<span class=\"sr-only\">上一页</span>" +
        "</li>";
    //总页数

    if (num > 5) {
        if (((num - page.page)) < 3) {
            /**
             * 如果是最后一页
             */
            for (var i = num - 4; i <= num; i++) {
                if (page.page == i) {
                    html += "<li class=\"page-item active\"><a class=\"page-link\" onClick ='page.toPageNo(" + (i) + ")'  href=\"javascript:void(0);\">" +
                        (i) + "</a></li>";
                } else {
                    html += "<li class=\"page-item\"><a class=\"page-link\" onClick ='page.toPageNo(" + (i) + ")'  href=\"javascript:void(0);\">" +
                        (i) + "</a></li>";
                }

            }
        } else {
            var pageNo = 0;
            if (page.page == 1) { //第一页
                pageNo += 2;
            }
            if (page.page == 2) { //第一页
                pageNo += 1;
            }
            for (var i = page.page - 2; i <= page.page + 2; i++) {

                if (page.page == i + pageNo) {

                    html += "<li class=\"page-item active\"><a class=\"page-link\" onClick ='page.toPageNo(" + (pageNo + i) + ")'  href=\"javascript:void(0);\">" +
                        (pageNo + i) + "</a></li>";
                } else {
                    html += "<li class=\"page-item\"><a class=\"page-link\" onClick ='page.toPageNo(" + (pageNo + i) + ")'  href=\"javascript:void(0);\">" +
                        (pageNo + i) + "</a></li>";
                }

            }
        }

    } else {
        for (var i = 0; i < num; i++) {
            if ((page.page - 1) == i) {

                html += "<li class=\"page-item active\"><a class=\"page-link\" onClick ='page.toPageNo(" + (i + 1) + ")' href=\"javascript:void(0);\">" +
                    (i + 1) + "</a></li>";
            } else {
                html += "<li class=\"page-item\"><a class=\"page-link\" onClick ='page.toPageNo(" + (i + 1) + ")' href=\"javascript:void(0);\">" +
                    (i + 1) + "</a></li>";
            }

        }
    }

    html += "<li class=\"page-item\">" +
        "<a class=\"page-link\" href=\"javascript:void(0);\"  onClick ='page.nextPage()' aria-label=\"Next\">" +
        "<span aria-hidden=\"true\">&raquo;</span>" +
        "<span class=\"sr-only\">下一页</span>" +
        "</a>" +
        "</li>" +
        "</ul>";
    //替换页面
    $(".nav").html(html);

}