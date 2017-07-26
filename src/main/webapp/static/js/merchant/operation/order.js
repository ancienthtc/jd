var order = new Object();
order.orderPigId="";
order.pigId="";
order.payState=2;
order.pageInit = function (){
    $.ajax({
        dataType:"html",
        type:"GET",
        url:ctx + "/iorder/findOrderByUserId",
        data:{"content":"","payState":order.payState},
        success:function(data){
            $("#orderDiv").html(data);
            page.init(ctx + "/iorder/findOrderByUserId","payState="+order.payState+"&content=","orderDiv");
            page.page=1;
            page.pageHtml();
        },
        error:function(){
            console.log("请求失败");
        }
    });
}

$("#waitPay").on('click',function() {
    $(this).addClass("on");
    $("#alreadyPay").removeClass("on");
    $("#finishPay").removeClass("on");
    order.payState=2;
    $.ajax({
        dataType:"html",
        type:"GET",
        url:ctx + "/iorder/findOrderByUserId",
        data:{"content":"","payState":order.payState},
        success:function(data){
            $("#orderDiv").html(data);
            page.init(ctx + "/iorder/findOrderByUserId","payState="+order.payState+"&content=","orderDiv");
            page.page=1;
            page.pageHtml();
        },
        error:function(){
            console.log("请求失败");
        }
    });

})

$("#alreadyPay").on('click',function() {
    $(this).addClass("on");
    $("#waitPay").removeClass("on");
    $("#finishPay").removeClass("on");
    order.payState=1;
    $.ajax({
        dataType:"html",
        type:"GET",
        url:ctx + "/iorder/findOrderByUserId",
        data:{"content":"","payState":order.payState},
        success:function(data){
            $("#orderDiv").html(data);
            page.init(ctx + "/iorder/findOrderByUserId","payState="+order.payState+"&content=","orderDiv");
            page.page=1;
            page.pageHtml();
        },
        error:function(){
            console.log("请求失败");
        }
    });

})

$("#finishPay").on('click',function() {
    $(this).addClass("on");
    $("#alreadyPay").removeClass("on");
    $("#waitPay").removeClass("on");
    order.payState=3;
    $.ajax({
        dataType:"html",
        type:"GET",
        url:ctx + "/iorder/findOrderByUserId",
        data:{"content":"","payState":order.payState},
        success:function(data){
            $("#orderDiv").html(data);
            page.init(ctx + "/iorder/findOrderByUserId","payState="+order.payState+"&content=","orderDiv");
            page.page=1;
            page.pageHtml();
        },
        error:function(){
            console.log("请求失败");
        }
    });

})

$(function() {
    order.pageInit();
    //发货产品
    $('#orderDiv').on('click','.add',function() {
        var mydata = $(this).parents('div').find('.mydata').data();
        $.confirm({
            title: '确认发货',
            content: '您确认要发货吗？',
            confirm: function() {
                $(".add").attr("disabled","disabled");
                $.ajax({
                    url: ctx+"/iorder/sendProduct",
                    type: 'post',
                    dataType: 'json',
                    data:{"orderId":mydata.id},
                    success: function(dbdata) {
                        if (dbdata.code == 200) {
                            imessenger.success("发货成功")
                            page.paging();
                        } else {
                        }
                    }
                })
            }
        });
    });
  //配货
	$('#orderDiv').css({
    "height": $(window).height() - 176,
		"overflowY": "scroll"
  });
  $(window).resize(function() {
    $('#orderDiv').css({
      "height": $(window).height() - 176,
			"overflowY": "scroll"
    });
  });
	
	$('#orderDiv').on('click','.orderDetail .icon-picking',function() {
		var nowHeight =$(window).height()-61;
    //点击按钮，侧边展开详情
    $('.contentBox').attr('style', 'position:relative');
    var mydata = $(this).parents('tr').find('.mydata').data();
    $("#productName").html(mydata.name);
    $("#price").html(mydata.price);
    $("#varietiesName").html(mydata.varietiesName);
    $("#gradeName").html(mydata.gradeName);
    $("#weightRange").html(mydata.weightRange);
    $("#startWeight").html(mydata.startWeight);
    $("#endWeight").html(mydata.endWeight);
    $("#productId").html(mydata.id);
    $("#state").html(1);
    $.ajax({
        dataType:"html",
        type:"GET",
        url:ctx + "/iorder/findPigByProduct",
        data:mydata,
        success:function(data){
            $("#pigBox").html(data);
        },
        error:function(){
            console.log("请求失败");
        }
    });
    $('.slidePageBg').css({
			height:nowHeight
		}).fadeIn(300);
    $('.slidePage').show().animate({ right: "0px",height:nowHeight }, 500);
  });


    $('#orderDiv').on('click','.orderDetail .icon-repicking',function() {
        var nowHeight =$(window).height()-61;
        //点击按钮，侧边展开详情
        $('.contentBox').attr('style', 'position:relative');
        var mydata = $(this).parents('tr').find('.mydata').data();
        $("#productName").html(mydata.name);
        $("#price").html(mydata.price);
        $("#varietiesName").html(mydata.varietiesName);
        $("#gradeName").html(mydata.gradeName);
        $("#weightRange").html(mydata.weightRange);
        $("#startWeight").html(mydata.startWeight);
        $("#endWeight").html(mydata.endWeight);
        $("#productId").html(mydata.id);
        $("#state").html(2);
        $.ajax({
            dataType:"html",
            type:"GET",
            url:ctx + "/iorder/findPigByProduct",
            data:mydata,
            success:function(data){
                $("#pigBox").html(data);
            },
            error:function(){
                console.log("请求失败");
            }
        });
        $('.slidePageBg').css({
            height:nowHeight
        }).fadeIn(300);
        $('.slidePage').show().animate({ right: "0px",height:nowHeight }, 500);
    });

  $('.slidePageBg').on('click', function() {
    $(this).fadeOut();
    $('.slidePage').fadeOut();
  })

    $('.btnGreen').on('click',function() {
        var content = $("#inlineFormInput1").val();
        var varietiesName=$("#varietiesName").html();
        var gradeName=$("#gradeName").html();
        var startWeight=$("#startWeight").html();
        var endWeight=$("#endWeight").html();
        var price=$("#price").html();
        $.ajax({
            dataType:"html",
            type:"GET",
            url:ctx + "/iorder/findPigByProduct",
            data:{"content":content,"varietiesName":varietiesName,"gradeName":gradeName,"startWeight":startWeight,"endWeight":endWeight,"price":price},
            success:function(data){
                $("#pigBox").html(data);
            },
            error:function(){
                console.log("请求失败");
            }
        });
    })

    $('#pigBox').on('click','.pig',function() {
        $(this).parents('table').find('.pig').removeClass("choosed");
        $(this).addClass("choosed");
        order.orderPigId=$("#productId").html();
        var mydata=$(this).find('.mydata').data();
        order.pigId=mydata.id;
    })

    //配货
    $('#pigBox').on('click','.btnGreen',function() {
        var state=$("#state").html();
        if(state==1){
            $.confirm({
                title: '确认配货',
                content: '您确认要对该产品配货吗？',
                confirm: function() {
                    $.ajax({
                        url: ctx+"/iorder/preparePig",
                        type: 'post',
                        dataType: 'json',
                        data:{"orderPigId":order.orderPigId,"pigId":order.pigId},
                        success: function(dbdata) {
                            if (dbdata.code == 200) {
                                $('.slidePage').fadeOut();
                                $('.slidePageBg').fadeOut();
                                page.paging();
                            } else {
                            }
                        }
                    })
                }
            });
        }else{
            $.confirm({
                title: '修改配货',
                content: '您确认要对该产品修改配货吗？',
                confirm: function() {
                    $.ajax({
                        url: ctx+"/iorder/changePreparePig",
                        type: 'post',
                        dataType: 'json',
                        data:{"orderPigId":order.orderPigId,"pigId":order.pigId},
                        success: function(dbdata) {
                            if (dbdata.code == 200) {
                                $('.slidePage').fadeOut();
                                $('.slidePageBg').fadeOut();
                                page.paging();
                            } else {
                            }
                        }
                    })
                }
            });
        }

    });


    $('.search').on('click',function() {
        var content = $("#inlineFormInput").val();
        page.init(ctx + "/iorder/findOrderByUserId","payState="+order.payState+"&content="+content,"orderDiv");
        page.page=1;
        page.paging();
        page.pageHtml();
    })

    /**
     * 状态下拉框change事件
     */
    $("#state").change(function(){
        var parentId=$("#state").val();
        var content = $("#inlineFormInput").val();
        page.init(ctx + "/product/getListByUserId","content="+content,"productDiv");
        page.page=1;
        page.paging();
        page.pageHtml();
    });
})