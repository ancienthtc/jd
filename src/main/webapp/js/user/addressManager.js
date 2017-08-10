var addressManager = new Object();

addressManager.event = function(){
    /*添加收货地址*/
    $("#addAddress").click(function(){
        var datas = new Object();
        datas.detail = $("#detail").val();
        datas.zip = $("#zip").val();
        datas.recipient = $("#recipient").val();
        datas.tel = $("#tel").val();
        datas.phone = $("#phone").val();
        //地区码
        var areaID = getAreaID();
        //地区名
        datas.area = getAreaNamebyID(areaID);
        if($("#ismain").is(":checked")==true){
            datas.ismain = 1;
        }else{
            datas.ismain = 0;
        }
        /*简单的验证*/
        if(verify(datas.detail)||verify(datas.recipient)||(verify(datas.tel)&&verify(datas.phone))||verify(datas.area)){
            imessenger.error("参数未填写")
            return null;
        }
        $.ajax({
            url:"../address/saveAddress",
            data:datas,
            type:"post",
            dataType:"json",
            success:function(data){
                if(data.msg=='success'){
                    imessenger.success("添加收货地址成功")
                    setTimeout("location.reload()",500);
                }else{
                    imessenger.error(data.msg);
                }
            },
            error:function(){
                imessenger.error("请求失败");
            }
        })
    })

    $('[data-btn="setDefault"]').click(function(){
        var id = $(this).parent().prev().text();
        $.ajax({
            url:"../address/setDefault",
            data:{"id":id},
            type:"get",
            dataType:"json",
            success:function(data){
                if(data.msg=='success'){
                    imessenger.success("设置默认成功")
                    setTimeout("location.reload()",500);
                }else{
                    imessenger.error(data.msg);
                }
            },
            error:function(){
                imessenger.error("请求失败");
            }

        })
    })




}
function verify(obj){
    if(obj==null||obj==""){
        return true;
    }else{
        return false;
    }
}

$(function(){
    addressManager.event();
})