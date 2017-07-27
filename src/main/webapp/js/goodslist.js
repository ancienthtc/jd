var goodslist = new Object();

goodslist.init = function(){
    /*商品页面部分刷新*/
    $("#good").click(

        function(){
            $.ajax({
                url:"../goods/toGoodsList2",
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
    goodslist.init();
})