var redpacket = new Object();
redpacket.errorMsg = {
    name: '未知错误',
    url: '未知错误',
    description: '未知错误',
    type: '未知错误',
    money:'未知错误'
}

redpacket.pageInit = function (){
    $.ajax({
        dataType:"html",
        type:"GET",
        url:ctx + "/redPacket/getListByFromIdGroupByBatch1",
        data:{"query":""},
        success:function(data){
            $("#redpacketBox").html(data);
            page.init(ctx + "/redPacket/getListByFromIdGroupByBatch1","query=","redpacketBox");
            page.page=1;
            page.pageHtml();
        },
        error:function(){
            console.log("请求失败");
        }
    });
}

$('#redpacketBox').on('click','.icon-view',function() {
    var mydata = $(this).parents('tr').find('.mydata').data();

    $('.contentBox').load(ctx + "/redPacket/getListByBatch1?batch=" +mydata.batch);

})

//红包的新增模态框打开
$('#redpacketBox').on('click','.icon-add',function() {
    //添加模态框传值1
    $('#redpacketId').val(1);
    //清空错误提示
    $('.tips').text('');
    $('#redEnvelopeTypeGroup').hide(300);
    //清空模态框
    $('#redpacketForm')[0].reset();
    //模态框打开
    $('.redpacketModal').modal('show');
})

//红包的编辑模态框打开
$('#redpacketBox').on('click','.icon-edit',function() {
    //添加模态框传值1
    $('#redpacketId').val(0);
    //清空错误提示
    $('.tips').text('');
    //清空模态框
    $('#redpacketForm')[0].reset();
    //填充模态框
    var mydata = $(this).parents('tr').find('.mydata').data();
    if(mydata.activateNumber>0){
        imessenger.error("该批次红包已有激活红包，无法修改！")
        return;
    }
    iform.pushForm('redpacketForm',mydata);
    if(mydata.parentId!=""){
        $('#redEnvelopeTypeGroup').show(300);
    }
    //模态框弹出
    $('.redpacketModal').modal('show'); 
})



//红包激活的模态框打开
$('#redpacketBox').on('click','.icon-activate',function() {
    //清空错误提示
    $('.tips').text('');
    //清空模态框
    $('#activateForm')[0].reset();
    //填充模态框
    var mydata = $(this).parents('tr').find('.mydata').data();
    iform.pushForm('activateForm',mydata);
    //模态框弹出
    $('.activateModal').modal('show'); 
})


//红包发放的模态框打开
$('#redpacketBox').on('click','.icon-grant',function() {
    //清空错误提示
    $('.tips').text('');
    //清空模态框
    $('#grantForm')[0].reset();
    //填充模态框
    var mydata = $(this).parents('tr').find('.mydata').data();
    iform.pushForm('grantForm',mydata);
    //模态框弹出
    $('.grantModal').modal('show'); 
})



//红包编辑和新增提交
redpacket.editForm = function() {
    /*
     * 添加1     修改0
     */
     $('[data-btn="redpacketBtn').on('click', function() {
        var datas = iform.parseForm('redpacketForm');
        //检测红包名称的合法性
        console.log(datas)
        var nameOk = c.checkMyDes('#redpacketForm', redpacket, datas.name, 'name', 2, 10);
        //检测金额的合法性
        var monenyOK = c.checkMyPositive('#redpacketForm', redpacket, datas.money, 'money', 0 , Infinity);
        //检测数量的合法性
        var numberOk = c.checkMyNum('#redpacketForm', redpacket, datas.number, 'number', 0, Infinity);
        //检查通过后执行保存
        if (nameOk && monenyOK && numberOk) {
            if ($('#redpacketId').val() == 1) {
                //执行添加方法
                $.ajax({
                    url: ctx+"/redPacket/generate" ,
                    type: 'post',
                    dataType: 'json',
                    data:datas,
                    success: function (dbdata) {
                        if (dbdata.code == 200) {
                            imessenger.success("生成红包成功");
                            $('.redpacketModal').modal('hide');
                            page.paging();
                        } else {
                            imessenger.error(dbdata.errorMsg);
                        }
                    }
                })
            } else if ($('#redpacketId').val() == 0) {
                //执行修改方法
                $.ajax({
                    url: ctx+"/redPacket/updateGenerate" ,
                    type: 'post',
                    dataType: 'json',
                    data:datas,
                    success: function (dbdata) {
                        if (dbdata.code == 200) {
                            imessenger.success("修改红包成功");
                            $('.redpacketModal').modal('hide');
                            page.paging();
                        } else {
                            imessenger.error(dbdata.errorMsg);
                        }
                    }
                })
            }
        } 
    });
 }

// 删除
$('#redpacketBox').on('click','.icon-del',function() {
    var mydata = $(this).parents('tr').find('.mydata').data();
    $.confirm({
        title: '删除提示',
        content: '确定要删除该批次的红包吗？',
        confirm: function() {
            if(mydata.activateNumber>0){
                imessenger.error("该批次红包已有激活红包，无法删除！")
                return;
            }
            $.ajax({
                url: ctx+"/redPacket/removeRed",
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
        }
    });
});

//激活
redpacket.activate = function() {
    $('[data-btn="activateBtn').on('click', function() {
        var datas = iform.parseForm('activateForm');
        console.log(datas);
        //验证
        var numOk = c.checkMyNum('#activateForm',redpacket,datas.number,"number",0,Infinity);

        if(datas.number>(datas.totalNumber-datas.activateNumber)){
            imessenger.error("激活红包数量超出未激活红包总数！")
            return;
        }
        //检查通过后执行保存
        if (numOk) {
            $('#batch').val(datas.batch);
            $('#number').val(datas.number);
            $('#term').val(datas.term);
            $('#type').val(2);
            $("#redpacketForms").attr('action',ctx+ "/redPacket/activateRedPay");    //通过jquery为action属性赋值
            $("#redpacketForms").submit();    //提交ID为myform的表单
            //执行添加方法
           /* $.ajax({
                url: ctx+"/redPacket/activateRed" ,
                type: 'post',
                dataType: 'json',
                data:datas,
                success: function (dbdata) {
                    if (dbdata.code == 200) {
                        imessenger.success("激活红包成功");
                        $('.activateModal').modal('hide');
                        page.paging();
                    } else {
                        imessenger.error(dbdata.errorMsg);
                    }
                }
            })*/
        }
    });
}

// 发放
redpacket.grant = function() {
    $('[data-btn="grantBtn').on('click', function() {
        var datas = iform.parseForm('grantForm');
        //验证
        var numOk = c.checkMyNum('#activateForm',redpacket,datas.number,"number",0,9999);
        if(datas.number>(datas.activateNumber-datas.sueNumber)){
            imessenger.error("发放红包数量超出未发放红包总数！")
            return;
        }
        //检查通过后执行保存
        if (numOk) {

            //执行添加方法
            $.ajax({
                url: ctx+"/redPacket/releaseRed" ,
                type: 'post',
                dataType: 'json',
                data:datas,
                success: function (dbdata) {
                    if (dbdata.code == 200) {
                        imessenger.success("发放红包成功");
                        $('.grantModal').modal('hide');
                        page.paging();
                    } else {
                        imessenger.error(dbdata.errorMsg);
                    }
                }
            })
        }
    });
}

// 回收
$('#redpacketBox').on('click','.icon-recycling',function() {
    var mydata = $(this).parents('tr').find('.mydata').data();
    $.confirm({
        title: '回收提示',
        content: '确定要回收该批次的红包吗？',
        confirm: function() {
            $.ajax({
                url: ctx+"/redPacket/callbackRed" ,
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
        }
    });
});




redpacket.changeMoneny = function() {
    $('.redpacketModal [name="money"],.redpacketModal [name="number"]').on('change',function() {
        var a = parseFloat($('.redpacketModal [name="money"]').val()) || 0;
        var b = parseInt($('.redpacketModal [name="number"]').val()) || 0;
        var c = parseFloat(a*b).toFixed(2);
        $('#allMoneyIsHere').val(c);
    })
}

$(function() {
    //操作提示气泡
    $('[data-toggle="tooltip"]').tooltip();

    $('.contentBox').on('click','.redpacketBack',function() {
    	
        var content = $("#inlineFormInput").val();
        
        page.init(ctx + "/redPacket/getListByFromIdGroupByBatch1","query="+content,"redpacketBox");
        //搜索 把页数重置为1
        page.page=1;
        page.paging();
    })
    $('.contentBox').on('click','.redpacketBack',function() {
      $('.contentBox').load("../../../templates/merchant/operation/redpacket.html");
  })

    $('.btn-success').on('click',function() {
        $('.messageModal').modal('hide');
    })
    redpacket.pageInit();
    //编辑、修改的提交
    redpacket.editForm();

    // 删除确认
    //redpacket.confirmDel($('.icon-del'));
    // 激活提交
    redpacket.activate();
    // 发放提交
    redpacket.grant();
    // 回收确认
    //redpacket.confirmActivate($('.icon-recycling'));
    //总金额
    redpacket.changeMoneny();
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