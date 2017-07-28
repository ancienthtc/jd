var goodDetail = new Object();

goodDetail.event = function(){
    /*返回按钮*/
    $('[data-btn="backProduct"]').on('click', function(){
        $.ajax({
            url:"../goods/toGoodsList2",
            type:"get",
            dataType:"html",
            success:function(data){
                $("#contentBoxId").html(data);
            },
            error:function(){
                alert("页面出错");
            }

        });
        });

    //轮播图的添加
    $('#imgBox').on('change','input[type="file"]',function(e) {
        //判断图片的类型是否正确
        var img = $(this).val();
        goodDetail.id=$(this).attr('id');
        var extStart = img.lastIndexOf(".");
        var ext = img.substring(extStart,img.length).toUpperCase();
        if(ext!=".BMP"&&ext!=".PNG"&&ext!=".GIF"&&ext!=".JPG"&&ext!=".JPEG") {
            imessenger.error('图片限于bmp,png,gif,jpeg,jpg格式');
            return false;
        } else {
            //显示图片
            var $this = $(this);
            var file = e.target.files[0];
            var reader = new FileReader();
            reader.onload = function(e){
                $this.prevAll('.img').css('backgroundImage',"url("+e.target.result+")");
                $.ajaxFileUpload({
                    url : '../goods/goodsUpload/1', // 用于文件上传的服务器端请求地址
                    secureuri : false, // 一般设置为false(是否锁定这个接口)
                    async : true,//是否是异步
                    fileElementId : goodDetail.id, // 文件上传控件的id属性 <input
                    // $("form").serialize(),表单序列化。指把所有元素的ID，NAME 等全部发过去
                    type:'POST',
                    dataType : 'json',// 返回值类型 一般设置为json
                    complete : function() {// 只要完成即执行，最后执行
                    },
                    success : function(data, status) {// 服务器成功响应处理函数
                        alert(1);
                        var key=data.data.key;
                        var id="#"+goodDetail.id+"2";
                        $(id).val(key);
                    },
                    error : function(data, status, e) {// 服务器响应失败处理函数
                        alert(2);
                        console.log("error");
                    }
                })
            }
            reader.readAsDataURL(file);

            //显示按钮
            $(this).css({'cursor':'default'}).nextAll('.btnBox').show();
            $(this).parents('.photos').addClass('canSort');
            // $(this).prop('disabled',true);
            $(this).prevAll('.mask').show();
            //清空错误提示
            $('#imgBox .tips').text('');
            //判断个数
            //var count = $('#imgBox').children('.photos').length;
            if(goodDetail.count <= 5) {
                $('#imgBox').append('<div class="photos"><div class="img" style="background-image: none"></div><div class="mask"></div><i class="iconfont icon-add"></i><input type="file" name="listImg1" id="listImg'+(goodDetail.count+1)+'"><div class="btnBox"><i class="iconfont icon-del"></i><i class="iconfont icon-sort"></i></div></div><input type="hidden" class="listImg2" id="listImg'+(goodDetail.count+1)+'2">');
                goodDetail.count=goodDetail.count+1;
            }
        }
    })

}

$(function(){
    goodDetail.event();
})