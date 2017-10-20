

$(document).ready(function(){
	//自定义样式
	$('.cate_menu li>h2>em').css('border-color', 'transparent transparent transparent '+$('.FontBgColor').css('background-color'));
	$('.sidebar_to .b_title').css('border-top-color', $('.FontBgColor').css('background-color'));
	
	/*分类左侧栏(start)*/
	$('.side_category').on('mouseover', '.cate_menu>ul>li', function(){
		$(this).find('h2>a').addClass('FontColor').next('em').addClass('NavArrowHoverColor');
		var json=$.evalJSON($(this).attr('data'));
		if(json.length){
			var index=$(this).addClass('hover').index();
			if(!$(this).find('.cate_subcate').length){
				var html='<div class="cate_subcate">';
				for(i=0; i<json.length; i++){
					html=html+'<dl'+(i>=3?' class="tline"':'')+'><dt><a href="'+json[i].url+'" title="'+json[i].text+'">'+json[i].text+'</a></dt>';
					if(json[i].children){
						var jsonchild=json[i].children;
						html=html+'<dd>';
						for(j=0; j<jsonchild.length; j++){
							html=html+'<a href="'+jsonchild[j].url+'" title="'+jsonchild[j].text+'">'+jsonchild[j].text+'</a>';
						}
						html=html+'</dd>';
					}
					html=html+'</dl>';
					if((i+1)%3==0){html=html+'<div class="blank12"></div>';}
				}
				html=html+"</div>";
				$(this).append(html);
			}
			if(index<=11){
				$(this).find('.cate_subcate').css('top',(-index*30-8)+'px');
			}else{
				$(this).find('.cate_subcate').css('bottom',-40+'px');
			}
		}
	}).on('mouseleave', '.cate_menu>ul>li', function(){
		$(this).removeClass('hover').find('h2>a').removeClass('FontColor').next('em').removeClass('NavArrowHoverColor').parent().parent().find('.cate_subcate').remove();
	});
	/*分类左侧栏(end)*/
	
	/*搜索框分类下拉*/
	$('.search .category').on('mouseleave', function(){
		$list=$(this).find('.list');
		$(this).find('.head').removeClass('selected');
		$list.hide();
	}).on('mouseenter', function(){
		$list=$(this).find('.list');
		$(this).find('.head').addClass('selected');
		$list.show();
	}).on('click', '.list>li', function(){
		$this=$(this);
		$form=$this.parents('form').find('input[name=CateId]');
		$list=$this.parents('form').find('.list');
		$value=$this.attr('cateid');
		$title=$this.text();
		
		$form.val($value);
		$this.parents('form').find('.head').text($title);
		$list.hide();
	});
	
	var home_tab = $('.home_tab .i');
	var home_pro = $('.home_tab_pro .home_pro');
	home_tab.click(function (){
		var i = home_tab.index(this);
		$(this).addClass('cur').siblings('.i').removeClass('cur');
		home_pro.eq(i).css('display', 'block').siblings('.home_pro').css('display', 'none');
	});
	var speed = 300;
	$('.home_title').each(function(i, self) {
		var cateid = $(self).attr('cateid');
		var home_list = $('#home_list'+cateid);
		var list = $('.list', home_list);
		var child = $('.item', home_list);
		if (child.length>4){//超过4个才执行
			var lbtn = $('.b0', self);
			var rbtn = $('.b1', self);
			var iW = child.eq(0).outerWidth(true);
			lbtn.on('click', function (){
				list.prepend(function () {
					$(this).css('margin-left', -iW);
					return $('.item', this).last();
				}).stop(true, true).animate({'margin-left':0}, speed);
			});
			rbtn.on('click', function (){
				list.stop(true, true).animate({'margin-left':-iW}, speed, function (){
					list.css('margin-left', function (){
						$('.item', this).eq(0).appendTo(list);
						return 0;
					})
				});
			});
		}
    });
	
	$('.index_prod_list .move>a').off().on('click', function(){
		var $class=$(this).attr('class'),
			$obj=$(this).parents('.index_prod_list'),
			$len=$obj.find('.index_prod_row').size(),
			$num=parseInt($obj.find('.index_prod_row:visible').attr('num'));
		
		if($class=='move_left'){
			$num-=1;
		}else{
			$num+=1;
		}
		if($num>=$len) $num=0;
		if($num<0) $num=$len-1;
		
		$obj.find('.index_prod_row[num='+$num+']').show().siblings().hide();
	});
	
	//会员注册页头部背景
	$('#customer .header').addClass('FontBgColor');
	
	/****** 导航显示 Start ******/
	function navShow(){
		var $obj=$('.nav'),
			navItemWidth=0,
			navWidth=$obj.width();
		$obj.css('overflow', 'visible').find('.item').each(function(){
			navItemWidth+=$(this).outerWidth();
			if(navItemWidth>navWidth){
				$(this).hide();
			}else{
				$(this).show();
			}
		});
	}
	navShow();
	$(window).resize(function(){ navShow(); });
	/****** 导航显示 End ******/
});


