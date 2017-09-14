var shopCenter = new Object();

shopCenter.event = function(){
    /**
     * 保存个人信息
     */
    $('[data-btn="savePersonalInfo"]').click(function(){
        var datas = new Object();
        var nickname = $('input[name="name"]').val();
        var birth = $('input[name="member.birth"]').val();
        var sex = $('input[name="sex"]:checked').val();
        var live;
        if($("#liveDiv").css('display')=="none"){
            live=$("#liveInput").val();
        }else{
            //地区码
            var areaID = getAreaID();
            //地区名
            live = getAreaNamebyID(areaID);
        }
        var tellogin = $('input[name="istel"]:checked').val();
        if(tellogin==undefined){
            tellogin=0;
        }else{
            tellogin=1;
        }
        datas.nickname = nickname;
        datas.birth = birth;
        datas.sex = sex;
        datas.live = live;
        datas.tellogin = tellogin;
        $.ajax({
            url:"../user/updatePersonalInfo",
            data:datas,
            type:"post",
            dataType:"json",
            success:function(data){
                if(data.msg=='success'){
                    imessenger.success("修改成功")
                   /* setTimeout(" location.reload()",500);*/
                    setTimeout('$(".all_right").html("");',500);



                }else{
                    imessenger.error(data.msg);
                }
            },
            error:function(data){
                imessenger.error("请求失败");
            }
        })

    })

    /**
     * 跳转至收货地址管理页面
     */
    $("#recieverAddress").click(function(){
        $.ajax({
            url:"../address/toAddressManager",
            type:"get",
            dataType:"html",
            success:function(data){
                $(".all_right").html(data);
            },
            error:function(data){
                alert("请求失败");
            }
        })
    })

    /**
     * 跳转至评价管理页面
     */
    $("#commentManager").click(function(){
        $.ajax({
            url:"../comment/toCommentList",
            type:"get",
            dataType:"html",
            success:function(data){
                console.log(data);
                $(".all_right").html(data);
            },
            error:function(data){
                alert("请求失败");
            }
        })
    })

    /**
     * 跳转至历史记录管理
     */
    $("#history").click(function () {
        $.ajax({
            url:"../history/toHistoryPage",
            type:"get",
            dataType:"html",
            success:function(data){
                $(".all_right").html(data);
            },
            error:function(data){
                alert("请求失败");
            }
        })
    })

    /**
     * 跳转至待付款
     */
    $("#nopay").click(function () {
       $.ajax({
           url:"../order/toNoPay",
           type:"get",
           dataType:"html",
           success:function(data){
               //console.log(data);
               $(".all_right").html(data);
           },
           error:function(data){
               alert("请求失败");
           }
       })
    });

    /**
     * 跳转至待发货
     */
    $("#nosend").click(function () {
        $.ajax({
            url:"../order/toNoSend",
            type:"get",
            dataType:"html",
            success:function(data){
                //console.log(data);
                $(".all_right").html(data);
            },
            error:function(data){
                alert("请求失败");
            }
        })
    });

    /**
     * 跳转至待收货
     */
    $("#noaccept").click(function () {
        $.ajax({
            url:"../order/toNoAccept",
            type:"get",
            dataType:"html",
            success:function(data){
                //console.log(data);
                $(".all_right").html(data);
            },
            error:function(data){
                alert("请求失败");
            }
        })
    });

    /**
     * 跳转至待评价
     */
    $("#nocomment").click(function () {
        $.ajax({
            url:"../order/toNoComment",
            type:"get",
            dataType:"html",
            success:function(data){
                //console.log(data);
                $(".all_right").html(data);
            },
            error:function(data){
                alert("请求失败");
            }
        })
    });

    $("#outtime").click(function () {
        $.ajax({
            url:"../order/toOutTime",
            type:"get",
            dataType:"html",
            success:function(data){
                //console.log(data);
                $(".all_right").html(data);
            },
            error:function(data){
                alert("请求失败");
            }
        })
    });


}

$(function(){
    shopCenter.event();
})