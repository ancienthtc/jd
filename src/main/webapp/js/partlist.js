var partlist = new Object();

partlist.init = function(){
    /*商品页面部分刷新*/
    $("#part").click(

        function(){
            $.ajax({
                url:"../part/toPartList2",
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

  $(this).click(function(){

  });
}

$(function(){
    partlist.init();
})