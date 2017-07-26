var otherDetail = new Object();
otherDetail.errorMsg = {};
otherDetail.id="";
otherDetail.count = $('#imgBox').children('.photos').length;
//轮播图的添加
$('#imgBox').on('change','input[type="file"]',function(e) {
	//判断图片的类型是否正确
	var img = $(this).val();
    otherDetail.id=$(this).attr('id');
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
                url : ctx+'/product/uploadListImg?uname=photo', // 用于文件上传的服务器端请求地址
                secureuri : false, // 一般设置为false(是否锁定这个接口)
                async : true,//是否是异步
                fileElementId : otherDetail.id, // 文件上传控件的id属性 <input
                // $("form").serialize(),表单序列化。指把所有元素的ID，NAME 等全部发过去
                type:'POST',
                dataType : 'json',// 返回值类型 一般设置为json
                complete : function() {// 只要完成即执行，最后执行
                },
                success : function(data, status) {// 服务器成功响应处理函数
                    var key=data.data.key;
                    var id="#"+otherDetail.id+"2";
                    $(id).val(key);

                },
                error : function(data, status, e) {// 服务器响应失败处理函数
                    console.log("error");
                }
            })
	    }
	    reader.readAsDataURL(file);

        //显示按钮
        $this.css({'cursor':'default'}).nextAll('.btnBox').show();
        $this.parents('.photos').addClass('canSort');
        //清空错误提示
        $('#imgBox .tips').text('');
        $(this).prevAll('.mask').show();
        //判断个数
        //var count = $('#imgBox').children('.photos').length;
        if(otherDetail.count <= 5) {
            $('#imgBox').append('<div class="photos"><div class="img" style="background-image: none"></div><div class="mask"></div><i class="iconfont icon-add"></i><input type="file" name="listImg1" id="listImg'+(otherDetail.count+1)+'"><div class="btnBox"><i class="iconfont icon-del"></i><i class="iconfont icon-sort"></i></div></div><input type="hidden" class="listImg2" id="listImg'+(otherDetail.count+1)+'2">');
            otherDetail.count=otherDetail.count+1;
        }
	}
})

//封面图的添加
$('#contentBoxId').on('change','input[type="file"][name="ossImg1"]',function(e) {
	//判断图片的类型是否正确
	var img = $(this).val();
	var extStart = img.lastIndexOf(".");
	var ext = img.substring(extStart,img.length).toUpperCase();
	if(ext!=".BMP"&&ext!=".PNG"&&ext!=".GIF"&&ext!=".JPG"&&ext!=".JPEG") {
		imessenger.error('图片限于bmp,png,gif,jpeg,jpg格式');
		return false;
	} else {
		var $this = $(this);
		var file = e.target.files[0];
		var reader = new FileReader();  
		reader.onload = function(e){
			$this.prevAll('.img').css('backgroundImage',"url("+e.target.result+")");
            $.ajaxFileUpload({
                url : ctx+'/product/uploadOssImg?uname=photo', // 用于文件上传的服务器端请求地址
                secureuri : false, // 一般设置为false(是否锁定这个接口)
                async : false,//是否是异步
                fileElementId : $("input#ossImg1").attr("id"), // 文件上传控件的id属性 <input
                // $("form").serialize(),表单序列化。指把所有元素的ID，NAME 等全部发过去
                type:'POST',
                dataType : 'json',// 返回值类型 一般设置为json
                complete : function() {// 只要完成即执行，最后执行
                },
                success : function(data, status) {// 服务器成功响应处理函数
                    var key=data.data.key;
                    $("#ossImg").val(key);
                },
                error : function(data, status, e) {// 服务器响应失败处理函数
                    console.log("error");
                }
            })
	    }
	    reader.readAsDataURL(file);
	}
})

//封面大图的添加
$('#contentBoxId').on('change','input[type="file"][name="bigImg1"]',function(e) {
	//判断图片的类型是否正确
	var img = $(this).val();
	var extStart = img.lastIndexOf(".");
	var ext = img.substring(extStart,img.length).toUpperCase();
	if(ext!=".BMP"&&ext!=".PNG"&&ext!=".GIF"&&ext!=".JPG"&&ext!=".JPEG") {
		imessenger.error('图片限于bmp,png,gif,jpeg,jpg格式');
		return false;
	} else {
		var $this = $(this);
		var file = e.target.files[0];
		var reader = new FileReader();  
		reader.onload = function(e){
			$this.prevAll('.img').css('backgroundImage',"url("+e.target.result+")");
            $.ajaxFileUpload({
                url : ctx+'/product/uploadBigImg?uname=photo', // 用于文件上传的服务器端请求地址
                secureuri : false, // 一般设置为false(是否锁定这个接口)
                async : false,//是否是异步
                fileElementId : $("input#bigImg1").attr("id"), // 文件上传控件的id属性 <input
                // $("form").serialize(),表单序列化。指把所有元素的ID，NAME 等全部发过去
                type:'POST',
                dataType : 'json',// 返回值类型 一般设置为json
                complete : function() {// 只要完成即执行，最后执行
                },
                success : function(data, status) {// 服务器成功响应处理函数
                    var key=data.data.key;
                    $("#bigImg").val(key);
                },
                error : function(data, status, e) {// 服务器响应失败处理函数
                    console.log("error");
                }
            })
	    }
	    reader.readAsDataURL(file);
	}
})




//保存产品时候的验证和提交
$('[data-btn="addNewProduct"]').on('click',function() {	
	var datas = iform.parseForm('productDetailForm');
	//检查名称合法性
	var _a = c.checkMyDes('#productDetailForm',otherDetail,datas.name,"name",1,10);
	//检测单价的合法性
	var _b = c.checkMyPositive('#productDetailForm',otherDetail,datas.price,"price",0,Infinity);
	//检查产品描述的合法性
	var _c = true;
	//检查产品简介的合法性
	//var _d = c.checkMyDes('#productDetailForm',otherDetail,datas.brief,"brief");
	//检查最晚取消时间的合法性
	//var _e = c.checkMyDes('#productDetailForm',otherDetail,datas.lastCancelStr,"lastCancelStr");
	//检查发货时间范围的合法性
	var _f = true;
	//检查配送费的合法性
	//var _g = c.checkMyPositive('#productDetailForm',otherDetail,datas.logisticsPrice,"logisticsPrice",0,Infinity);
	//检查计量单位的合法性
	var _h = c.checkMyDes('#productDetailForm',otherDetail,datas.metering,"metering",1,10);
	//检查封面图的合法性
	//var _i = c.checkMyImg('#productDetailForm',otherDetail,datas.ossImg1,"ossImg1");
	//检查封面大图的合法性
	//var _j = c.checkMyImg('#productDetailForm',otherDetail,datas.bigImg1,"bigImg1");
	//检查轮播图的合法性
	//var _k = otherDetail.chekImg('#productDetailForm',otherDetail,datas.listImg1,"listImg1");

    //检查产品分类的合法性
    var _l = productDetail.checkClass();
	//全部通过验证
    var key="";
    $(".listImg2").each(function(power){
        var id = $(this).attr("id");

        if(key==''){
            key=$("#"+id).val();
        }else{
            key=key+","+$("#"+id).val();
        }
    });
    datas.listImg=key;
    var description=$("#editArea").html();
    var brief=$("#briefArea").val();
    datas.description=description;
    datas.brief = brief;
	if(_a&&_b&&_c&&_f&&_h&&_l) {
		//执行下一步
        $.ajax({
            url: ctx+"/subsidiary/save",
            type: 'post',
            dataType: 'json',
            data:datas,
            success: function (dbdata) {
                if (dbdata.code == 200) {
                    $('.contentBox').load("../../../templates/merchant/product/other.html");
                    imessenger.success("添加成功");
                    page.paging();
                } else {
                    imessenger.error("添加失败");
                }
            }
        })
	}
})



//轮播图的删除
$('#imgBox').on('click','.icon-del',function() {
	var $this = $(this);
	$.confirm({
		title: '提示',
		content: '确定要删除该图吗？',
		confirm: function() {
			if( ($('#imgBox').children('.canSort').length == 6 )){
                var id=$this.parents('.photos').find("input").attr('id');
                var id="#"+id+"2";
                $(id).remove();
				$this.parents('.photos').remove();
				$('#imgBox').append('<div class="photos"><div class="img" style="background-image: none"></div><div class="mask"></div><i class="iconfont icon-add"></i><input type="file" /><div class="btnBox"><i class="iconfont icon-del"></i><i class="iconfont icon-sort"></i></div></div><input type="hidden" class="listImg2" id="listImg62">');
			} else {
                var id=$this.parents('.photos').find("input").attr('id');
                var id="#"+id+"2";
                $(id).remove();
				$this.parents('.photos').remove();
                productDetail.count=productDetail.count-1;
			}
		},
	});
})

//轮播图的排序
$("#imgBox").sortable({
        //拖动的把手
        handle: '.icon-sort',
        //拖动的范围(容器)
        containment: "parent",
        //取消label排序
        items:".photos.canSort",
        //修复拖到底的bug
        tolerance:'pointer',
        //排序位置更新时调用该方法(发送ajax请求)
        update:function(){
        	console.log('更新完成');
        }
    });


//轮播图的错误提示
otherDetail.chekImg = function() {
	var flag = false;
	$('#imgBox.photoGroup input[type="file"]').each(function() {
		if($(this).val() != ""){
			flag = true;
		} else {
			otherDetail.errorMsg.listImg = "请上传轮播图片";
		}
	})


	if(!flag) {
		$('#imgBox .tips').text(otherDetail.errorMsg.listImg);
	} else {
		$('#imgBox .tips').text('');

	}
	return flag;
}

/**
 * 类别下拉框change事件
 */
$("#parentType").change(function(){
    var parentId=$("#parentType").val();
    $.ajax({
        dataType: "json",
        type: 'get',
        url: ctx + '/pigProductType/getSecondType',
        async: false,
        data: {"parentId": parentId},
        success: function (data) {
            if (data.code == 200) {
                var html = "";
                for (var i = 0; i < data.data.length; i++) {
                    html += "<option value=" + data.data[i].id + ">" + data.data[i].name + "</option>";
                    $("#childType").html(html);
                }
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log('请求发送时候出错');
        }
    })
});



/*
 *   检查产品分类合法性
 */
productDetail.checkClass = function() {
    var flag = false;
    var data = $('#parentType :selected').text();
    if(data == '请选择分类') {
         $('#parentType').nextAll('.tips').text('请选择分类');
    } else {
        flag = true;
    }
    return flag;
}