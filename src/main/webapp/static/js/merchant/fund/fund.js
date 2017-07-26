var fund = new Object();
fund.errorMsg = {};

fund.init = function (){
	/**
	 * 调用乾多多页面需要定向session值，所以需要重新 屏蔽
	 */
	 var indexPoin = $("#indexPoin").val();
	 var state = 0;
	  if(indexPoin != undefined && indexPoin != ""){
		  state=1;
	  }
	$.ajax({
        dataType:"json",
        type:"GET",
      
        url:ctx + "/account/getAccountInfo",
        success:function(data){
          if(data.code==200){
        	  
        	  if(data.data.photoUrl==null || data.data.photoUrl==""){
        		  $("#fundDiv .imgBox").html("<img src=\"../../../static/img/merchant/default.png\" />");
        	  }else{
        		  $("#fundDiv .imgBox").html("<img src=\""+data.data.photoUrl+"\" />");
        	  }
          		
        	  $("#fundDiv .price .num").html(data.data.balance);
          }
         
        },
        error:function(){
            console.log("请求失败");
        }
    });
}
/**
 * 查询资金流的方法
 */
fund.terraceCashFlow = function (){
	$.ajax({
        dataType:"HTML",
        type:"GET",
      
        url:ctx + "/terraceCashFlow/getListByUserId",
        success:function(data){
        	$("#terrace_cash_flow").html(data);
        	page.init(ctx + "/terraceCashFlow/getListByUserId","","terrace_cash_flow");
			page.pageHtml();
        },
        error:function(){
            console.log("请求失败");
        }
    });
}
/**
 * 绑定事件
 */
fund.event = function (){
	$('[data-btn="rechargeBtn"]').on('click', function () {
		$('.rechargeModal').modal('show');
		
	})
	
	$('[data-btn="recharge"]').on('click', function () {
		   var money = $('#rechargeForm [name="Amount"]').val();
		   //验证金额
		   var moneyOk = c.checkMyPositive('#rechargeForm',fund,money,'Amount',2,50000);
		   //确认充值执行ajax
		   if(moneyOk) {
			   $("#rechargeForm").attr('action',ctx+ "/paymentCotronller/toloanrecharge");    //通过jquery为action属性赋值
		       $("#rechargeForm").submit();    //提交ID为myform的表单	
		   }
	})
	
	$('[data-btn="withdrawBtn"]').on('click', function () {
		$('.withdrawModal').modal('show');
	})
	
	$('[data-btn="withdraw"]').on('click', function () {
		var money = $('#withdrawForm [name="Amount"]').val();
		//验证金额
		var moneyOk = c.checkMyPositive('#withdrawForm',fund,money,'Amount',2,50000);
		if(moneyOk) {
		  //确认提现执行ajax
		  $("#withdrawForm").attr('action',ctx+ "/paymentCotronller/toloanwithdraws");    //通过jquery为action属性赋值
	      $("#withdrawForm").submit();    //提交ID为myform的表单
		}
	})
	
	/**
	 * 账单类型改变
	 */
	$(".selectGroup").on('change','#terrace_cash_flow_selectType',function(){
			/**
			 * 账单的选中值 
			 */
			var type = $("#terrace_cash_flow_selectType").val();
			var time = $("#timeSelect").val();
			
			$.ajax({
		        dataType:"HTML",
		        type:"GET",
		        data:{
		        	"type":type,
		        	"time":time
		        },
		        url:ctx + "/terraceCashFlow/getListByUserId",
		        success:function(data){
		        	$("#terrace_cash_flow").html(data);
		        	page.init(ctx + "/terraceCashFlow/getListByUserId","","terrace_cash_flow");
					page.pageHtml();
		        },
		        error:function(){
		            console.log("请求失败");
		        }
		    });
	})
	/**
	 * 时间变化
	 */
	$(".selectGroup").on('change','#timeSelect',function(){
			/**
			 * 账单的选中值 
			 */
			var type = $("#terrace_cash_flow_selectType").val();
			var time = $("#timeSelect").val();
			
			$.ajax({
		        dataType:"HTML",
		        type:"GET",
		        data:{
		        	"type":type,
		        	"time":time
		        },
		        url:ctx + "/terraceCashFlow/getListByUserId",
		        success:function(data){
		        	$("#terrace_cash_flow").html(data);
		        	page.init(ctx + "/terraceCashFlow/getListByUserId","","terrace_cash_flow");
					page.pageHtml();
		        },
		        error:function(){
		            console.log("请求失败");
		        }
		    });
	})
	
}
/**
 * 银行列表的初始化
 */
fund.bankInit = function(){

	$.ajax({
        dataType:"json",
        type:"GET",
       
        url:ctx + "/card/getListByUserId",
        success:function(data){
        	if(data.code==200){
        		//银行卡列表刷新成功
        		
        		var html = "";
        		for(var t in data.data){
        			html += "<option value='"+data.data[t].bankCard+"'>"+data.data[t].bankCardStr+"</option>";
        		}
        		$(".bankCard").html(html);
        	}
        },
        error:function(){
            console.log("请求失败");
        }
    });
}
$(function(){	
	fund.init();
	fund.terraceCashFlow();
	fund.event();
	fund.bankInit();
	
})