/**
 * Created by ThinkPad on 2017/8/21.
 */
var orderlist = new Object();

orderlist.init = function(){    //统一跳转js
    /*板块页面部分刷新*/
    $("#order1").click( //待支付列表
        function(){
            $.ajax({
                url:"../order/toListPay",
                type:"get",
                dataType:"html",
                success:function(data){
                    $("#contentBoxId").html(data);
                },
                error:function(){
                    alert("页面出错");
                }
            });
        }
    );

    $("#order2").click( //待发货
        function(){
            $.ajax({
                url:"../order/toListLog",
                type:"get",
                dataType:"html",
                success:function(data){
                    $("#contentBoxId").html(data);
                },
                error:function(){
                    alert("页面出错");
                }
            });
        }
    );

    $("#order3").click( //待收货
        function(){
            $.ajax({
                url:"../order/toListSend",
                type:"get",
                dataType:"html",
                success:function(data){
                    $("#contentBoxId").html(data);
                },
                error:function(){
                    alert("页面出错");
                }
            });
        }
    );

    $("#order4").click( //待评价
        function(){
            $.ajax({
                url:"../order/toListComment",
                type:"get",
                dataType:"html",
                success:function(data){
                    $("#contentBoxId").html(data);
                },
                error:function(){
                    alert("页面出错");
                }
            });
        }
    );




    $("#order6").click( //已取消
        function(){
            $.ajax({
                url:"../order/toOrderCancel",
                type:"get",
                dataType:"html",
                success:function(data){
                    $("#contentBoxId").html(data);
                },
                error:function(){
                    alert("页面出错");
                }
            });
        }
    );

    $("#order7").click( //统计
        function(){
            $.ajax({
                url:"../order/toOrderAll",
                type:"get",
                dataType:"html",
                success:function(data){
                    $("#contentBoxId").html(data);
                },
                error:function(){
                    alert("页面出错");
                }
            });
        }
    );


}

$(function(){
    orderlist.init();
})