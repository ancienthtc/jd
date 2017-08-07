var shopCenter = new Object();

shopCenter.event = function(){
    $('[data-btn="savePersonalInfo"]').click(function(){
        var name = $('input[name="name"]').val();
        var birth = $('input[name="member.birth"]').val();
        var sex = $('input[name="sex"]:checked').val();
        //地区码
        var areaID = getAreaID();
        //地区名
        var addr = getAreaNamebyID(areaID) ;
        var forPhone = $('input[name="istel"]:checked').val();
        console.log(name+","+birth+","+sex+","+areaID+","+addr+","+forPhone);

    })
}

$(function(){
    shopCenter.event();
})