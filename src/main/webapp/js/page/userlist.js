/**
 * Created by ThinkPad on 2017/7/27.
 */
$(function(){
    $('#page').bPage({
        url : '/JDWebShop/user/list_get',
        asyncLoad : true,
        asyncType : 'GET',
        serverSidePage : false,
        render : function(data){
            var tb = $('#dataGridTableJson tbody');
            $(tb).empty();
            if(data && data.dataList && data.dataList.length > 0){
                $.each(data.dataList,function(i,row){

                    for (var s in row) {
                        if(row[s]==null||row[s]==""||row[s]==undefined){
                            row[s]="";
                        }
                    };
                    if(row.birth!=""&&row.birth!=undefined){
                        /*将时间戳转化为日期*/
                        var time = new Date(row.birth);
                        row.birth = time.getFullYear() + "-" + (time.getMonth() + 1) + "-" + time.getDate();
                    }else{
                        row.birth="";
                    }
                    if(row.login!=""&&row.login!=undefined){
                        /*将时间戳转化为日期*/
                        var time = new Date(row.login);
                        row.login = time.getFullYear() + "-" + (time.getMonth() + 1) + "-" + time.getDate();
                    }else{
                        row.login="";
                    }


                    var tr = $('<tr>');
                    $(tr).append('<td>'+row.nickname+'</td>');
                    $(tr).append('<td>'+row.tel+'</td>');
                    $(tr).append('<td>'+row.birth+'</td>');
                    $(tr).append('<td>'+row.sex+'</td>');
                    $(tr).append('<td>'+row.live+'</td>');
                    $(tr).append('<td>'+row.login+'</td>');
                    $(tr).append('<td>'+row.score+'</td>');
                    // $(tr).append("<td><a href='/JDWebShop/part/alter?pid="+row.id+"'>修改</a></td>");
                    $(tr).append("<td><a href='/JDWebShop/part/####?###="+row.id+"'>删除</a></td>");
                    //$(tr).append('<td>'+row.statusName+'</td>');
                    //$(tr).append('<td>'+row.update_time+'</td>');
                    $(tb).append(tr);
                });
            }
        },
        params : function(){
            return {
            };
        }
    });

});

