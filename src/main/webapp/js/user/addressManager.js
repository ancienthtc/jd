var addressManager = new Object();

addressManager.event = function () {
    /*添加收货地址*/
    $("#addAddress").click(function () {
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
        if ($("#ismain").is(":checked") == true) {
            datas.ismain = 1;
        } else {
            datas.ismain = 0;
        }
        /*简单的验证*/
        if (verify(datas.detail) || verify(datas.recipient) || (verify(datas.tel) && verify(datas.phone)) || verify(datas.area)) {
            imessenger.error("参数未填写")
            return null;
        }
        $.ajax({
            url: "../address/saveAddress",
            data: datas,
            type: "post",
            dataType: "json",
            success: function (data) {
                if (data.msg == 'success') {
                    imessenger.success("添加收货地址成功")
                    $.ajax({
                        url: "../address/toAddressManager",
                        type: "get",
                        dataType: "html",
                        success: function (data) {
                            $(".all_right").html(data);
                        },
                        error: function (data) {
                            alert("请求失败");
                        }
                    })
                } else {
                    imessenger.error(data.msg);
                }
            },
            error: function () {
                imessenger.error("请求失败");
            }
        })
    })

    /*设置默认地址*/
    $('[data-btn="setDefault"]').click(function () {
        var id = $(this).parent().prev().text();
        $.ajax({
            url: "../address/setDefault",
            data: {"id": id},
            type: "get",
            dataType: "json",
            success: function (data) {
                if (data.msg == 'success') {
                    imessenger.success("设置默认成功");
                    $.ajax({
                        url: "../address/toAddressManager",
                        type: "get",
                        dataType: "html",
                        success: function (data) {
                            $(".all_right").html(data);
                        },
                        error: function (data) {
                            alert("请求失败");
                        }
                    })
                } else {
                    imessenger.error(data.msg);
                }
            },
            error: function () {
                imessenger.error("请求失败");
            }

        })
    })

    /*删除地址*/
    $('.delete').on("click", function () {
        var id = $(this).parent().parent().parent().prev().text();
        $.confirm({
            title: '提示',
            content: '确定要删除该地址吗？',
            confirm: function () {
                $.ajax({
                    url: "../address/deleteAddress",
                    data: {"id": id},
                    type: "get",
                    dataType: "json",
                    success: function (data) {
                        if (data.msg == 'success') {
                            imessenger.success("地址删除成功")
                            $.ajax({
                                url: "../address/toAddressManager",
                                type: "get",
                                dataType: "html",
                                success: function (data) {
                                    $(".all_right").html(data);
                                },
                                error: function (data) {
                                    alert("请求失败");
                                }
                            })
                        } else {
                            imessenger.error(data.msg);
                        }
                    },
                    error: function () {
                        imessenger.error("请求失败");
                    }

                })


            },
        });

    })


    /*点击编辑出现模态框*/
    $('.edit').on("click", function () {
        /* $("#modalDialog").removeClass("modalDialog").addClass("modalDialogshow");
         $("#modal-overlay").removeClass("modal-overlay").addClass("modal-overlayshow");*/
        var id = $(this).parent().parent().parent().prev().text();
        $.ajax({
            url: "../address/findById",
            data: {"id": id},
            type: "get",
            dataType: "json",
            success: function (data) {
                console.log(data);
                if (data.msg == 'error') {
                    imessenger.error("id为空或地址信息不存在");
                } else {
                    $('#modal-overlay input[name="id"]').val(data.msg.id);
                    $('#modal-overlay input[name="recipient"]').val(data.msg.recipient);
                    $('#modal-overlay input[name="tel"]').val(data.msg.tel);
                    $('#modal-overlay input[name="phone"]').val(data.msg.phone);
                    $('#modal-overlay input[name="area"]').val(data.msg.area);
                    $('#modal-overlay input[name="zip"]').val(data.msg.zip);
                    showModal("modal-overlay");
                }
            },
            error: function () {
                imessenger.error("请求失败");
            }

        })
    })

    /*点击确认修改地址信息*/
    $("#modalSure").on("click", function () {
        var datas = new Object();
        datas.id = $('#modal-overlay input[name="id"]').val();
        datas.recipient = $('#modal-overlay input[name="recipient"]').val();
        datas.tel = $('#modal-overlay input[name="tel"]').val();
        datas.phone = $('#modal-overlay input[name="phone"]').val();
        datas.area = $('#modal-overlay input[name="area"]').val();
        datas.zip = $('#modal-overlay input[name="zip"]').val();
        $.ajax({
            url: "../address/updateAddr",
            data: datas,
            type: "post",
            dataType: "json",
            success: function (data) {
                console.log(data);
                if (data.msg == 'success') {
                    imessenger.success("地址修改成功");
                    hideModal("modal-overlay");
                    $.ajax({
                        url: "../address/toAddressManager",
                        type: "get",
                        dataType: "html",
                        success: function (data) {
                            $(".all_right").html(data);
                        },
                        error: function (data) {
                            alert("请求失败");
                        }
                    })
                } else {
                    imessenger.error(data.msg);
                }
            },
            error: function () {
                imessenger.error("请求失败");
            }
        })
    });

}

/*验证空*/
function verify(obj) {
    if (obj == null || obj == "") {
        return true;
    } else {
        return false;
    }
}

$(function () {
    addressManager.event();
})