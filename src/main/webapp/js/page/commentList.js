var curWwwPath = window.document.location.href;
var pathName = window.document.location.pathname;
var pos = curWwwPath.indexOf(pathName);
var localhostPath = curWwwPath.substring(0, pos);
var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
var basePath=localhostPath+projectName+"/";

$(function () {
    $('#page3').bPage({
        url: basePath+'comment/commentList',
        asyncLoad: true,
        asyncType: 'GET',
        serverSidePage: false,
        render: function (data) {
            console.log(data);
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
                    $(tr).append('<td>' + row.comment + '</td>');
                    $(tr).append('<td>' + row.name + '</td>');
                    $(tr).append('<td>' + row.time + '</td>');
                    $(tr).append('<span  style="display:none">' + row.commentGoods + '</span>');
                    $(tb).append(tr);
                });
            }
        },
        params: function () {
            return {
                userName: 'zhangsan',
                age: 42
            };
        }
    });
});