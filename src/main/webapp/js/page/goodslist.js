var good =  new Object();
good.event = function(){
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
        var url = "../goods/toGoodDetail";
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
                    $(tr).append('<td>'+'<span class="iconfont icon-view"></span>'+'</td>');
                    $(tr).append('<td>'+'<span class="iconfont icon-del"></span>'+'</td>');
                    $(tr).append('<span  style="display:none">'+row.id+'</span>');
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
    good.event();
});