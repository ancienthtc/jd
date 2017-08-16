/**
 * Created by ThinkPad on 2017/8/15.
 */

var nopay =  new Object();
nopay.event = function(){
    $("#dataGridTableJson").on("click",".icon-create",function(){
        var id = $(this).parent().nextAll("span").text();
        //alert(id);
        $.ajax({
            url: "../order/##",
            data: {"id": id},
            type: "post",
            dataType: "html",
            success: function (data) {
                $("#contentBoxId").html(data);
            },
            error: function () {
                alert("请求失败");
            }
        });
    })

    // $(".show").click(function(){
    //     var uuid=$(this).parent().attr("value");
    //     alert(uuid);
    // })

    $("#dataGridTableJson").on("click",".show",function(){
        //alert(1);
        //console.log($(this));
        var uuid=$(this).attr("value");
        $.ajax({
            url: "../order/getDetail",
            data: {"json": uuid},
            type: "post",
            dataType: "json",
            success: function (data) {
                //$("#contentBoxId").html(data);
                console.log("1:"+data);
                $.each(data.Goods, function (i, row) {


                });
            },
            error: function (date) {
                //console.log("2:"+data);
                alert("请求失败");
            }
        });
        //alert(uuid);
    })

}

$(function () {
    $('#page3').bPage({
        url: '/JDWebShop/order/queryNoPay',
        asyncLoad: true,
        asyncType: 'GET',
        serverSidePage: false,
        render: function (data) {
            //console.log(data);
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
                        row.shopstatus="已发货";
                    }
                    else if(row.shopstatus==2)
                    {
                        row.shopstatus="已收货";
                    }
                    else if(row.shopstatus==3)
                    {
                        row.shopstatus="待评论";
                    }
                    else if(row.shopstatus==4)
                    {
                        row.shopstatus="已评论";
                    }

                    var tr = $('<tr>');
                    $(tr).append('<td class="show" name="uuid" value="'+row.uuid+'"><a  href="javascript:void(0)">' + row.uuid + '</a></td>');
                    $(tr).append('<td>' + row.ordertime2 + '</td>');
                    $(tr).append('<td>' + row.shopstatus + '</td>')
                    $(tr).append('<td>' + row.paystatus + '</td>');
                    $(tr).append('<td>' + row.limit2 + '</td>');
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
    nopay.event();

});