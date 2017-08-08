var addressManager = new Object();

addressManager.event = function(){
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
        console.log(datas);
       /* $.ajax({
            url:
            data:
            type:
            dataType:
            success:function(){

            },
            error:function(){

            }
        })*/
    })


}

$(function(){
    addressManager.event();
})