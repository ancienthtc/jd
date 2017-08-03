var goodDetail = new Object();
goodDetail.id="";
goodDetail.count = $('#imgBox').children('.photos').length;
goodDetail.imgidspan = "";
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
        var datas = iform.parseForm('goodDetailForm');
        var id = datas.id/*$(this).parents("form").children("span").eq(0).text()*/;
        var imgid ;
        //判断图片的类型是否正确
        var img = $(this).val();
        goodDetail.id=$(this).attr('id');
        goodDetail.imgidspan = $(this).prevAll("span")[0];
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
                    url : '../goods/goodsUpload/'+id, // 用于文件上传的服务器端请求地址
                    secureuri : false, // 一般设置为false(是否锁定这个接口)
                    async : true,//是否是异步
                    fileElementId : goodDetail.id, // 文件上传控件的id属性 <input
                    // $("form").serialize(),表单序列化。指把所有元素的ID，NAME 等全部发过去
                    type:'POST',
                    dataType : 'json',// 返回值类型 一般设置为json
                    complete : function() {// 只要完成即执行，最后执行

                    },
                    success : function(data, status) {// 服务器成功响应处理函数
                        //将返回后的图片id存入隐藏域,便于后期处理图片
                        imgid = data.id;
                        $(goodDetail.imgidspan).html(imgid);
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
            if(goodDetail.count <= 5) {
                $('#imgBox').append('<div class="photos"><span style="display: none"></span><div class="img" style="background-image: none"></div><div class="mask"></div><i class="iconfont icon-add"></i><input type="file" name="file" id="listImg'+(goodDetail.count+1)+'"><div class="btnBox"><i class="iconfont icon-del"></i></div></div><input type="hidden" class="listImg2" id="listImg'+(goodDetail.count+1)+'2">');
                goodDetail.count=goodDetail.count+1;
            }
        }
    })


    //轮播图的删除
    $('#imgBox').on('click','.icon-del',function() {
        var $this = $(this);
        var imgid = $(this).parent().prevAll("span").text();

        $.confirm({
            title: '提示',
            content: '确定要删除该图吗？',
            confirm: function() {

                $.ajax({
                    url:"../goods/deletepic",
                    data:{"imageid":imgid},
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
                    goodDetail.count=goodDetail.count-1;
                }


            },
        });
    })

    /*下拉选选中设置默认状态*/
    /*$("form").on("change",'[name="part"]',function(){
        var s = $(":selected").prop("selected",false);
        console.log(s);
    })*/

    /*保存修改*/
    $("form").on("click",'[data-btn="saveGood"]',function(){
        var datas = iform.parseForm('goodDetailForm');
        datas.partGoods = $('#goodDetailForm').find("option:selected").attr("name");
        datas.shelf = datas.shelf.replace(/-/g,"/");
        datas.shelf = new Date(datas.shelf);
        $.ajax({
            url:"../goods/update",
            data:datas,
            type:"post",
            dataType:"json",
            success:function(data){

                if(data.success=='true'){
                    imessenger.success("修改成功");
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
    goodDetail.event();
})