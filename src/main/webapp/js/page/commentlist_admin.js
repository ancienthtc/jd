/**
 * Created by ThinkPad on 2017/8/24.
 */
var comment =  new Object();
comment.event = function(){

    $("#dataGridTableJson").on("click",".icon-del",function () {
        var id = $(this).parent().nextAll("span").text();

        $.confirm({
            title: '提示',
            content: '确定要删除吗？',
            confirm: function() {
                $.ajax({
                    url:"../comment/del",
                    data:{"id":id},
                    type:"get",
                    dataType:"json",
                    success:function(data){
                        console.log(data)
                        if(data=='true' || data==true){
                            imessenger.success("删除成功");
                        }else if(data=='false' || data==false){
                            imessenger.error("删除失败，请检查商品");
                        }
                        else {
                            imessenger.error("删除失败");
                        }

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
                    },
                    error:function(){
                        imessenger.error("请求失败");
                    }
                })

            }
        });
    });


}


$(function(){
    $('#page3').bPage({
        url : '/JDWebShop/comment/getAll',
        asyncLoad : true,
        asyncType : 'GET',
        serverSidePage : false,
        render : function(data){
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

                    var tr = $('<tr>');
                    var star = "<img src="+"../lib/img/star-on.png" +'  title="bad">';
                    if(row.grade==1){
                        star = star;
                    }else if(row.grade==2){
                        star = star+star;
                    }else if(row.grade==3){
                        star = star+star+star;
                    }else if(row.grade==4){
                        star = star+star+star+star;
                    }else if(row.grade==5){
                        star = star+star+star+star+star;
                    }else{
                        star="";
                    }

                    $(tr).append('<td>' + star + '</td>');
                    $(tr).append('<td>'+row.time+'</td>');
                    $(tr).append('<td>'+row.comment+'</td>');
                    $(tr).append('<td>'+row.name+'</td>');
                    $(tr).append('<td>'+row.nickname+'</td>');
                    $(tr).append('<td>'+'<span class="iconfont icon-del"></span>'+'</td>');
                    $(tr).append('<span  style="display:none">'+row.id+'</span>');
                    $(tr).append('</tr>');
                    $(tb).append(tr);
                });
            }
        }
    });
    comment.event();
});