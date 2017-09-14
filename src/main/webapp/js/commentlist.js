/**
 * Created by ThinkPad on 2017/8/23.
 */
var commentlist = new Object();

commentlist.init = function(){
    /*板块页面部分刷新*/
    $("#comment").click(
        function(){
            $.ajax({
                url:"../comment/toCommentList2",
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
    commentlist.init();
})