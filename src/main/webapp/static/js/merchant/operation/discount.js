var discount = new Object();
discount.errorMsg = {};

discount.pageInit = function (){
    $.ajax({
        dataType:"html",
        type:"GET",
        url:ctx + "/coupon/getListGroupByBatch1",
        success:function(data){
            $("#discountBox").html(data);
            page.init(ctx + "/coupon/getListGroupByBatch1","","discountBox");
            page.pageHtml();
        },
        error:function(){
            console.log("请求失败");
        }
    });
}
//新增折扣券模态框打开
$('#discountBox').on('click','.inlineAdd .icon-add',function() {
    $('#discountId').val(1);
    $('#redEnvelopeTypeGroup').hide(300);
    //数据清空
    iform.cleanForm('discountForm');
    $('.discountModal').modal('show');
})

//编辑折扣券模态框打开
$('#discountBox').on('click','.icon-edit',function() {
    $('#discountId').val(0);
    var mydata = $(this).parents('tr').find('.mydata').data();
    iform.pushForm('discountForm',mydata);
    if(mydata.activateNumber>0){
        imessenger.error("该批次已有激活折扣券，无法修改！")
        return;
    }
    if(mydata.parentId!=""){
        $('#redEnvelopeTypeGroup').show(300);
    }
    $('.discountModal').modal('show');
})

//折扣券的验证
$('[data-btn="discountBtn"]').on('click',function() {
    var datas = iform.parseForm('discountForm');
    //折扣比例的验证
    var _b = c.checkMyPositive('#discountForm',discount,datas.ratio,"ratio",0,10);
    //数量的验证
    var _c = c.checkMyNum('#discountForm',discount,datas.number,"receiveNumber",0,Infinity);
    //通过验证
    if(_b&&_c) {
        //新增
        if($('#discountId').val() == 1) {
            $.ajax({
                url: ctx+"/coupon/generate" ,
                type: 'post',
                dataType: 'json',
                data:datas,
                success: function (dbdata) {
                    if (dbdata.code == 200) {
                        imessenger.success("生成折扣券成功");
                        $('.discountModal').modal('hide');
                        page.paging();
                    } else {
                        imessenger.error(dbdata.errorMsg);
                    }
                }
            })
        }
        //编辑
        else if($('#discountId').val() == 0) {
            $.ajax({
                url: ctx+"/coupon/updateGenerate" ,
                type: 'post',
                dataType: 'json',
                data:datas,
                success: function (dbdata) {
                    if (dbdata.code == 200) {
                        imessenger.success("修改折扣券成功");
                        $('.discountModal').modal('hide');
                        page.paging();
                    } else {
                        imessenger.error(dbdata.errorMsg);
                    }
                }
            })
        }
    }


})



//折扣券激活模态框打开
$('#discountBox').on('click','.icon-activate',function() {
    var mydata = $(this).parents('tr').find('.mydata').data();
    iform.pushForm('activateForm',mydata);
    $('.activateModal').modal('show');
})

//折扣券激活模态框提交
$('[data-btn="activateBtn"]').on('click',function() {
    var datas = iform.parseForm('activateForm');
    //数量的验证
    var _a = c.checkMyNum('#activateForm',discount,datas.number,"number",0,Infinity);
    if(datas.number>(datas.totalNumber-datas.activateNumber)){
        imessenger.error("激活折扣券数量超出未激活折扣券总数！")
        return;
    }
    if(_a) {
        //执行下一步
        $.ajax({
            url: ctx+"/coupon/activateCoupon" ,
            type: 'post',
            dataType: 'json',
            data:datas,
            success: function (dbdata) {
                if (dbdata.code == 200) {
                    imessenger.success("激活折扣券成功");
                    $('.activateModal').modal('hide');
                    page.paging();
                } else {
                    imessenger.error(dbdata.errorMsg);
                }
            }
        })
    }
})


//折扣券发放模态框打开
/*$('.icon-grant').on('click',function() {
    var mydata = $(this).parents('tr').find('.mydata').data();
    iform.pushForm('grantForm',mydata);
    $('.grantModal').modal('show');
})*/
//折扣券发放模态框提交
/*$('[data-btn="grantBtn"]').on('click',function() {
    var datas = iform.parseForm('grantForm');
    //数量的验证
    var _a = c.checkMyNum('#grantForm',discount,datas.number,"number",0,Infinity);
    if(_a) {
        //执行下一步
    }
})*/



//删除
$('#discountBox').on('click','.icon-del',function() {
    var mydata = $(this).parents('tr').find('.mydata').data();
    $.confirm({
        title: '提示',
        content: '确定要删除吗？',
        confirm: function() {
            if(mydata.activateNumber>0){
                imessenger.error("该批次已有激活折扣券，无法删除！")
                return;
            }
            $.ajax({
                url: ctx+"/coupon/removeCoupon",
                type: 'post',
                dataType: 'json',
                data:{"batch":mydata.batch},
                success: function(dbdata) {
                    if (dbdata.code == 200) {
                        imessenger.success("删除成功！");
                        page.paging();
                    } else {
                        imessenger.error(dbdata.errorMsg);
                    }
                }
            })
        },
    });
})

//回收
$('#discountBox').on('click','.icon-recycling',function() {
    var mydata = $(this).parents('tr').find('.mydata').data();
    $.confirm({
        title: '提示',
        content: '确定要回收吗？',
        confirm: function() {
            $.ajax({
                url: ctx+"/coupon/callbackCoupon" ,
                type: 'post',
                dataType: 'json',
                data:{"batch":mydata.batch},
                success: function (dbdata) {
                    if (dbdata.code == 200) {
                        imessenger.success("回收红包成功");
                        page.paging();
                    } else {
                        imessenger.error(dbdata.errorMsg);
                    }
                }
            })
        },
    });
})
//选中产品时候显示产品联想
$('#redEnvelopeType').on('change',function() {
    if($(this).val() == 1) {
        $('#redEnvelopeTypeGroup').show(300);
    } else {
        $('#redEnvelopeTypeGroup').hide(300);
    }
})


//联想词汇
$("#productName").bind('keyup',function() {
    var name=$("#productName").val();
    $.ajax({
        url: ctx+"/product/getListByName" ,
        type: 'get',
        dataType: 'json',
        data:{"name":name},
        success: function (dbdata) {
            if (dbdata.code == 200) {
                var html = "";
                for (var i = 0; i < dbdata.data.length; i++) {
                    html += "<li class='products' value=" + dbdata.data[i].id + ">" + dbdata.data[i].name + "</li>";
                }
                $("#productList").html(html);
                $('#productList').slideDown(300);
            } else {
                imessenger.error(dbdata.errorMsg);
            }
        }
    })
});

$('#productList').on('click','.products',function() {
    var id=$(this).attr("value");
    var name=$(this).context.innerHTML;
    $("#productName").empty().val(name);
    $("#productId").empty().val(id);
    $('#productList').slideUp(300);
});



$(function() {
    discount.pageInit();
})

