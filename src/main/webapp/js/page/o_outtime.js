/**
 * Created by ThinkPad on 2017/8/23.
 */
var outtime =  new Object();
outtime.event = function(){
    $("#dataGridTableJson").on("click",".icon-del",function(){
        var id = $(this).parent().nextAll("span").attr("value");
        //alert(id);
        $.confirm({
            title: '提示',
            content: '确定要删除吗？',
            confirm: function() {
                $.ajax({
                    url:"../order/OrderDel",
                    data:{"uuid":id},
                    type:"get",
                    dataType:"json",
                    success:function(data){
                        console.log(data)
                        if(data=='true' || data==true){
                            imessenger.success("删除成功");
                        }else if(data=='false' || data==false){
                            imessenger.error("删除失败");
                        }
                        else {
                            imessenger.error("删除失败");
                        }

                        $.ajax({
                            url:"../order/toOutTime",
                            type:"get",
                            dataType:"html",
                            success:function(data){
                                $("#contentBoxId").html(data);
                            },
                            error:function(){
                                alert("页面出错");
                            }
                        });
                    },
                    error:function(){
                        imessenger.error("请求失败");
                    }
                })

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
            dataType: "html",
            success: function (data) {
                //$("#contentBoxId").html(data);
                //console.log("1:"+data);
                layer.open({
                    type : 1,  //获取页面层信息
                    skin : "layui-layer-molv",
                    border : [1],
                    area : ['40%','80%'],
                    content : data    //把result转为jQuery对象
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
        url: '/JDWebShop/order/queryOutTime',
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
                    $(tr).append('<td>' + row.shopstatus + '</td>')
                    $(tr).append('<td>' + row.paystatus + '</td>');
                    $(tr).append('<td>' + row.limit2 + '</td>');
                    $(tr).append('<td>' + row.allprice + '</td>');
                    $(tr).append('<td>'+'<span class="iconfont icon-del"></span>'+'</td>');
                    $(tr).append('<span  style="display:none" value="'+row.uuid+'">' + row.id + '</span>');
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
    outtime.event();

});