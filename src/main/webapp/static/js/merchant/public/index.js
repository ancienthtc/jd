var indexObj = new Object();

/*页面加载函数的封装*/
indexObj.pageLoad = function(id, pageUrl) {
  $(id).on('click', function() {
    $('.contentBox').load('../../../templates/merchant/' + pageUrl, function() {
      $('.contentBox').hide().fadeIn(300);
  	
	
    });
  })
}

/*个人中心*/
indexObj.pageLoad('#personalData', 'personal/personalFiles.html');
indexObj.pageLoad('#safe', 'personal/safe.html');
$("#safe").on('click', '[data-btn="getApprove"]', function() {
  $('.contentBox').load("/personal/merchantApprove.html");
});
$("#merchantApproveDiv").on('click', '[data-btn="getApproveBtn"]', function() {
  $('.contentBox').load("/personal/merchantApproveDetail.html");
});
indexObj.pageLoad('#message', 'personal/message.html');

/*产品管理*/
indexObj.pageLoad('#pig', 'product/pig.html');
indexObj.pageLoad('#product', 'product/product.html');
$(document).on('click', '#productDiv [data-btn="add"]', function() {
  $('.contentBox').load("/product/getProduct");
})

indexObj.pageLoad('#other', 'product/other.html');
$(document).on('click', '#othertDiv [data-btn="add"]', function() {
  $('.contentBox').load("../../../templates/merchant/product/otherDetail.html");
})
$(document).on('click', '#othertDiv .icon-edit', function() {
  $('.contentBox').load("../../../templates/merchant/product/otherDetail.html");
})

/*运营管理*/
indexObj.pageLoad('#order', 'operation/order.html');
indexObj.pageLoad('#evaluate', 'operation/evaluate.html');
indexObj.pageLoad('#redpacket', 'operation/redpacket.html');
indexObj.pageLoad('#discount', 'operation/discount.html');

/*资金管理*/
indexObj.pageLoad('#fund', 'fund/fund.html');
indexObj.pageLoad('#card', 'fund/card.html');


var agricultural = new Object();
agricultural.checkLogin = function() {alert(1);
  var agriculturalTitle = $('.contentBox'); //the element I want to monitor
  agriculturalTitle.bind('DOMNodeInserted', function(e) {
    //      var htmlText = $(e.target).html();
    var id = $("#agriculturalLogin").val();
    alert(id);
    if (id != undefined && id != "") {
      window.parent.location.href = ctx + "/merchant/login";
    }
    var platformError = $("#platformError").val();
    if (platformError != undefined && platformError != "") {

      //window.location.reload();
      imessenger.error(platformError);

    }
  });
}

indexObj.business = function(){
	/**
	 * 商家认证
	 */
	$(".contentBox").on("click",'[data-btn="getApprove"]',function(){
		$.ajax({
			type:"get",
			dataType:"html",
			url:ctx+"/businessApprove/businessApprovePage",
			success:function(data){
				$('.contentBox').html(data);
			},
			error:function(){
				imessenger.error("请求失败");
			}
		})
	})


}



$(function() {
	/*indexObj.business();*/
  //左侧二级导航下拉效果
  indexObj.leftNav();
  indexObj.secondNav();
 /* agricultural.checkLogin();*/

  //左侧导航栏高度
  indexObj.changeHeight();

  //添加slider点击效果
  indexObj.sliderEffect();

  //注销登录
  /*indexObj.logOut();*/
  
  /**
   *  指向
   */
  var indexPoin = $("#indexPoin").val();

  if(indexPoin != undefined && indexPoin != ""){
	  $('.contentBox').load('../../../templates/' + indexPoin, function() {
	      $('.contentBox').hide().fadeIn(300);
	    });
  }
})




/*
 * 左侧二级导航下拉效果
 */
indexObj.leftNav = function() {
  $(".default p").on('click', function() {
    if (!$(this).hasClass('on')) {
      $(this).addClass("on");
      $(this).next().slideDown();
      $(this).parent().siblings().find(".secondNav").slideUp();
      $(this).parent().siblings().find("p").removeClass("on");
    } else {
      $(this).removeClass("on");
      $(this).next().slideUp();
      $(this).parent().siblings().find(".secondNav").slideUp();
      $(this).parent().siblings().find("p").removeClass("on");
    }
  })
}

indexObj.secondNav = function() {
  $('.secondNav li').on('click', function() {
    $('.secondNav li').removeClass('on');
    $(this).addClass('on');
  })
}

/*
 * 左侧导航栏高度
 */
indexObj.changeHeight = function() {
  $('.leftBox,.rightBox').css({
    "min-height": $(window).height()
  });
  $(window).resize(function() {
    $('leftBox,.rightBox').css({
      "min-height": $(window).height()
    });
  });
  $('.rightBox .contentBox').css({
    "min-height": $(window).height() - 92
  });
  $(window).resize(function() {
    $('.rightBox .contentBox').css({
      "min-height": $(window).height() - 92
    });
  });
}


//input选中时候清空错误信息
$(document).on('focus', 'input', function() {
    $(this).nextAll('.tips').text('');
  })
  //textarea选中时候清空错误消息
$(document).on('focus', 'textarea', function() {
  $(this).nextAll('.tips').text('');
})


var agricultural = new Object();
agricultural.checkLogin = function() {

  var title = $('.contentBox'); //the element I want to monitor
  title.bind('DOMNodeInserted', function(e) {
    //      var htmlText = $(e.target).html();
    var id = $("#agriculturalLogin").val();

    if (id != undefined && id != "") {
      window.parent.location.href = ctx + "/merchant/login";
    }
    var platformError = $("#platformError").val();
    if (platformError != undefined && platformError != "") {

      //window.location.reload();
      imessenger.error(platformError);

    }
  });

}



/*左侧导航栏的特效*/
indexObj.sliderEffect = function() {
  // 定义公共slider
  var sidebar = $('.slideBarBox');
  var allLinks = $('.secondNav li');
  var menuLinks = $('li.default p');

  /* 点击效果 */
  var rippleEffect = function(element, cl) {
    // 为包裹的元素添加样式
    element.css({
      'overflow': 'hidden',
      'position': 'relative'
    });

    // 点击事件
    element.on('click', function(e) {
      var elem = $(this),
        ripple, degree, x, y;

      //效果span如果不存在的话就添加一个
      if (elem.children('.' + cl).length === 0) {
        elem.prepend('<span class="' + cl + '"></span>');
      } else { // 移除所有animate
        sidebar.find('.' + cl).removeClass('animate');
      }

      //获取添加的效果span
      var ripple = elem.children('.' + cl);

      // 判断是否有坐标，如果没有就设置
      if (!ripple.height() && !ripple.width()) {
        degree = Math.max(elem.outerWidth(), elem.outerHeight());
        ripple.css({
          height: degree,
          width: degree
        });
      }

      // 设置坐标
      x = e.pageX - elem.offset().left - ripple.width() / 2;
      y = e.pageY - elem.offset().top - ripple.height() / 2;

      ripple.css({
        top: y + 'px',
        left: x + 'px'
      }).addClass('animate');
    });
  };
  rippleEffect(menuLinks, 'ripple');
  rippleEffect(allLinks, 'ripple');
}


/*点击右上角头像注销登录*/
indexObj.logOut = function() {
  /*$('.logout').hover(function() {
    $(this).find('.logoutBox').stop(true).slideDown(300);
  }, function() {
    $(this).find('.logoutBox').stop(true).slideUp(300);
  })*/
	var timer;
	$('.logout').on({
		"mouseenter": function () {
			clearTimeout(timer);
			timer = setTimeout(function () {
				$('.logoutBox').slideDown(300);
			}, 500);
		},
		"mouseleave": function () {
			clearTimeout(timer);
			$('.logoutBox').slideUp(300);
		}
	});
}


/*屏蔽单输入框按回车默认提交表单事件*/
$('.contentBox').on('submit', 'form.search', function(e) {
  e.preventDefault();
})

/*打开模态框清空表单和错误信息*/
// $('body').on('hidden.bs.modal','.modal',function() {
//     var $this = $(this).find('form');
//     $(this).find('input[type="hidden"]').val('');
// })
