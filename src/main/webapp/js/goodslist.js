var goodslist = new Object();

goodslist.init = function(){
    $("#good").click(

        function(){
            $.ajax({
                url:"../goods/toGoodsList2",
                type:"get",
                dataType:"html",
                success:function(data){
                    alert(data);
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