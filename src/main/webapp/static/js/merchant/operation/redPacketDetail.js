var redpacketDetail = new Object();
 
$(function(){
	  var batch = $("#batch").val();
	  page.init(ctx + "/redPacket/getListByBatch1","batch="+batch+"&state=1","redpacketDiv");
      page.page=1;
//      page.paging();
      page.isPower=0;
      page.pageHtml();
})