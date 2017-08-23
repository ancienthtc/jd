/**
 * Created by ThinkPad on 2017/8/18.
 */
var noaccept =  new Object();
noaccept.event = function(){

    //收货
    $("#dataGridTableJson").on("click",".icon-create",function(){
        var uuid = $(this).parent().parent().find(".show").attr("value");
        console.log(uuid);
        $.confirm({
            title: '确认收货?',
            content: '确认收货?',
            confirm: function(){
                //$.alert('Confirmed!');
                $.ajax({
                    url: "../order/accept",
                    data: {"json": uuid},
                    type: "post",
                    dataType: "html",
                    success: function (data) {
                        $("#contentBoxId").html(data);
                    },
                    error: function (date) {
                        alert("请求失败");
                    }
                });
            },
            cancel: function(){
                //$.alert('Canceled!')
            }
        });


    })




    $("#dataGridTableJson").on("click",".show",function() {
        var uuid = $(this).attr("value");
        $.ajax({
            url: "../order/getLogistics",
            data: {"json": uuid},
            type: "post",
            dataType: "html",
            success: function (data) {
                layer.open({
                    type: 1,  //获取页面层信息
                    skin: "layui-layer-molv",
                    border: [1],
                    area: ['40%', '80%'],
                    content: data    //把result转为jQuery对象
                });
            },
            error: function (date) {
                alert("请求失败");
            }
        });
    })
}

$(function () {
    $('#page3').bPage({
        url: '/JDWebShop/order/queryNoAccept',
        asyncLoad: true,
        asyncType: 'GET',
        serverSidePage: false,
        render: function (data) {
            console.log(data);
            var tb = $('#dataGridTableJson tbody');
            $(tb).empty();
            if (data && data.dataList && data.dataList.length > 0) {
                $.each(data.dataList, function (i, row) {
                    for (var s in row) {
                        if (row[s] == null || row[s] == "" || row[s] == undefined) {
                            row[s] = "";
                        }
                    }
                    ;
                    if (row.time != "" && row.time != undefined) {
                        /*将时间字符串转化为日期*/
                        var time = new Date(row.time);
                        row.time = time.getFullYear() + "-" + (time.getMonth() + 1) + "-" + time.getDate();
                    } else {
                        row.time = "";
                    }

                    //判断0
                    if(row.paystatus=="")
                    {
                        row.paystatus="未付款";
                    }
                    else if(row.paystatus==1)
                    {
                        row.paystatus="已支付";
                    }
                    else if(row.paystatus==2)
                    {
                        row.paystatus="已取消";
                    }
                    if(row.shopstatus=="")
                    {
                        row.shopstatus="未发货";
                    }
                    else if(row.shopstatus==1)
                    {
                        row.shopstatus="待收货";
                    }
                    else if(row.shopstatus==2)
                    {
                        row.shopstatus="待评价";
                    }
                    else if(row.shopstatus==3)
                    {
                        row.shopstatus="已评论";
                    }

                    var tr = $('<tr>');
                    $(tr).append('<td class="show" name="uuid" value="'+row.uuid+'"><a  href="javascript:void(0)">' + row.uuid.replace("-","") + '</a></td>');
                    $(tr).append('<td>' + row.ordertime2 + '</td>');
                    $(tr).append('<td>' + row.shopstatus + '</td>');
                    $(tr).append('<td>' + row.paystatus + '</td>');
                    //$(tr).append('<td>' + row.limit2 + '</td>');
                    $(tr).append('<td>' + row.allprice + '</td>');
                    $(tr).append('<td>'+'<span class="iconfont icon-create"></span>'+'</td>');
                    $(tr).append('<span  style="display:none">' + row.id + '</span>');
                    $(tr).append('</tr>');
                    $(tb).append(tr);
                });
            }
        },
        params: function () {
            return {
            };
        }
    });
    noaccept.event();

});