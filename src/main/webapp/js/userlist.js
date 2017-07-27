/**
 * Created by ThinkPad on 2017/7/27.
 */
var userlist = new Object();

userlist.init = function(){
    /*商品页面部分刷新*/
    $("#user").click(

        function(){
            $.ajax({
                url:"../user/tolist",
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
    userlist.init();
})