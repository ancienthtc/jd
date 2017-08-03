var goodAdd = new Object();
goodAdd.id="";
goodAdd.count = $('#imgBox').children('.photos').length;
goodAdd.imgidspan = "";


goodAdd.event = function(){
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


    /*商品图片添加*/
    $('#imgBox').on('change','input[type="file"]',function(e) {
        var imgid ;
        //判断图片的类型是否正确
        var img = $(this).val();
        goodAdd.id=$(this).attr('id');
        goodAdd.imgidspan = $(this).prevAll("span")[0];
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
                 url : '../goods/addImg', // 用于文件上传的服务器端请求地址
                 secureuri : false, // 一般设置为false(是否锁定这个接口)
                 async : true,//是否是异步
                 fileElementId : goodAdd.id, // 文件上传控件的id属性 <input
                 // $("form").serialize(),表单序列化。指把所有元素的ID，NAME 等全部发过去
                 type:'POST',
                 dataType : 'JSON',// 返回值类型 一般设置为json
                 complete : function() {// 只要完成即执行，最后执行

                 },
                 success : function(data) {// 服务器成功响应处理函数
                     /*data = $.parseJSON(jquery(data).text());*/
                     /*data = $.parseJSON(data.replace(/<.*?>/ig,""));*/
                     console.log(data);
                     //将返回后的图片名存入隐藏域,便于后期处理图片
                     $(goodAdd.imgidspan).html(data);
                 },
                 error : function(data, status, e) {// 服务器响应失败处理函数
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
            if(goodAdd.count <= 5) {
                $('#imgBox').append('<div class="photos"><span style="display: none"></span><div class="img" style="background-image: none"></div><div class="mask"></div><i class="iconfont icon-add"></i><input class="listImg2" type="file" name="file" id="listImg'+(goodAdd.count+1)+'"><div class="btnBox"><i class="iconfont icon-del"></i></div></div> <input type="hidden" class="listImg1" id="listImg'+(goodAdd.count+1)+'2">');
                goodAdd.count=goodAdd.count+1;
            }
        }
    })


    //轮播图的删除
    $('#imgBox').on('click','.icon-del',function() {
        var $this = $(this);
        var imgName = $(this).parent().prevAll("span").text();

        $.confirm({
            title: '提示',
            content: '确定要删除该图吗？',
            confirm: function() {

                $.ajax({
                    url:"../goods/deletePicForAdd",
                    data:{"imgName":imgName},
                    type:"get",
                    dataType:"json",
                    success:function(data){
                        if(data==true){
                            imessenger.success("图片删除成功");
                        }else{
                            imessenger.error("图片删除失败");
                        }
                    },
                    error:function(){
                        imessenger.error("请求失败");
                    }
                })
                if( ($('#imgBox').children('.canSort').length == 6 )){
                    var id=$this.parents('.photos').find("input").attr('id');
                    var id="#"+id;
                    $(id).remove();
                    $this.parents('.photos').remove();

                    $('#imgBox').append('<div class="photos"><span  style="display: none"></span><div class="img" style="background-image: none"></div><i class="iconfont icon-add"></i><input type="file" name="file" id="listImg2"/><div class="btnBox"><i class="iconfont icon-del"></i></div></div><input  type="hidden" class="listImg2" />');
                } else {
                    var id=$this.parents('.photos').find("input").attr('id');
                    var id="#"+id;
                    $(id).remove();
                    $this.parents('.photos').remove();
                    goodAdd.count=goodAdd.count-1;
                }


            },
        });
    })
    
    /*保存添加的商品信息*/
    $("form").on("click",'[data-btn="addNewGood"]',function(){
        var datas = iform.parseForm('goodAddForm');
        datas.partGoods = $('#goodAddForm').find("option:selected").attr("name");
        if(datas.partGoods==undefined){
            imessenger.error("请选择板块")
            return null;
        }
        datas.shelf = datas.shelf.replace(/-/g,"/");
        datas.shelf = new Date(datas.shelf);
        var imgName = "";
        $("#imgBox .photos").children("span").each(function(){
            if(imgName==""){
                imgName = $(this).text()
            }else{
                imgName = imgName+","+$(this).text();
            }
            /*try{
             if(node.files && node.files[0] ){
             file = node.files[0];
             }else if(node.files && node.files.item(0)) {
             file = node.files.item(0);
             }
             //Firefox 因安全性问题已无法直接通过input[file].value 获取完整的文件路径
             try{
             //Firefox7.0
             imgUrl =  file.getAsDataURL();
             //alert("//Firefox7.0"+imgRUL);
             }catch(e){
             //Firefox8.0以上
             imgUrl = window.URL.createObjectURL(file);
             //alert("//Firefox8.0以上"+imgRUL);
             }
             }catch(e){      //这里不知道怎么处理了，如果是遨游的话会报这个异常
             //支持html5的浏览器,比如高版本的firefox、chrome、ie10
             if (node.files && node.files[0]) {
             var reader = new FileReader();
             reader.onload = function (e) {
             console.log(e);
             imgUrl = e.target.result;
             };
             reader.readAsDataURL(node.files[0]);
             }
            }*/
        })

        datas.imgName = imgName;
            /*var id = $(this).attr("id");
            if(id!=undefined){
                var url = $("#"+id).val();
                if(imgUrl==""){
                    imgUrl = url;
                }else{
                    imgUrl = imgUrl+","+url;
                }
            }
        }*/

        $.ajax({
            url:"../goods/add",
            data:datas,
            type:"post",
            dataType:"json",
            success:function(data){

                if(data.success=='true'){
                    imessenger.success("添加商品成功");
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
                }else{
                    imessenger.error("修改失败");
                }
            },
            error:function () {
                alert("请求失败");
            }
        })

    })


    
}

$(function(){
    goodAdd.event();
})