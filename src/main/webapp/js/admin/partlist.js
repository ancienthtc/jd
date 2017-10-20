document.write("<script language=javascript src='../js/layer.js'></script>");
document.write("<script language=javascript src='../js/jquery-3.1.1.js'></script>");

var partlist = new Object();

partlist.init = function(){
    /*板块页面部分刷新*/
    $("#part").click(

        function(){
            $.ajax({
                url:"../part/toPartList",
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