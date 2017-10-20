document.write("<script language=javascript src='../js/layer.js'></script>");
document.write("<script language=javascript src='../js/jquery-3.1.1.js'></script>");
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
                    // layer.open({
                    //     type: 2,
                    //     area: ['800px', '800px'],
                    //     //content: '../goods/toGoodDetail'
                    //     content: data
                    // });
                },
                error:function(){
                    alert("页面出错");
                }
            });

            //new
            //var url = "../goods/toGoodsList2";
            // $.post(url,function(result){ //通过Ajax发送请求到后台
            //     layer.open({
            //         type : 1,  //获取页面层信息
            //         btn : ['取消','确定'],
            //         skin : "layui-layer-molv",
            //         border : [1],
            //         area : ['86%','90%'],
            //         content : result    //把result转为jQuery对象
            //     });
            // });

            // $.post(url, {}, function(str){
            //     layer.open({
            //         type: 1,
            //         area : ['86%','90%'],
            //         content: str //注意，如果str是object，那么需要字符拼接。
            //     });
            // });

        });

}

$(function(){
    goodslist.init();
})