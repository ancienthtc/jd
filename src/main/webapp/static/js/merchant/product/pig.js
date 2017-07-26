var pig = new Object();
pig.errorMsg = {}
pig.salesState=1;
pig.pageInit = function (){
    $.ajax({
        dataType:"html",
        type:"GET",
        url:ctx + "/pig/getPigList",
        data:"salesState=1",
        success:function(data){
            $("#pigDiv").html(data);
            page.init(ctx + "/pig/getPigList","salesState=1","pigDiv");
            page.pageHtml();
        },
        error:function(){
            console.log("请求失败");
        }
    });
}

//添加生猪模态框打开
$("#pigDiv").on('click','.icon-add',function() {
    $('#pigId').val(1);
    $('#createTime').val(0);
    $('#salesState').val(1);
	$('.pigModal').modal('show');
})


//编辑生猪模态框打开
$("#pigDiv").on('click','.icon-edit',function() {
    $('#pigId').val(0);
    var mydata = $(this).parents('tr').find('.mydata').data();
    console.log(mydata);
    iform.pushForm('pigForm',mydata);
	$('.pigModal').modal('show');
})


//生猪信息的提交
$('[data-btn="pigBtn"]').on('click',function() {
    var datas = iform.parseForm('pigForm');
    //验证钩号
    var _a = c.checkMyNum('#pigForm',pig,datas.hook,'hook',0,1000000);
    //验证重量
    var _b = c.checkMyPositive('#pigForm',pig,datas.weight,'weight',0,1000);
    //验证品种
    var _c = c.checkMyDes('#pigForm',pig,datas.varieties,'varieties',2,10);
    //等级
    var _d = c.checkMyDes('#pigForm',pig,datas.grade,'grade',2,10);
    //单价
    var _e = c.checkMyPositive('#pigForm',pig,datas.price,'price',0,1000);

    //全部通过验证
    if(_a&&_b&&_c&&_d&&_e) {
        //新增
        if( $('#pigId').val() == 1) {
            $.ajax({
                url: ctx+"/pig/save" ,
                type: 'post',
                dataType: 'json',
                data:datas,
                success: function (dbdata) {
                    if (dbdata.code == 200) {
                        imessenger.success("添加成功");
                        $('.pigModal').modal('hide');
                        page.paging();
                    } else {
                        imessenger.error(dbdata.errorMsg);
                    }
                }
            })
        }
        //修改
        else if( $('#pigId').val() == 0 ) {
            $.ajax({
                url: ctx+"/pig/update" ,
                type: 'post',
                dataType: 'json',
                data:datas,
                success: function (dbdata) {
                    if (dbdata.code == 200) {
                        imessenger.success("修改成功");
                        $('.pigModal').modal('hide');
                        page.paging();
                    } else {
                        imessenger.error(dbdata.errorMsg);
                    }
                }
            })
        }
    }
})
$("#wait").on('click',function() {
    pig.salesState=1;
    $(this).addClass("on");
    $("#already").removeClass("on");
    $.ajax({
        dataType:"html",
        type:"GET",
        url:ctx + "/pig/getPigList",
        data:"salesState=1",
        success:function(data){
            $("#pigDiv").html(data);
            page.init(ctx + "/pig/getPigList","salesState=1","pigDiv");
            page.pageHtml();
        },
        error:function(){
            console.log("请求失败");
        }
    });

})
$("#already").on('click',function() {
    pig.salesState=2;
    $(this).addClass("on");
    $("#wait").removeClass("on");
    $.ajax({
        dataType:"html",
        type:"GET",
        url:ctx + "/pig/getPigList",
        data:"salesState=2",
        success:function(data){
            $("#pigDiv").html(data);
            page.init(ctx + "/pig/getPigList","salesState=2","pigDiv");
            page.pageHtml();
        },
        error:function(){
            console.log("请求失败");
        }
    });

})



//生猪的删除
$("#pigDiv").on('click','.icon-del',function() {
    var mydata = $(this).parents('tr').find('.mydata').data();
    $.confirm({
        title: '确认删除',
        content: '确定要删除该信息吗？',
        confirm: function() {
            $.ajax({
                url: ctx+"/pig/remove",
                type: 'post',
                dataType: 'json',
                data:{"id":mydata.id},
                success: function(dbdata) {
                    if (dbdata.code == 200) {
                        imessenger.success("删除成功");
                        page.paging();
                    } else {
                        imessenger.success("删除失败");
                    }
                }
            })
        },
    });
});



//总价的计算
pig.changeMoneny = function() {
    $('#pigForm [name="weight"],#pigForm [name="price"]').on('change',function() {
        var a = parseFloat($('#pigForm [name="weight"]').val()) || 0;
        var b = parseFloat($('#pigForm [name="price"]').val()) || 0;
        var c = parseFloat(a*b).toFixed(2);
        $('#pigForm [name="total"]').val(c);
    })
}

//页面加载函数
$(function() {
    pig.pageInit();
    pig.changeMoneny();
    $('.btnGreen').on('click',function() {
        var content = $("#inlineFormInput").val();
        page.init(ctx + "/pig/getPigList","salesState="+pig.salesState+"&content="+content,"pigDiv");
        page.page=1;
        page.paging();
        page.pageHtml();
    })
})