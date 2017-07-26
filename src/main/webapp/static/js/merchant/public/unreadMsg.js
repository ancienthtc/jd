var unreadMsg = new Object();

/*点击右上角头像注销登录,点击个人中心进入个人中心*/
unreadMsg.logOut = function() {
    
    var timer;
    $('.topNav').on('mouseenter','.logout',function() {
        clearTimeout(timer);
            timer = setTimeout(function () {
                $('.logoutBox').slideDown(300);
            }, 500);
    })

    $('.topNav').on('mouseleave','.logout',function() {
        clearTimeout(timer);
            timer = setTimeout(function () {
                $('.logoutBox').slideUp(300);
            }, 500);
    })

	
	/**
	 * 点击进入个人中心
	 */
	$(".topNav").on('click','.personalCenter',function(){
		$('.contentBox').load('../../../templates/merchant/personal/personalFiles.html');
	})
	
	/**
	 * 点击进入系统消息
	 */
	$(".topNav").on('click','#topMsg',function(){
		$('.contentBox').load('../../../templates/merchant/personal/message.html');
	})
}

/**
 * 平台退出登录
 */
unreadMsg.exit = function() {
  $(".topNav").on("click", ".loginout", function() {
    $.ajax({
      type: "post",
      dataType: "json",
      url: ctx + "/platform/exit",
      success: function(data) {
        if (data.code == 200) {
          location.href = ctx+"/merchant/login";
        }
      },
      error: function() {
        imessenger.error("请求失败");
      }
    })
  })
	
	
}

unreadMsg.init = function() {
  $.ajax({
    data: { "state": 2 },
    type: "get",
    dataType: "html",
    url: ctx + "/message/getUnReadNum",
    success: function(data) {
      $(".topNav").html(data);
      

    },
    error: function() {
      imessenger.error("请求失败");
    }
  })
}



$(function() {
  unreadMsg.init();
  unreadMsg.exit();
  unreadMsg.logOut();
})
