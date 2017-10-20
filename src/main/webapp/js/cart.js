

var cart_obj={
	cart_init:{
		paypal_checkout_init:function(){
			var CId='0';
			if($('.cartFrom .itemFrom input[name=select_all]').get(0).checked && !$('.cartFrom .itemFrom input[name=select]').not(':checked').length){//全选
				CId='';
			}else if($('.cartFrom .itemFrom input[name=select]:checked').length){//部分已选
				$('.cartFrom .itemFrom input[name=select]:checked').each(function(){
					CId+=','+$(this).val();
				});
			}else{
				alert('Please select at least one item!');
				$(this).blur().attr('disabled', false);
				return false;
			}
			$.ajax({
				type: "POST",
				url: "/?do_action=cart.get_excheckout_country&CId="+CId,
				dataType: "json",
				success: function(data){
					if(data.ret==1){
						var c=data.msg.country;
						var country_select='';
						var defaultCId=226;
						var shoppingCId=0;
						for(i=0; i< c.length; i++){
							if(c[i].IsDefault==1) defaultCId=c[i].CId;
							var s=(defaultCId==c[i].CId?'selected':'');
							var CountryAry=$.evalJSON(c[i].CountryData);
							country_select=country_select+'<option value="'+c[i].CId+'" '+s+'>'+CountryAry[ueeshop_config.lang]+'</option>';
						}
						if($('input=[name=order_cid]').length) shoppingCId=$('input=[name=order_cid]').val();
						
						//var CartProductPrice=$('form[name=shopping_cart] input[name=CartProductPrice]').val();
						var CartProductPrice=parseFloat($('input[name=CartProductPrice]').val());
						var DiscountPrice=parseFloat($('input[name=DiscountPrice]').val());
						var excheckout_html='';
						excheckout_html+='<div id="paypal_checkout_module">';
						excheckout_html+=	'<div class="box_bg"></div><a class="noCtrTrack" id="lb-close">×</a>';
						excheckout_html+=	'<div id="lb-wrapper"><form name="paypal_checkout_form" method="POST" action="/payment/paypal_excheckout/do_payment/">';
						excheckout_html+=		'<label>'+lang_obj.cart.select_y_country+': </label>';
						excheckout_html+=		'<select name="CId"><option value="0">'+lang_obj.products.select_country+'</option>'+country_select+'</select>';
						excheckout_html+=		'<div class="country_error">'+lang_obj.cart.paypal_tips+'</div>';
						excheckout_html+=		'<div id="shipping_method_list">';
						for(k in data.msg.oversea){
							excheckout_html+=		'<div class="oversea" data-id="'+k+'"><div class="title">'+data.msg.oversea[k]+'</div><ul class="list"></ul></div>';
						}
						excheckout_html+=		'</div>';
								
						if(data.msg.v>=1){//达到使用优惠券版本
							var c=data.msg.coupon,
							coupon_html='';
							coupon_html=coupon_html+'<div class="blank6"></div><div class="ex_coupon">';
							if(c.coupon!='' && c.cutprice>0){
								var code=c.coupon,
									price=c.cutprice,
									applyHtml=(lang_obj.cart.coupon_tips).replace('%coupon%', c.coupon)+' <span>'+ueeshop_config.currency_symbols+$('html').currencyFormat(c.cutprice, ueeshop_config.currency)+'</span> <a href="javascript:;" id="removeCoupon">'+lang_obj.cart.remove+'</a>';
							}else{
								var code='',
									price=0,
									applyHtml='<strong>'+lang_obj.cart.coupon_code+': </strong><input type="text" name="couponCode" id="couponCode" size="15" /><input type="button" class="btn apply" value="'+lang_obj.cart.apply+'" />';
							}
							coupon_html=coupon_html+'<span class="applyCoupon">'+applyHtml+'</span></div><input type="hidden" name="order_coupon_code" value="'+code+'" cutprice="'+price+'" />';
							excheckout_html+=coupon_html;
						}

						excheckout_html+=	'<p class="footRegion">';
						excheckout_html+=		'<input class="btn btn-success" id="excheckout_button" type="submit" value="'+lang_obj.cart.continue_str+'" />';
						excheckout_html+=		'<span class="total"><strong>'+lang_obj.cart.total_amout+':</strong><span></span></span>';
						excheckout_html+=	'</p>';
						excheckout_html+=	'<input id="paypal_payment_option" value="paypal_express" type="radio" name="paymentMethod" title="PayPal Express Checkout" class="radio" style="display:none;" checked /><input type="hidden" name="ProductPrice" value="'+CartProductPrice+'" /><input type="hidden" name="DiscountPrice" value="'+DiscountPrice+'" /><input type="hidden" name="ShippingMethodType" value="[]" /><input type="hidden" name="ShippingPrice" value="[]" /><input type="hidden" name="ShippingInsurancePrice" value="[]" /><input type="hidden" name="ShippingExpress" value="[]" /><input type="hidden" name="ShoppingCId" value="'+shoppingCId+'" /><input type="hidden" name="CartCId" value="'+CId+'" /></form></div>';	
						excheckout_html+='</div>';
						excheckout_html+='<script>window.paypalCheckoutReady=function(){ paypal.checkout.setup("'+ueeshop_config.PaypalExcheckout+'", {button:"excheckout_button", environment:"production", condition: function(){ return document.getElementById("paypal_payment_option").checked === true;} }); };</script>';
						
						$('#paypal_checkout_module').length && $('#paypal_checkout_module').remove();
						$('body').prepend(excheckout_html);
						$('#paypal_checkout_module .total span').text(ueeshop_config.currency_symbols + $('html').currencyFormat(CartProductPrice-DiscountPrice, ueeshop_config.currency));
						$('#paypal_checkout_module').css({left:$(window).width()/2-220});
						global_obj.div_mask();
						
						if($('#paypal_checkout_module #shipping_method_list .oversea').length==1){//仅有一个海外仓信息，标题不显示
							$('#paypal_checkout_module #shipping_method_list .oversea>.title').addClass('hide');
						}
						
						cart_obj.cart_init.get_shipping_methods(defaultCId, CId);
						
						//选择国家操作
						$('html').on('change', 'form[name=paypal_checkout_form] select[name=CId]', function(){
							cart_obj.cart_init.get_shipping_methods($(this).val(), CId);
						});
					}
				}
			});
	
			//选择快递操作
			$('html').on('click', 'form[name=paypal_checkout_form] input[name=SId]', function(){
				var price=parseFloat($(this).attr('price'));
				var insurance=parseFloat($(this).attr('insurance'));
				
				$('form[name=paypal_checkout_form] input[name=ShippingMethodType]').val($(this).attr('ShippingType'));
				$('#shipping_method_list li.insurance span.price').text(ueeshop_config.currency_symbols + $('html').currencyFormat(insurance.toFixed(2), ueeshop_config.currency));
				
				$('form[name=paypal_checkout_form] input[name=ShippingExpress]').val($(this).attr('method'));
				$('form[name=paypal_checkout_form] input[name=ShippingPrice]').val(price.toFixed(2));
				
				insurance=$('#__ShippingInsurance').attr('checked')=='checked' ? insurance : 0;
				$('form[name=paypal_checkout_form] input[name=ShippingInsurancePrice]').val(insurance.toFixed(2));
				//$('form[name=paypal_checkout_form] input[name=ShippingPrice]').val(price.toFixed(2));
			});
			
			$('html').on('click', '#__ShippingInsurance', function(){
				var obj=$('form[name=paypal_checkout_form] input[name=SId]:checked')
				var insurance=0;
				if($('#__ShippingInsurance').attr('checked')=='checked'){
					var insurance = parseFloat(obj.attr('insurance'));
				}
				
				$('form[name=paypal_checkout_form] input[name=ShippingInsurancePrice]').val(insurance.toFixed(2));
			});
			
			//使用优惠券
			$('html').off().on('click', '#paypal_checkout_module .ex_coupon input.apply', function(){
				var coupon=$('#paypal_checkout_module .ex_coupon input[name=couponCode]').val();
				if(coupon!=''){
					$(this).removeClass('apply');
					
					var price=parseFloat($('input[name=ProductPrice]').val());
					var order_discount_price=parseFloat($('input[name=DiscountPrice]').val());
					$.post('/?do_action=cart.ajax_get_coupon_info', '&coupon='+coupon+'&price='+price+'&order_discount_price='+order_discount_price, function(data){
						if(data.msg.status==1){
							$('input[name=order_coupon_code]').val(data.msg.coupon).attr('cutprice', data.msg.cutprice);
							$('#paypal_checkout_module .ex_coupon .applyCoupon').html((lang_obj.cart.coupon_tips).replace('%coupon%', coupon)+' <span>'+ueeshop_config.currency_symbols+$('html').currencyFormat(data.msg.cutprice, ueeshop_config.currency)+'</span> <a href="javascript:;" id="removeCoupon">'+lang_obj.cart.remove+'</a>');
						}else{
							alert((lang_obj.cart.coupon_tips_to).replace('%coupon%', coupon));
							$('#paypal_checkout_module .ex_coupon input[name=couponCode]').val('');
							$('#paypal_checkout_module .ex_coupon .applyCoupon input.btn').addClass('apply');
						}
						cart_obj.cart_init.total_price();
					}, 'json');
				}
			});
			
			//删除优惠券
			$('html').on('click', '#paypal_checkout_module #removeCoupon', function(){
				$('input[name=order_coupon_code]').val('').attr('cutprice', '0.00');
				var coupon_input='<strong>'+lang_obj.cart.coupon_code+': </strong><input type="text" name="couponCode" id="couponCode" size="15" /><input type="button" class="btn apply" value="'+lang_obj.cart.apply+'" />'
				$('#paypal_checkout_module .ex_coupon .applyCoupon').html(coupon_input);
				$.post('/?do_action=cart.remove_coupon');
				cart_obj.cart_init.total_price();
			});
			
			//关闭快捷支付
			$('html').on('click', '#lb-close, #div_mask', function(){
				if($('#paypal_checkout_module').length){
					$('#paypal_checkout_module').remove();
					global_obj.div_mask(1);
					$('button.paypal_checkout_button').removeAttr('disabled');
				}
			});
			
			//提交快捷支付
			$('html').on('submit', 'form[name=paypal_checkout_form]', function(){
				var obj=$('form[name=paypal_checkout_form]');
				obj.find('input[type=submit]').attr('disabled', 'disabled').blur();
				if(!obj.find('input[name=SId]:checked').val() && obj.find('input[name=ShippingMethodType]').val()==''){
					alert(lang_obj.cart.shipping_method_tips);
					$('#excheckout_button').removeAttr('disabled');
					return false;
				}
				
				$('#paypal_checkout_module').hide();
				$('button.paypal_checkout_button').removeAttr('disabled');
				global_obj.div_mask(1);
			});
		},
		
		total_price:function(){ //价格显示
			var $TotalPrice=$('#paypal_checkout_module .total span');
			var CartProductPrice=parseFloat($('#paypal_checkout_module input[name=ProductPrice]').val());
			var DiscountPrice=parseFloat($('#paypal_checkout_module input[name=DiscountPrice]').val());
			var couponPrice=parseFloat($('input[name=order_coupon_code]').attr('cutprice'));
			//运费计算
			var inputPrice=$('#paypal_checkout_module input[name=ShippingPrice]'),
				inputPrice_ary={},
				shipPrice=0;
			inputPrice.val()!='[]' && (inputPrice_ary=$.evalJSON(inputPrice.val()));
			for(k in inputPrice_ary){
				shipPrice+=parseFloat(inputPrice_ary[k]);
			}
			//保险费计算
			var inputInsurancePrice=$('#paypal_checkout_module input[name=ShippingInsurancePrice]'),
				inputInsurancePrice_ary={},
				insurancePrice=0;
			inputInsurancePrice.val()!='[]' && (inputInsurancePrice_ary=$.evalJSON(inputInsurancePrice.val()));
			$('#shipping_method_list .oversea').each(function(){
				var obj=$(this).find('li.insurance input:checkbox'),
					OvId=$(this).attr('data-id');
				if(obj.is(':checked')){
					insurancePrice+=parseFloat(inputInsurancePrice_ary['OvId_'+OvId]);
				}
			});
			//总价格计算
			$TotalPrice.text(ueeshop_config.currency_symbols+$('html').currencyFormat((CartProductPrice-DiscountPrice+shipPrice+insurancePrice-couponPrice).toFixed(2), ueeshop_config.currency));
		},
		
		get_shipping_methods:function(CId, CartId){
			$.post('/?do_action=cart.get_shipping_methods', "CId="+CId+(CartId?'&order_cid='+CartId:''), function(data){
				if(data.ret==1){
					var rowObj, rowStr;
					for(OvId in data.msg.info){
						rowStr='';
						rowStr+='<li class="insurance"><label for="__ShippingInsurance['+OvId+']">';
						rowStr+=	'<span><input type="checkbox" id="__ShippingInsurance['+OvId+']" name="ShippingInsurance['+OvId+']" value="1"></span>';
						rowStr+=	'<strong>'+lang_obj.cart.insurance+'</strong>';
						rowStr+=	'<span class="price"></span>';
						rowStr+='</label></li>';
						for(i=0; i<data.msg.info[OvId].length; i++){
							rowObj=data.msg.info[OvId][i];
							if(parseFloat(rowObj.ShippingPrice)<0) continue;
							rowStr+='<li class="shipping" name="'+rowObj.Name.toUpperCase()+'"><label for="__SId__'+i+'">';
							rowStr+=	'<span><input type="radio" id="__SId__'+i+'" name="SId['+OvId+']" value="'+rowObj.SId+'" method="'+rowObj.Name+'" price="'+rowObj.ShippingPrice+'" insurance="'+rowObj.InsurancePrice+'" ShippingType="'+rowObj.type+'" /></span>';
							rowStr+=	'<strong>'+rowObj.Name +'</strong>';
							rowStr+=	'<span>'+rowObj.Brief+'</span>';
							rowStr+=	'<span class="price">'+(rowObj.ShippingPrice>0 ? ueeshop_config.currency_symbols+$('html').currencyFormat(rowObj.ShippingPrice, ueeshop_config.currency) : lang_obj.products.free_shipping)+'</span>';
							rowStr+=	'<div class="clear"></div>';
							rowStr+='</label></li>';
						}
						$('#shipping_method_list .oversea[data-id='+OvId+'] .list').html(rowStr);
						/*if(rowStr==''){
							$('#shippingObj ul[data-id='+OvId+'] .shipping_method_list').html(''); //清空内容
							cart_obj.set_shipping_method(0, -1, 0, '', 0);
						}else{
							$('#shippingObj ul[data-id='+OvId+'] .shipping_method_list li:eq(0)').click(); //默认点击第一个选项
						}*/
					}
					//价格显示
					$('#shipping_method_list li.shipping input:radio').change(function(){
						var express=$(this).attr('method'),
							type=$(this).attr('ShippingType'),
							shipPrice=parseFloat($(this).attr('price')),
							insurance=parseFloat($(this).attr('insurance')),
							OvId=$(this).parents('.oversea').attr('data-id');
						$(this).parents('ul.list').find('.insurance .price').text(ueeshop_config.currency_symbols+$('html').currencyFormat(insurance, ueeshop_config.currency));
						//运费记录
						var inputExpress=$('#paypal_checkout_module input[name=ShippingExpress]'),
							inputType=$('#paypal_checkout_module input[name=ShippingMethodType]'),
							inputPrice=$('#paypal_checkout_module input[name=ShippingPrice]'),
							inputInsurancePrice=$('#paypal_checkout_module input[name=ShippingInsurancePrice]'),
							inputExpress_ary={}, inputType_ary={}, inputPrice_ary={}, inputInsurancePrice_ary={};
							
						inputExpress.val()!='[]' && (inputExpress_ary=$.evalJSON(inputExpress.val()));
						inputExpress_ary['OvId_'+OvId]=express;
						inputExpress.val($.toJSON(inputExpress_ary));
				
						inputType.val()!='[]' && (inputType_ary=$.evalJSON(inputType.val()));
						inputType_ary['OvId_'+OvId]=type;
						inputType.val($.toJSON(inputType_ary));
						
						inputPrice.val()!='[]' && (inputPrice_ary=$.evalJSON(inputPrice.val()));
						inputPrice_ary['OvId_'+OvId]=shipPrice;
						inputPrice.val($.toJSON(inputPrice_ary));
						
						if($(this).parents('ul.list').find('.insurance input:checkbox').is(':checked')){
							inputInsurancePrice.val()!='[]' && (inputInsurancePrice_ary=$.evalJSON(inputInsurancePrice.val()));
							inputInsurancePrice_ary['OvId_'+OvId]=insurance;
							inputInsurancePrice.val($.toJSON(inputInsurancePrice_ary));
						}
						
						cart_obj.cart_init.total_price();
					});
					$('#shipping_method_list li.insurance input:checkbox').change(function(){
						var obj=$(this).parents('ul.list').find('.shipping input:radio:checked'),
							OvId=$(this).parents('.oversea').attr('data-id'),
							inputInsurancePrice=$('#paypal_checkout_module input[name=ShippingInsurancePrice]'),
							inputInsurancePrice_ary={},
							insurance=0;
						if($(this).length>0 && $(this).is(':checked')){
							insurance=parseFloat(obj.attr("insurance"));
						}
						inputInsurancePrice.val()!='[]' && (inputInsurancePrice_ary=$.evalJSON(inputInsurancePrice.val()));
						inputInsurancePrice_ary['OvId_'+OvId]=insurance;
						inputInsurancePrice.val($.toJSON(inputInsurancePrice_ary));
						cart_obj.cart_init.total_price();
					});
					//默认点击第一个
					$('#shipping_method_list .oversea').each(function(){
						$(this).find('li.shipping:eq(0) input:radio').click().change();
						$(this).find('li.insurance input:checkbox').click().change();
					});
					/*
					var v=data.msg.info;					
					var str=shipType=shipMethod='';
					var shipPrice=insurance=ShippingInsurance=0;
					var start=-1;
					var j=0;
					for(i=0; i<v.length; ++i){
						if(parseFloat(v[i].ShippingPrice)<0) continue;
						start==-1 && (start=i);
						var sed=j==0?'checked':'';
						str = str + '<li><label for="__SId__'+i+'">';
							str = str + '<span><input type="radio" id="__SId__'+i+'" name="SId" value="' + v[i].SId + '" method="' + v[i].Name  + '" price="'+ v[i].ShippingPrice + '" insurance="'+ v[i].InsurancePrice + '" ShippingType="' + v[i].type + '" ' + sed + ' /></span>';
							str = str + '<strong>' + v[i].Name  + '</strong>';
							str = str + '<span>' + v[i].Brief + '</span>';
							str = str + '<span class="price">' + (v[i].ShippingPrice>0 ? ueeshop_config.currency_symbols + $('html').currencyFormat(v[i].ShippingPrice, ueeshop_config.currency) : lang_obj.products.free_shipping) + '</span>';
						str = str + '</label></li>';
						++j;
					}
					if(rowStr!=''){
						var str_ext = '';
						InsurancePrice=parseFloat(v[start].InsurancePrice);
						if(parseInt(data.msg.IsInsurance)){
							str_ext = '<li class="insurance"><label for="__ShippingInsurance">';
								str_ext = str_ext + '<span><input type="checkbox" id="__ShippingInsurance" name="ShippingInsurance" value="1" checked="checked"></span>';
								str_ext = str_ext + '<strong>'+lang_obj.cart.insurance+'</strong>';
								str_ext = str_ext + '<span class="price">' + ueeshop_config.currency_symbols + $('html').currencyFormat(InsurancePrice, ueeshop_config.currency) + '</span>';
							str_ext = str_ext + '</label></li>';
							$('form[name=paypal_checkout_form] input[name=ShippingInsurance]').val(1);
							$('form[name=paypal_checkout_form] input[name=ShippingInsurancePrice]').val(InsurancePrice.toFixed(2));
						}
						
						str=str_ext+str;
						shipType=v[start].type;
						shipMethod=v[start].Name;
						ShippingInsurance=1;
						shipPrice=parseFloat(v[start].ShippingPrice);
						insurance=parseFloat(v[start].InsurancePrice);
					}else{
						str = str + '<li><strong>'+lang_obj.products.no_optional+'!</strong></li>';
					}
					$('form[name=paypal_checkout_form] input[name=ShippingExpress]').val(shipMethod);
					$('form[name=paypal_checkout_form] input[name=ShippingMethodType]').val(shipType);
					$('form[name=paypal_checkout_form] input[name=ShippingPrice]').val(shipPrice.toFixed(2));
					//价格显示
					cart_obj.cart_init.total_price();
					$('#shipping_method_list input[name=SId]').change(function (){
						shipPrice=parseFloat($(this).attr('price'));
						insurance=parseFloat($(this).attr('insurance'));
						$('#shipping_method_list .insurance .price').text(ueeshop_config.currency_symbols + $('html').currencyFormat(insurance, ueeshop_config.currency));
						$('form[name=paypal_checkout_form] input[name=ShippingExpress]').val($(this).attr('method'));
						$('form[name=paypal_checkout_form] input[name=ShippingPrice]').val(shipPrice.toFixed(2));
						$('form[name=paypal_checkout_form] input[name=ShippingInsurancePrice]').val(insurance.toFixed(2));
						cart_obj.cart_init.total_price();
					});
					var $ShippingInsurance=$('#shipping_method_list input[name=ShippingInsurance]');
					$ShippingInsurance.change(function (){
						var obj=$('#shipping_method_list input[name=SId]:checked');
						if($ShippingInsurance.length>0 && $ShippingInsurance.is(':checked')){
							insurance=parseFloat($(obj).attr("insurance"));
						}else{
							insurance=0;
						}
						$('form[name=paypal_checkout_form] input[name=ShippingInsurancePrice]').val(insurance.toFixed(2));
						cart_obj.cart_init.total_price();
					});
					*/
				}else{
					$('form[name=paypal_checkout_form] input[name=ShippingExpress]').val('');
					$('form[name=paypal_checkout_form] input[name=ShippingMethodType]').val('');
					$('form[name=paypal_checkout_form] input[name=ShippingInsurance]').val('');
					$('form[name=paypal_checkout_form] input[name=ShippingInsurancePrice]').val(0);
					$('form[name=paypal_checkout_form] input[name=ShippingPrice]').val(0);
					$('#shipping_method_list').html('');
				}
			}, 'json');
		},
		
		ajax_get_coupon_info:function(code){
			var str='';
			if($('input[name=order_products_info]').length){ str='&jsonData='+$('input[name=order_products_info]').val();}
			var price=parseFloat($('#PlaceOrderFrom').attr('amountprice'));
			var userprice=parseFloat($('#PlaceOrderFrom').attr('userprice'));
			var order_discount_price=parseFloat($('input[name=order_discount_price]').val());
			$.post("/?do_action=cart.ajax_get_coupon_info", '&coupon='+code+'&price='+price+str+'&userprice='+userprice+'&order_discount_price='+order_discount_price, function(data){
				if(data.msg.status==1){
					$('#couponValResult>span').hide(200);
					$('#couponSavings').show(200);
					$('input[name=order_coupon_code]').val(data.msg.coupon).attr('cutprice', data.msg.cutprice);
					
					//运费计算
					var inputPrice=$('#PlaceOrderFrom input[name=order_shipping_price]'),
						inputPrice_ary={},
						shipPrice=0;
					inputPrice.val()!='[]' && (inputPrice_ary=$.evalJSON(inputPrice.val()));
					for(k in inputPrice_ary){
						shipPrice+=parseFloat(inputPrice_ary[k]);
					}
					
					//保险费计算
					var inputInsurance=$('#PlaceOrderFrom input[name=order_shipping_insurance]'),
						inputInsurance_ary={}, inputInsurancePrice_ary={},
						insurancePrice=0;
					inputInsurance.val()!='[]' && (inputInsurance_ary=$.evalJSON(inputInsurance.val()));
					inputInsurance.attr('price')!='[]' && (inputInsurancePrice_ary=$.evalJSON(inputInsurance.attr('price')));
					for(k in inputInsurance_ary){
						if(inputInsurance_ary[k]==1){
							insurancePrice+=parseFloat(inputInsurancePrice_ary[k]);
						}
					};

					var amount=parseFloat($('#PlaceOrderFrom').attr('amountPrice')); //产品总价
					var userPrice=parseFloat($('#PlaceOrderFrom').attr('userPrice')); //会员优惠
					var discountPrice=parseFloat($('input[name=order_discount_price]').val()); //满额减价
					var cutprice=parseFloat($('input[name=order_coupon_code]').attr('cutprice')); //折扣
					var fee=parseFloat($('#ot_fee').attr('fee'));
					var affix=parseFloat($('#ot_fee').attr('affix'));
					if(isNaN(fee)) fee=0;
					if(isNaN(affix)) affix=0;
					
					var totalAmount=amount-userPrice+shipPrice+insurancePrice-cutprice-discountPrice; //最终价格
					var feePrice=totalAmount*(fee/100)+affix; //付款手续费
					
					$('#ot_fee').text($('html').currencyFormat(feePrice.toFixed(2), ueeshop_config.currency));
					$('#ot_coupon').text($('html').currencyFormat(cutprice.toFixed(2), ueeshop_config.currency)).show(200);
					$('#ot_total').text($('html').currencyFormat((totalAmount+feePrice).toFixed(2), ueeshop_config.currency));
					
					cart_obj.return_payment_list(totalAmount, feePrice);
					
					$('#new-coupon-valid>span').show().children('strong:eq(0)').text(data.msg.coupon).siblings('span').text(ueeshop_config.currency + $('html').currencyFormat(cutprice.toFixed(2), ueeshop_config.currency)).siblings('strong:eq(1)').text(data.msg.end);
					$('#removeCoupon').show();
					$('#to-use-coupon').hide();
					
					$('#lb-close').click();
				}else{
					$('#couponValResult .invalid').show(200).children('strong').text(data.msg.coupon);
				}
			}, 'json');
		}
	},
	cart_list:function(){
		$('.itemFrom tbody tr:last-child').find('td').addClass('last');
		
		//-----------------------------------------------------更新购物车产品数量(start)-----------------------------------------------------
		$('.itemFrom .prQuant img').click(function(){
			var parent=$(this).parent();
			var value=$(this).attr('name')=='add'?1:-1;
			var obj=parent.parent().index();
			var start=parent.attr('start');
			var qty=parent.find("input[name=Qty\\[\\]]").val();
			var s_qty=parent.find("input[name=S_Qty\\[\\]]").val();
			var CId=parent.find("input[name=CId\\[\\]]").val();
			var ProId=parent.find("input[name=ProId\\[\\]]").val();
			
			var qty=Math.abs(parseInt(qty));
			if(isNaN(qty)){
				qty=1;
			}else{
				qty+=value;
				!qty && (qty=1);
				qty<start && (qty=start);
			}
			
			if(s_qty==qty) return;
			global_obj.data_posting(true, lang_obj.cart.processing);
			var query_string='&Qty='+qty+'&CId='+CId+'&ProId='+ProId;
			var cid_str='&CIdAry=';
			if($('.cartFrom .itemFrom input[name=select]:checked').length && !$('.cartFrom .itemFrom input[name=select_all]').get(0).checked){//部分已选
				cid_str+='0';
				$('.cartFrom .itemFrom input[name=select]:checked').each(function(index, element){
					cid_str+=','+$(element).val();
				});
			}
			modify_cart_result(obj, query_string+cid_str);
		});
		$('a[rel=del]').click(function(){
			if(!confirm(lang_obj.global.del_confirm)){
				return false;
			}
		});
		$('a[name=remove]').click(function(){
			var cid_str='';
			if($('.cartFrom .itemFrom tbody input[name=select]:checked').length){
				cid_str+='0';
				$('.cartFrom .itemFrom input[name=select]:checked').each(function(index, element){
					cid_str+=','+$(element).val();
				});
			}else{
				global_obj.win_alert(lang_obj.cart.batch_remove_select);
				return false;
			}
			
			if(!confirm(lang_obj.global.del_confirm)){
				return false;
			}
			
			$.post('/?do_action=cart.bacth_remove&t='+Math.random(), 'cid_list='+cid_str, function(data){
				if(data.ret==1){
					global_obj.win_alert(lang_obj.cart.batch_remove_success, function(){window.location='/cart/';});
				}else{
					global_obj.win_alert(lang_obj.cart.batch_remove_error);
				}
			}, 'json');/**/
		});
		
		$('.itemFrom .prQuant input[name=Qty\\[\\]]').bind({
			'keyup paste':function(){
					p=/[^\d]/g;
					$(this).val($(this).val().replace(p, ''));
				},
			'blur':function(){
					var qty=parseInt($(this).val());
					var obj=$(this).parent().parent().index();
					var start=$(this).parent().attr('start');
					var s_qty=$(this).parent().find("input[name=S_Qty\\[\\]]").val();
					var CId=$(this).parent().find("input[name=CId\\[\\]]").val();
					var ProId=$(this).parent().find("input[name=ProId\\[\\]]").val();
					
					if(isNaN(qty)){
						qty=1;
					}else{
						!qty && (qty=1);
						qty<start && (qty=start);
					}
					$(this).val(qty);
					
					if(s_qty==qty) return;
					global_obj.data_posting(true, lang_obj.cart.processing);
					var query_string='&Qty='+qty+'&CId='+CId+'&ProId='+ProId;
					var cid_str='&CIdAry=';
					if($('.cartFrom .itemFrom input[name=select]:checked').length && !$('.cartFrom .itemFrom input[name=select_all]').get(0).checked){//部分已选
						cid_str+='0';
						$('.cartFrom .itemFrom input[name=select]:checked').each(function(index, element){
							cid_str+=','+$(element).val();
						});
					}
					modify_cart_result(obj, query_string+cid_str);
				}
		});
		
		$(document).on('click', function(e){
			if($(e.target).attr('name')!='Qty[]'){
				$('.itemFrom .prQuant input[name=Qty\\[\\]]').blur();
			}
		});
		
		function modify_cart_result(obj, query_string){
			var tr=$('.itemFrom tbody tr');
			var s_qty=tr.eq(obj).find("input[name=S_Qty\\[\\]]").val();
			var buy_now=$('#lib_cart').hasClass('buynow_content')?1:0;
			$.post('/?do_action=cart.modify&BuyNow='+buy_now+'&t='+Math.random(), query_string, function(data){
				if(data.ret==1 || data.ret==2){
					if(data.ret==2) window.location.reload();
					//var cutprice=$('.cutprice_p').length?parseFloat($('.cutprice_p').attr('price')):0;
					tr.eq(obj).find("input[name=Qty\\[\\]]").val(data.msg.qty);
					tr.eq(obj).find("input[name=S_Qty\\[\\]]").val(data.msg.qty);
					tr.eq(obj).find(".prPrice p").text(ueeshop_config.currency_symbols + $('html').currencyFormat(data.msg.price, ueeshop_config.currency));
					tr.eq(obj).find(".prAmount p").text(ueeshop_config.currency_symbols + $('html').currencyFormat(data.msg.amount, ueeshop_config.currency)).attr('price', data.msg.amount);
					var punit=data.msg.total_count>1?'s':'';
					$('.cutprice_p').text(ueeshop_config.currency_symbols + $('html').currencyFormat(data.msg.cutprice, ueeshop_config.currency));
					$('.total_p').text(ueeshop_config.currency_symbols + $('html').currencyFormat(data.msg.total_price, ueeshop_config.currency));
					$('.shopping_cart_total span').text(data.msg.total_count+' item'+punit);
					$('.shopping_cart_total strong').text(ueeshop_config.currency_symbols + $('html').currencyFormat((data.msg.total_price - data.msg.cutprice).toFixed(2), ueeshop_config.currency));
					$('input[name=CartProductPrice]').val(data.msg.total_price);
					$('input[name=DiscountPrice]').val(data.msg.cutprice);
					
					if(!buy_now){//购物车列表页面
						if(data.msg.cutprice>0){
							$('.cutprice_box, .total_box').show();
						}else{
							$('.cutprice_box, .total_box').hide();
						}
					}else{//BuyNow页面
						obj=$('#lib_address li:eq(0) input[name=shipping_address_id]');
						if(obj.length){	//set style shipping address
							cart_obj.get_shipping_method_from_country(obj.attr('CId'));
						}
						if($('#total_weight').length) $('#total_weight').text(data.msg.total_weight.toFixed(3));
						
						/******************** 优惠券处理 消费条件不足 start ********************/
						if(parseInt(data.msg.IsCoupon)==0){
							$('input[name=order_coupon_code]').val('').attr('cutprice', '0.00');
							$('#to-use-coupon').show(200);
							$('#new-coupon-valid>span').hide().children('strong:eq(0)').text('').siblings('span').text('').siblings('strong:eq(1)').text('');
							$('#removeCoupon').hide();
							$('#couponSavings').hide();
							if($('#new-coupon-valid').length) $('body,html').animate({scrollTop:$('#new-coupon-valid').offset().top}, 500);
							global_obj.win_alert(lang_obj.cart.coupon_price_tips);
						}
						/******************** 优惠券处理 消费条件不足 end ********************/
						
						$('#PlaceOrderFrom').attr('amountPrice', data.msg.amount);
						$('#ot_subtotal').text($('html').currencyFormat(data.msg.amount.toFixed(2), ueeshop_config.currency));
						var amount=parseFloat(data.msg.amount); //产品总价
						var userRatio=parseInt($('#PlaceOrderFrom').attr('userRatio')); //会员优惠折扣比率
						var userPrice=amount-(amount*(userRatio/100));
						var discountPrice=parseFloat(data.msg.cutprice); //满额减价
						var cutprice=parseFloat($('input[name=order_coupon_code]').attr('cutprice')); //折扣
						//var price=parseFloat($('input[name=order_shipping_price]').val());	//运费
						//var insurance=parseFloat($('input[name=order_shipping_insurance]').attr('price')); //运费保险
						var fee=parseFloat($('#ot_fee').attr('fee'));
						var affix=parseFloat($('#ot_fee').attr('affix'));
						if(isNaN(fee)) fee=0;
						if(isNaN(affix)) affix=0;
						
						//运费计算
						var inputPrice=$('#PlaceOrderFrom input[name=order_shipping_price]'),
							inputPrice_ary={},
							shipPrice=0;
						inputPrice.val()!='[]' && (inputPrice_ary=$.evalJSON(inputPrice.val()));
						for(k in inputPrice_ary){
							shipPrice+=parseFloat(inputPrice_ary[k]);
						}
						
						//保险费计算
						var inputInsurance=$('#PlaceOrderFrom input[name=order_shipping_insurance]'),
							inputInsurance_ary={}, inputInsurancePrice_ary={},
							insurancePrice=0;
						inputInsurance.val()!='[]' && (inputInsurance_ary=$.evalJSON(inputInsurance.val()));
						inputInsurance.attr('price')!='[]' && (inputInsurancePrice_ary=$.evalJSON(inputInsurance.attr('price')));
						for(k in inputInsurance_ary){
							if(inputInsurance_ary[k]==1){
								insurancePrice+=parseFloat(inputInsurancePrice_ary[k]);
							}
						};
						
						if(userPrice && discountPrice){
							if(discountPrice>userPrice) userPrice=0;
							else discountPrice=0;
						}
						
						var totalAmount=amount-userPrice+shipPrice+insurancePrice-cutprice-discountPrice; //最终价格
						var feePrice=totalAmount*(fee/100)+affix; //付款手续费
						
						if(userPrice){//会员价格
							$('#ot_user').text($('html').currencyFormat(userPrice.toFixed(2), ueeshop_config.currency));
							$('#memberSavings').show();
							$('#subtotalDiscount').hide();
							$('#PlaceOrderFrom').attr('userPrice', userPrice.toFixed(2));
						}else if(discountPrice){//全场满减价格
							$('#ot_subtotal_discount > strong').text($('html').currencyFormat(discountPrice.toFixed(2), ueeshop_config.currency));
							$('#memberSavings').hide();
							$('#subtotalDiscount').show();
							$('input[name=order_discount_price]').val(discountPrice);
						}else{//没有优惠
							$('#memberSavings, #subtotalDiscount').hide();
							$('#PlaceOrderFrom').attr('userPrice', 0);
							$('input[name=order_discount_price]').val(0);
						}
						$('#ot_fee').text($('html').currencyFormat(feePrice.toFixed(2), ueeshop_config.currency));
						$('#ot_coupon').text($('html').currencyFormat(cutprice.toFixed(2), ueeshop_config.currency)).show(200);
						$('#ot_total').text((totalAmount+feePrice).toFixed(2));
						//优惠券处理
						parseInt(data.msg.IsCoupon) && $('input[name=order_coupon_code]').val() && cart_obj.cart_init.ajax_get_coupon_info($('input[name=order_coupon_code]').val());
					}
				}else{
					tr.eq(obj).find("input[name=Qty\\[\\]]").val(s_qty);
				};
				if($('input[name=order_shipping_address_cid]').length){
					var cid=parseInt($('input[name=order_shipping_address_cid]').val());
					if(cid<=0){
						cid=parseInt($('#country').val());
					}
					cart_obj.get_shipping_method_from_country(cid);
				}
				global_obj.data_posting(false);
			}, 'json');
		}
		//-----------------------------------------------------更新购物车产品数量(end)-----------------------------------------------------
		
		
		//-----------------------------------------------------更新购物车产品备注(start)-----------------------------------------------------
		$('.itemFrom tbody tr td.prList dd p input[name=Remark\\[\\]]').focus( function(){
			$(this).next().find('img').show();
		});

		$('.itemFrom tbody tr td.prList dd p span').click(function(){
			global_obj.data_posting(true, lang_obj.cart.processing);
			modify_remark_result($(this).parent().find('input[name=Remark\\[\\]]'));
		});
		
		function modify_remark_result(obj){
			if(obj.val()==obj.attr('data')){
				global_obj.data_posting(false);
				obj.next('span').find('img').hide(500);
				return false;
			}
			
			var o=obj.parent().parent().parent().parent().siblings('td.prQuant'),
				cid=o.find('input[name=CId\\[\\]]').val(),
				proid=o.find('input[name=ProId\\[\\]]').val(),
				query_string='&Remark='+obj.val()+'&CId='+cid+'&ProId='+proid;
				
			$.post('/?do_action=cart.modify_remart&t='+Math.random(), query_string, function(data){
				if(data.ret==1){
					obj.attr('data', obj.val());
				};
				global_obj.data_posting(false);
				obj.next('span').find('img').hide(500);
			}, 'json');
		}
		//-----------------------------------------------------更新购物车产品备注(end)-----------------------------------------------------
		
		
		//-----------------------------------------------------更新购物车产品属性(start)-----------------------------------------------------
		$('.itemFrom tbody tr td.prList dd .prAttr .prAttr_mod').click(function(){
			var o=$(this).parents('td.prList').siblings('td.prQuant'),
				cid=o.find('input[name=CId\\[\\]]').val(),
				proid=o.find('input[name=ProId\\[\\]]').val(),
				obj=$(this).next('.attr_edit'),
				content=obj.children('.attr_edit_content'),
				data={"CId":cid, "ProId":proid};
			
			$('.attr_edit_content').html('').parent().hide().parent().removeClass('cur');//清除其他已打开的
			$(this).parents('.prAttr').addClass('cur');
			obj.show();
			content.loading();
			$(".loading_msg").css({"top":0, "position":"initial", "width":"auto", "height":100, "background-position":"center"});
			setTimeout(function(){
				$.ajax({
					url:"/ajax/cart_modify_attribute.html",//"/?m=ajax&a=cart_modify_attribute",
					async:false,
					type:'post',
					data:data,
					dataType:'html',
					success:function(result){
						if(result){
							content.html('').append(result).unloading();
						}else{
							var html='<div class="blank25"></div><div id="loading_tips">'+lang_obj.seckill.no_products+'</div>';
							content.html('').append(html).unloading();
						}
						cart_attribute_edit();
					}
				});
			}, 500);
		});
		
		function attribute_check_stock(){
			var attr_len=$("ul.attributes li").length,
				ext_attr=$.evalJSON($("#ext_attr").val()), //扩展属性
				$attrStock=parseInt($("#attrStock").val());
			
			if($attrStock){ //开启了0是库存为空的设定
				var ext_ary=new Object, ary=new Object, cur, stock_ary=new Object;
				for(k in ext_attr){
					ary=k.split('_');
					for(k2 in ary){
						if(!stock_ary[ary[k2]]) stock_ary[ary[k2]]=0;
					}
					if(ext_attr[k][1]>0){
						for(k2 in ary){
							if(ary.length!=attr_len) continue;
							stock_ary[ary[k2]]+=1;
						}
					}
				}
				for(k in stock_ary){
					if(stock_ary[k]<1){
						if($('option[value="'+k+'"]').length) $('option[value="'+k+'"]').addClass('hide hide_fixed').get(0).disabled=true;
					}else{
						if($('option[value="'+k+'"]').length) $('option[value="'+k+'"]').removeClass('hide hide_fixed').get(0).disabled=false;
					}
				}
			}
		}
		
		function cart_attribute_edit(){
			var VId, attr_id, attr_ary=new Object,
				attr_hide=$("#attr_hide"),
				attr_len=$("ul.attributes li").length,
				ext_attr=$.evalJSON($("#ext_attr").val()),//扩展属性
				$attrStock=parseInt($("#attrStock").val()),
				$IsCombination=$('ul.attributes').attr('data-combination');//是否开启规格组合
			
			$(".itemFrom tbody tr td.prList .attr_edit .attributes").on("change", "select", function(){//选择属性下拉
				VId=$(this).val();
				attr_id=$(this).attr("attr");
				if(attr_hide.val() && attr_hide.val()!='[]'){
					attr_ary=$.evalJSON(attr_hide.val());
				}
				if(VId){
					attr_ary[attr_id]=VId;
				}else{//选择默认选项，清除对应ID
					delete attr_ary[attr_id];
				}
				attr_hide.val($.toJSON(attr_ary));
				
				var i=0, cur_attr='';
				for(k in attr_ary){
					cur_attr+=(i?'_':'')+attr_ary[k];
					++i;
				}
				
				if($attrStock && $IsCombination==1){
					if(attr_hide.val()=='[]' || attr_hide.val()=='{}'){//组合属性都属于默认选项
						attribute_check_stock(); //检查当前所有属性库存的情况
					}else if(ext_attr && ext_attr!='[]'){//判断组合属性库存状态
						var select_ary=new Array, i=-1, ext_ary=new Object, ary=new Object, cur, no_stock_ary=new Object;
						for(k in attr_ary){
							select_ary[++i]=attr_ary[k];
						}
						if(select_ary.length == attr_len-1){ //勾选数 比 属性总数 少一个
							var no_attrid=0, attrid=0, _select_ary, key;
							$('ul.attributes li').each(function(){
								attrid=$(this).children('select').attr('attr');
								if(!attr_ary[attrid]){
									no_attrid=attrid; //没有勾选的属性ID
								}
							});
							$('#attr_'+no_attrid).find('option:gt(0)').each(function(){
								value=$(this).attr('value');
								_select_ary=new Array;
								for(k in select_ary){
									_select_ary[k]=select_ary[k];
								}
								_select_ary[select_ary.length]=value;
								//_select_ary.sort(function(a, b){ return a - b });
								_select_ary.sort(function(a, b){
									if(a.indexOf('Ov:')!=-1 || b.indexOf('Ov:')!=-1){
										a=99999999;
									}else if(b.indexOf('Ov:')!=-1){
										b=99999999;
									}
									return a - b;
								});
								key=_select_ary.join('_');
								if(ext_attr[key][1]==0){
									if($('option[value="'+value+'"]').length) $('option[value="'+value+'"]').addClass('hide').get(0).disabled=true;
								}else{
									if($('option[value="'+value+'"]').length) $('option[value="'+value+'"]').removeClass('hide').get(0).disabled=false;
								}
								if(VId==''){ //取消操作
									$('ul.attributes li').each(function(){
										if($(this).children('select').attr('attr')!=attr_id && $(this).find('option.hide').length){
											$(this).find('option.hide').not('.hide_fixed').removeClass('hide').get(0).disabled=false;
										}
									});
								}
							});
						}else if(select_ary.length == attr_len && attr_len!=1){ //勾选数 跟 属性总数 一致
							for(k in ext_attr){
								ary=k.split('_');
								for(k2 in ary){
									if(!no_stock_ary[ary[k2]]) no_stock_ary[ary[k2]]=0;
								}
								cur=0;
								for(k2 in select_ary){
									if(global_obj.in_array(select_ary[k2], ary) && ary.length==attr_len){ //找出包含自身的关联项数据，不一致的属性数量数据也排除掉
										++cur;
									}
								}
								if(cur && cur>=(select_ary.length-1) && select_ary.length==attr_len){ //“数值里已有的选项数量”跟“已勾选的选项数量”一致
									if(ext_attr[k][1]==0){
										for(k2 in ary){
											if(global_obj.in_array(ary[k2], select_ary)) continue;
											if(!no_stock_ary[ary[k2]]){
												no_stock_ary[ary[k2]]=1;
											}else{
												no_stock_ary[ary[k2]]+=1;
											}
										}
									}
								}
							}
							for(k in no_stock_ary){
								if(!global_obj.in_array(k, select_ary) && no_stock_ary[k]>0){
									if($('option[value="'+k+'"]').length) $('option[value="'+k+'"]').addClass('hide').get(0).disabled=true;
								}else{
									if($('option[value="'+k+'"]').length) $('option[value="'+k+'"]').removeClass('hide').get(0).disabled=false;
								}
							}
						}else{ //勾选数 大于 1
							$('ul.attributes li').each(function(){
								$(this).find('option.hide').not('.hide_fixed').removeClass('hide').attr('disabled', false);
							});
						}
					}
				}
			});
			
			if($(".attr_edit .attributes li select").length){
				$(".attr_edit .attributes li select").each(function(){
					$(this).find("option:selected").change();
				});
			}
			
			//确定提交
			$('.itemFrom tbody tr td.prList .attr_edit .add').on('click', function(){
				var query_string='',
					obj=Object(),
					subObj=$(this).parents('.attr_edit');
				
				subObj.find("select").each(function(){
					obj[$(this).attr('attr')]=$(this).val();
				});
				var cid_str='';
				if($('.cartFrom .itemFrom input[name=select]:checked').length && !$('.cartFrom .itemFrom input[name=select_all]').get(0).checked){//部分已选
					cid_str+='0';
					$('.cartFrom .itemFrom input[name=select]:checked').each(function(index, element){
						cid_str+=','+$(element).val();
					});
				}
				query_string={"CId":$('#CId').val(), "ProId":$('#ProId').val(), "Attr":obj, "CIdAry":cid_str};
				
				$.post('/?do_action=cart.modify_attribute&t='+Math.random(), query_string, function(data){
					if(data.ret==1){
						var buy_now=$('#lib_cart').hasClass('buynow_content')?1:0,
							cutprice=$('.cutprice_p').length?parseFloat($('.cutprice_p').attr('price')):0,
							tr=$('input[name=CId\\[\\]][value='+data.msg.CId+']').parents('tr'),
							attr=$.evalJSON(data.msg.Property),
							itemprice=parseFloat(data.msg.itemprice),
							qty=parseInt(data.msg.qty),
							amount=parseFloat(data.msg.amount);
						
						for(i in attr){
							tr.find('.prList .prAttr>p[class="attr_'+i+'"]').text((i=='Overseas'?lang_obj.products.ships_from:i)+': '+attr[i]);
						}
						tr.find('.prList dt img').attr('src', data.msg.PicPath);
						tr.find("input[name=Qty\\[\\]]").val(qty);
						tr.find("input[name=S_Qty\\[\\]]").val(qty);
						tr.find('.prPrice>p').text(ueeshop_config.currency_symbols + $('html').currencyFormat(itemprice.toFixed(2), ueeshop_config.currency));
						tr.find('.prAmount>p').attr('price', amount.toFixed(2)).text(ueeshop_config.currency_symbols + $('html').currencyFormat(amount.toFixed(2), ueeshop_config.currency));
						if(!buy_now) tr.find('input[name=select]').click().get(0).checked='checked';
						
						var punit=data.msg.total_count>1?'s':'';
						$('.cutprice_p').text(ueeshop_config.currency_symbols + $('html').currencyFormat(data.msg.cutprice, ueeshop_config.currency));
						$('.total_p').text(ueeshop_config.currency_symbols + $('html').currencyFormat(data.msg.total_price, ueeshop_config.currency));
						$('.shopping_cart_total span').text(data.msg.total_count+' item'+punit);
						$('.shopping_cart_total strong').text(ueeshop_config.currency_symbols + $('html').currencyFormat((data.msg.total_price - data.msg.cutprice).toFixed(2), ueeshop_config.currency));
						$('form[name=shopping_cart] input[name=CartProductPrice]').val(data.msg.total_price);
						
						if(!buy_now){
							if(data.msg.cutprice>0){
								$('.cutprice_box, .total_box').show();
							}else{
								$('.cutprice_box, .total_box').hide();
							}
						}else{
							obj=$('#lib_address li:eq(0) input[name=shipping_address_id]');
							if(obj.length){	//set style shipping address
								cart_obj.get_shipping_method_from_country(obj.attr('CId'));
							}
							if($('#total_weight').length) $('#total_weight').text(data.msg.total_weight.toFixed(3));
							
							/******************** 优惠券处理 消费条件不足 start ********************/
							if(parseInt(data.msg.IsCoupon)==0){
								$('input[name=order_coupon_code]').val('').attr('cutprice', '0.00');
								$('#to-use-coupon').show(200);
								$('#new-coupon-valid>span').hide().children('strong:eq(0)').text('').siblings('span').text('').siblings('strong:eq(1)').text('');
								$('#removeCoupon').hide();
								$('#couponSavings').hide();
								if($('#new-coupon-valid').length) $('body,html').animate({scrollTop:$('#new-coupon-valid').offset().top}, 500);
								global_obj.win_alert(lang_obj.cart.coupon_price_tips);
							}
							/******************** 优惠券处理 消费条件不足 end ********************/
							
							$('#PlaceOrderFrom').attr('amountPrice', data.msg.total_price);
							$('#ot_subtotal').text($('html').currencyFormat(data.msg.total_price.toFixed(2), ueeshop_config.currency));
							var amount=parseFloat(data.msg.total_price);	//产品总价
							var userRatio=parseInt($('#PlaceOrderFrom').attr('userRatio')); //会员优惠折扣比率
							var userPrice=amount-(amount*(userRatio/100));
							var discountPrice=parseFloat(data.msg.cutprice); //满额减价
							var cutprice=parseFloat($('input[name=order_coupon_code]').attr('cutprice'));	//折扣
							//var price=parseFloat($('input[name=order_shipping_price]').val());	//运费
							//var insurance=parseFloat($('input[name=order_shipping_insurance]').attr('price'));	//运费保险
							var fee=parseFloat($('#ot_fee').attr('fee'));
							var affix=parseFloat($('#ot_fee').attr('affix'));
							if(isNaN(fee)) fee=0;
							if(isNaN(affix)) affix=0;
							
							//运费计算
							var inputPrice=$('#PlaceOrderFrom input[name=order_shipping_price]'),
								inputPrice_ary={},
								shipPrice=0;
							inputPrice.val()!='[]' && (inputPrice_ary=$.evalJSON(inputPrice.val()));
							for(k in inputPrice_ary){
								shipPrice+=parseFloat(inputPrice_ary[k]);
							}
							
							//保险费计算
							var inputInsurance=$('#PlaceOrderFrom input[name=order_shipping_insurance]'),
								inputInsurance_ary={}, inputInsurancePrice_ary={},
								insurancePrice=0;
							inputInsurance.val()!='[]' && (inputInsurance_ary=$.evalJSON(inputInsurance.val()));
							inputInsurance.attr('price')!='[]' && (inputInsurancePrice_ary=$.evalJSON(inputInsurance.attr('price')));
							for(k in inputInsurance_ary){
								if(inputInsurance_ary[k]==1){
									insurancePrice+=parseFloat(inputInsurancePrice_ary[k]);
								}
							};
							
							if(userPrice && discountPrice){
								if(discountPrice>userPrice) userPrice=0;
								else discountPrice=0;
							}
							
							var totalAmount=amount-userPrice+shipPrice+insurancePrice-cutprice-discountPrice;	//最终价格
							var feePrice=totalAmount*(fee/100)+affix; //付款手续费
							
							if(userPrice){//会员价格
								$('#ot_user').text($('html').currencyFormat(userPrice.toFixed(2), ueeshop_config.currency));
								$('#memberSavings').show();
								$('#subtotalDiscount').hide();
								$('#PlaceOrderFrom').attr('userPrice', userPrice.toFixed(2));
							}else if(discountPrice){//全场满减价格
								$('#ot_subtotal_discount > strong').text($('html').currencyFormat(discountPrice.toFixed(2), ueeshop_config.currency));
								$('#memberSavings').hide();
								$('#subtotalDiscount').show();
								$('input[name=order_discount_price]').val(discountPrice);
							}else{//没有优惠
								$('#memberSavings, #subtotalDiscount').hide();
								$('#PlaceOrderFrom').attr('userPrice', 0);
								$('input[name=order_discount_price]').val(0);
							}
							$('#ot_fee').text($('html').currencyFormat(feePrice.toFixed(2), ueeshop_config.currency));
							$('#ot_coupon').text($('html').currencyFormat(cutprice.toFixed(2), ueeshop_config.currency)).show(200);
							$('#ot_total').text(totalAmount+feePrice.toFixed(2));
							//优惠券处理
							parseInt(data.msg.IsCoupon) && $('input[name=order_coupon_code]').val() && cart_obj.cart_init.ajax_get_coupon_info($('input[name=order_coupon_code]').val());
						}
					};
					$('.attr_edit_content').html('').parent().hide().parent().removeClass('cur');
				}, 'json');
			});
			
			//关闭页面
			$('.itemFrom tbody tr td.prList .attr_edit .cancel').on('click', function(){
				$(this).parents('.attr_edit_content').html('').parent().hide().parent().removeClass('cur');
			});
			$(document).on('click', function(e){
				if(!$(e.target).parents('.prAttr').hasClass('prAttr')){
					$('.attr_edit_content').html('').parent().hide().parent().removeClass('cur');
				}
			});
		}
		//-----------------------------------------------------更新购物车产品属性(end)-----------------------------------------------------
		
		
		$('.cartFrom .itemFrom').on('click', 'input[name=select_all]', function(){ //全选
			$('.cartFrom .itemFrom input[name=select]').not('.null').each(function(index, element) {
				$(element).get(0).checked=$('.cartFrom .itemFrom input[name=select_all]').get(0).checked?'checked':'';
            });
			modify_select_result();
		}).on('click', 'input[name=select]', function(){ //部分勾选
			if($('.cartFrom .itemFrom input[name=select]:checked').not('.null').length==$('.cartFrom .itemFrom input[name=select]').not('.null').length){
				$('.cartFrom .itemFrom input[name=select_all]').get(0).checked='checked';
            }else{
				$('.cartFrom .itemFrom input[name=select_all]').get(0).checked='';
			};
			modify_select_result();
		});
		
		$('.cartFrom .itemFrom input:checkbox').each(function(){ //重新默认全部勾选
			if($(this).is(':checked')===false) $(this).get(0).checked='checked';
		});
		
		function modify_select_result(){
			var num=price=0,
				cutprice=0,
				//cutprice=$('.cutprice_p').length?parseFloat($('.cutprice_p').attr('price')):0,
				cutArr=$.evalJSON($('input[name=DiscountPrice]').attr('data-value'));//全场满减优惠 列表
				cutType=parseInt($('input[name=DiscountPrice]').attr('data-type'));//全场满减优惠 类型
			$('.cartFrom .itemFrom input[name=select]:checked').each(function(){
				price+=parseFloat($(this).parents('tr').find('.prAmount p').attr('price'));
				num+=parseInt($(this).parents('tr').find("input[name=Qty\\[\\]]").val());
			});
			if(cutArr){//计算全场满减优惠
				for(k in cutArr){
					if(price<k) break;
					cutprice=cutType==1?cutArr[k][1]:(price*(100-cutArr[k][0])/100);
				}
			}
			price=price.toFixed(2);
			var punit=num>1?'s':'';
			$('.total_p').text(ueeshop_config.currency_symbols + $('html').currencyFormat(price, ueeshop_config.currency));
			$('.shopping_cart_total span').text(num+' item'+punit);
			$('.shopping_cart_total strong').text(ueeshop_config.currency_symbols + $('html').currencyFormat((price - cutprice).toFixed(2), ueeshop_config.currency));
			$('form[name=shopping_cart] input[name=CartProductPrice]').val(price);
			$('.cutprice_p').text(ueeshop_config.currency_symbols + $('html').currencyFormat(cutprice, ueeshop_config.currency));
			$('input[name=DiscountPrice]').val(cutprice);
			if(cutprice>0){
				$('.cutprice_box, .total_box').show();
			}else{
				$('.cutprice_box, .total_box').hide();
			}
		}
		
		$('a[name=continue_shopping]').click(function(){window.location.href='/';});/*/?a=products*/
		$('a.checkoutBtn').click(function(){
			$('a.checkoutBtn').removeClass('checkoutBtn').addClass('processing');
			if($('.cartFrom .itemFrom input[name=select_all]').get(0).checked && !$('.cartFrom .itemFrom input[name=select]').not(':checked').length){//全选
				setTimeout(function(){window.location.href='/cart/checkout.html'}, 1000);
				/*setTimeout(function(){
					$(this).loginOrVisitors('/cart/checkout.html', 1, function(){
						$('a.processing').removeClass('processing').addClass('checkoutBtn');
					});
				}, 1000);*/
			}else if($('.cartFrom .itemFrom input[name=select]:checked').length){//部分已选
				var CId='0';
				$('.cartFrom .itemFrom input[name=select]:checked').each(function(index, element){
					CId+='.'+$(element).val();
				});
				setTimeout(function(){window.location.href='/cart/checkout.html?CId='+CId}, 1000);
				/*setTimeout(function(){
					$(this).loginOrVisitors('/cart/checkout.html?CId='+CId, 1, function(){
						$('a.processing').removeClass('processing').addClass('checkoutBtn');
					});
				}, 1000);*/
			}else{
				alert('Please select at least one item!');
				$(this).removeClass('processing').addClass('checkoutBtn');
			}
		});
		
		/*paypal快捷支付部分(Start)*/
		$('button.paypal_checkout_button').click(function(){
			var CId='0';
			$(this).blur().attr('disabled', 'disabled');
			if(ueeshop_config['TouristsShopping']==0 && ueeshop_config['UserId']==0){ //游客状态
				$(this).loginOrVisitors('', 1, function(){
					$('button.paypal_checkout_button').removeAttr('disabled');
				}, 'global_obj.div_mask(1);$(\'#signin_module\').remove();cart_obj.cart_init.paypal_checkout_init();ueeshop_config[\'UserId\']=1;');
			}else{
				cart_obj.cart_init.paypal_checkout_init();
			}
			$(this).removeAttr('disabled');
			return false;
		});
		/*paypal快捷支付部分(end)*/
	},
	
	checkout_init:function(){
		$('.itemFrom tbody tr:last-child').find('td').addClass('last');
		$('.edit_shopping_cart a').click(function(){window.location.href='/cart/';});
		$('#paymentObj').delegate('select[name=_payment_method]', 'change', function(){
			var index=$('select[name=_payment_method] option:selected').index();
			$('#paymentObj .payment>ul>li').hide().eq(index).show();
			$('#PlaceOrderFrom input[name=order_payment_method_pid]').val($(this).val());
			var fee=parseFloat($('#paymentObj .payment>ul>li').eq(index).attr('fee'));
			var affix=parseFloat($('#paymentObj .payment>ul>li').eq(index).attr('affix'));
			if(isNaN(fee)) fee=0;
			if(isNaN(affix)) affix=0;
			
			//运费计算
			var inputPrice=$('#PlaceOrderFrom input[name=order_shipping_price]'),
				inputPrice_ary={},
				shipPrice=0;
			inputPrice.val()!='[]' && (inputPrice_ary=$.evalJSON(inputPrice.val()));
			for(k in inputPrice_ary){
				shipPrice+=parseFloat(inputPrice_ary[k]);
			}
			
			//保险费计算
			var inputInsurance=$('#PlaceOrderFrom input[name=order_shipping_insurance]'),
				inputInsurance_ary={}, inputInsurancePrice_ary={},
				insurancePrice=0;
			inputInsurance.val()!='[]' && (inputInsurance_ary=$.evalJSON(inputInsurance.val()));
			inputInsurance.attr('price')!='[]' && (inputInsurancePrice_ary=$.evalJSON(inputInsurance.attr('price')));
			for(k in inputInsurance_ary){
				if(inputInsurance_ary[k]==1){
					insurancePrice+=parseFloat(inputInsurancePrice_ary[k]);
				}
			};
			
			var amount=parseFloat($('#PlaceOrderFrom').attr('amountPrice'));	//产品总价
			var userPrice=parseFloat($('#PlaceOrderFrom').attr('userPrice'));	//会员优惠
			var discountPrice=parseFloat($('input[name=order_discount_price]').val());	//满额减价
			var cutprice=parseFloat($('input[name=order_coupon_code]').attr('cutprice'));	//折扣
			
			var totalAmount=amount-userPrice+shipPrice+insurancePrice-cutprice-discountPrice;	//最终价格
			var feePrice=totalAmount*(fee/100)+affix;	//付款手续费
			
			$('#ot_fee').text($('html').currencyFormat(feePrice.toFixed(2), ueeshop_config.currency)).attr({'fee':fee, 'affix':affix});
			$('#ot_total').text($('html').currencyFormat((totalAmount*(1+fee/100)+affix).toFixed(2), ueeshop_config.currency));
			
			if(fee>0){
				$('#serviceCharge').show();
			}else{
				$('#serviceCharge').hide();
			}
		});
		
		/*
		$('#paymentObj .payment_list').on("click", "span", function(){
			var $this=$(this),
				index=$this.index(),
				num=$this.attr("value");
			$this.addClass("selected").siblings().removeClass("selected");
			$('#paymentObj .payment>ul>li').hide().eq(index).show();
			$('#PlaceOrderFrom input[name=order_payment_method_pid]').val(num);
			var fee=parseFloat($('#paymentObj .payment>ul>li').eq(index).attr('fee'));
			var affix=parseFloat($('#paymentObj .payment>ul>li').eq(index).attr('affix'));
			if(isNaN(fee)) fee=0;
			if(isNaN(affix)) affix=0;
			
			var amount=parseFloat($('#PlaceOrderFrom').attr('amountPrice'));	//产品总价
			var userPrice=parseFloat($('#PlaceOrderFrom').attr('userPrice'));	//会员优惠
			var discountPrice=parseFloat($('input[name=order_discount_price]').val());	//满额减价
			var cutprice=parseFloat($('input[name=order_coupon_code]').attr('cutprice'));	//折扣
			var price=parseFloat($('input[name=order_shipping_price]').val());	//运费
			var insurance=parseFloat($('input[name=order_shipping_insurance]').attr('price'));	//运费保险
			
			var totalAmount=amount-userPrice+price+insurance-cutprice-discountPrice;	//最终价格
			var feePrice=totalAmount*(fee/100)+affix;	//付款手续费
			
			$('#ot_fee').text($('html').currencyFormat(feePrice.toFixed(2), ueeshop_config.currency)).attr({'fee':fee, 'affix':affix});
			$('#ot_total').text($('html').currencyFormat((totalAmount*(1+fee/100)+affix).toFixed(2), ueeshop_config.currency));
			
			if(fee>0){
				$('#serviceCharge').show();
			}else{
				$('#serviceCharge').hide();
			}
		});
		*/
		
		$('.delivery_ins').each(function(){	//弹出提示
			$('#main').tool_tips($(this), {position:'vertical', html:$(this).attr('content'), width:260});
		});
		
		/**** set shipping address start ****/
		$('#useAddress').text(lang_obj.cart.use_shipping_address);
		if(address_count>0){	//set style shipping address
			obj=$('#lib_address li:eq(0) input[name=shipping_address_id]');
			obj.attr('checked', 'checked').parent().addClass('cur');
			$('#addressForm').css('display', 'none');
			obj.val()>0 && $('input[name=order_shipping_address_aid]').val(obj.val());
			obj.attr('CId')>0 && $('input[name=order_shipping_address_cid]').val(obj.attr('CId'));
			cart_obj.get_shipping_method_from_country(obj.attr('CId'));
		}else{
			$('#cancelAddr').css('display', 'none');
			$('#lib_address li:eq(0)').css('display', 'none');
			$('#addressForm').css('display', 'block');
		}
		
		$('#lib_address li').delegate('input[name=shipping_address_id]', 'click', function(){
			var value=$(this).val();
			var cid=$('#address_'+value).attr('CId');
			$('#lib_address li').removeClass('cur');
			$(this).parent().addClass('cur');
			$('input[name=order_shipping_address_aid]').val(value);
			$('input[name=order_shipping_method_sid]').val('').next('input[name=order_shipping_method_type]').val('').next('input[name=order_shipping_price').val('0.00');
			$.post('/', "do_action=user.set_default_address&AId="+value, function(data){//set default shipping method
				if(cid!=$('input[name=order_shipping_address_cid]').val()){
					$('input[name=order_shipping_address_cid]').val(cid);
					cart_obj.get_shipping_method_from_country(cid);
				}
			}, 'json');
		});
		
		$('#addAddress').click(function(){
			user_obj.set_default_address(0);
			$('#lib_address>li').hide();
			$('#addressForm').slideDown(500);
		});
		$('.edit_address_info').click(function(){
			user_obj.set_default_address($(this).prev().prev().val());
			$('#lib_address>li').hide();
			$('#addressForm').slideDown(500);
		});
		$('#cancelAddr').click(function(){
			$('#lib_address>li').show(500);
			$('#addressForm').slideUp(500);
		});
		
		if(address_perfect){
			$('#lib_address li:eq(0) .edit_address_info').click();
			$('#cancelAddr').hide();
		}
		/**** set shipping address end ****/
		

		/**** not login set country end ****/
		if($('.editAddr input[name=typeAddr]').val()==1){
			$('table.tb-shippingAddr tbody tr:eq(0)').find('th').html('<span class="required">*</span><label>Email:</label>').css('padding-top', '16px').siblings('td').html('<input type="text" name="Email" maxlength="200" class="elmbBlur" /><p class="errorInfo"></p>').css('padding-top', '16px');
			user_obj.set_default_address(0);
			var CId=$('#country').find('option:selected').val();
			//alert(CId);
			cart_obj.get_shipping_method_from_country(CId);
		}
		
		$('#country_chzn').delegate('li.group-option', 'click', function(){
			var CId=$('#country').find('option:selected').val();
			cart_obj.get_shipping_method_from_country(CId);
		});

		$('#addressInfo').delegate('.edit_nologin_address_info', 'click', function(){
			$('input[name=order_shipping_address_aid]').val(-1);
			$('#addressInfo').slideUp(500);
			$('#addressForm').slideDown(500);
		});
		/**** not login set country end ****/
		
		
		/**** set shipping delivery start ****/
		$('#shippingObj .shipping li a.red').click(function(){
			if($('#arriveSlide').css('display')=='none'){
				$('#arriveSlide').slideDown(500);
			}else{
				$('#arriveSlide').slideUp(500);
			}
		});
		
		$('.shipping_method_list').delegate('li', 'click', function(){ //选择快递方式
			var obj=$(this).find('input:radio'),
				OvId=obj.parents('.list').parent().attr('data-id'),
				SId=obj.val(),
				type=obj.attr('ShippingType'),
				price=obj.attr('price'),
				insurance=obj.attr('insurance'),
				inputCId=$('#PlaceOrderFrom input[name=order_shipping_address_cid]'),
				inputSId=$('#PlaceOrderFrom input[name=order_shipping_method_sid]'),
				inputType=$('#PlaceOrderFrom input[name=order_shipping_method_type]'),
				inputPrice=$('#PlaceOrderFrom input[name=order_shipping_price]'),
				inputSId_ary={},inputType_ary={}, inputPrice_ary={};
			
			inputSId.val()!='[]' && (inputSId_ary=$.evalJSON(inputSId.val()));
			inputType.val()!='[]' && (inputType_ary=$.evalJSON(inputType.val()));
			inputPrice.val()!='[]' && (inputPrice_ary=$.evalJSON(inputPrice.val()));
			
			/*if(inputSId_ary['OvId_'+OvId]==SId && inputType_ary['OvId_'+OvId]==type && obj.attr('cid')==inputCId.val()){
				return false;
			}*/
			
			obj.parent().parent().siblings().find('input').removeAttr('checked');
			obj.attr('checked', 'checked');
			cart_obj.set_shipping_method(OvId, SId, price, type, insurance);
		});
		
		$('.shipping_insurance').click(function(){
			var v=$(this).attr('checked')=='checked'?1:0;
			insurance_check($(this), v);
		});
		
		function insurance_check(obj, v){//添加运费保险
			//运费计算
			var inputPrice=$('#PlaceOrderFrom input[name=order_shipping_price]'),
				inputPrice_ary={},
				shipPrice=0;
			inputPrice.val()!='[]' && (inputPrice_ary=$.evalJSON(inputPrice.val()));
			for(k in inputPrice_ary){
				shipPrice+=parseFloat(inputPrice_ary[k]);
			}
			
			//保险费计算
			var OvId=obj.parents('ul').attr('data-id'),
				insurance=v==1?parseFloat(obj.parents('ul').find('input:radio:checked').attr('insurance')):0;
				inputInsurance=$('#PlaceOrderFrom input[name=order_shipping_insurance]'),
				inputInsurance_ary={}, inputInsurancePrice_ary={},
				insurancePrice=0, insuranceShow=0;
			if(isNaN(insurance)) insurance=0;
			
			inputInsurance.val()!='[]' && (inputInsurance_ary=$.evalJSON(inputInsurance.val()));
			inputInsurance_ary['OvId_'+OvId]=v;
			inputInsurance.val($.toJSON(inputInsurance_ary));
			
			inputInsurance.attr('price')!='[]' && (inputInsurancePrice_ary=$.evalJSON(inputInsurance.attr('price')));
			inputInsurancePrice_ary['OvId_'+OvId]=insurance;
			inputInsurance.attr('price', $.toJSON(inputInsurancePrice_ary));
			
			for(k in inputInsurance_ary){
				if(inputInsurance_ary[k]==1){
					insurancePrice+=parseFloat(inputInsurancePrice_ary[k]);
					insuranceShow=1;
				}
			};
			cart_obj.show_shipping_insurance(insuranceShow);
			
			//价格显示
			var amount=parseFloat($('#PlaceOrderFrom').attr('amountPrice')); //产品总价
			var userPrice=parseFloat($('#PlaceOrderFrom').attr('userPrice')); //会员优惠
			var discountPrice=parseFloat($('input[name=order_discount_price]').val()); //满额减价
			var cutprice=parseFloat($('input[name=order_coupon_code]').attr('cutprice')); //折扣
			var fee=parseFloat($('#ot_fee').attr('fee'));
			var affix=parseFloat($('#ot_fee').attr('affix'));
			if(isNaN(fee)) fee=0;
			if(isNaN(affix)) affix=0;
			
			var shippingPrice=shipPrice+insurancePrice;	//运费+保险费
			var feePrice=parseFloat($('#ot_fee').text()); //附加费
			var totalAmount=amount-userPrice+shippingPrice-cutprice-discountPrice; //最终价格
			var feePrice=totalAmount*(fee/100)+affix; //付款手续费
			
			$('#ot_fee').text($('html').currencyFormat(feePrice.toFixed(2), ueeshop_config.currency));
			$('#ot_shipping').text($('html').currencyFormat(shipPrice.toFixed(2), ueeshop_config.currency));
			$('#ot_combine_shippnig_insurance').text($('html').currencyFormat(shippingPrice.toFixed(2), ueeshop_config.currency));
			$('#ot_total').text($('html').currencyFormat((totalAmount+feePrice).toFixed(2), ueeshop_config.currency));
			
			cart_obj.return_payment_list(totalAmount, feePrice)
		}
		
		/**** set shipping delivery end ****/		
		
		
		/**** set coupon code start ****/
		var couponCode=$('input[name=order_coupon_code]').val();
		if(couponCode!=''){
			cart_obj.cart_init.ajax_get_coupon_info(couponCode);
		}
		
		$('#new-cp').delegate('#to-use-coupon', 'click', function(){
			global_obj.div_mask();
			
			var coupon_html='<div id="cart_coupon_set">';
				coupon_html=coupon_html+'<div class="box_bg"></div><a class="noCtrTrack" id="lb-close">×</a>';
				coupon_html=coupon_html+'<div id="lb-wrapper"><form id="couponForm">';
					coupon_html=coupon_html+'<label>'+lang_obj.cart.coupon_title+': </label>';
					coupon_html=coupon_html+'<input type="text" class="text elmbBlur" name="couponCode" id="couponCode">';
					coupon_html=coupon_html+'<p id="couponValResult"><span class="invalid red" style="display: none;">'+lang_obj.cart.coupon_tips_th+'</span><span class="netError red" style="display: none;"></span></p>';
					coupon_html=coupon_html+'<p class="footRegion"><button class="btn btn-success" id="couponApply" type="submit">'+lang_obj.cart.apply+'</button></p>';
				coupon_html=coupon_html+'</form></div>';
			coupon_html=coupon_html+'</div>';
			
			$('body').prepend(coupon_html);
			$('#cart_coupon_set').css({left:$(window).width()/2-125});
			
			$('#cart_coupon_set').delegate('form#couponForm', 'submit', function(){
				$('#couponApply').attr('disabled', 'disabled').blur();
				cart_obj.cart_init.ajax_get_coupon_info($('#couponCode').val());
				$('#couponApply').removeAttr('disabled');
				return false;
			});
			
			/*
			$('#cart_coupon_set').delegate('#lb-close', 'click', function(){
				$('#cart_coupon_set').remove();
				global_obj.div_mask(1);
			});
			*/
			$('html').on('click', '#cart_coupon_set #lb-close, #div_mask', function(){
				$('#cart_coupon_set').remove();
				global_obj.div_mask(1);
			});
		});
		
		$('.new-coupon').delegate('#removeCoupon', 'click', function(){
			$('input[name=order_coupon_code]').val('').attr('cutprice', '0.00');
			
			//运费计算
			var inputPrice=$('#PlaceOrderFrom input[name=order_shipping_price]'),
				inputPrice_ary={},
				shipPrice=0;
			inputPrice.val()!='[]' && (inputPrice_ary=$.evalJSON(inputPrice.val()));
			for(k in inputPrice_ary){
				shipPrice+=parseFloat(inputPrice_ary[k]);
			}
			
			//保险费计算
			var inputInsurance=$('#PlaceOrderFrom input[name=order_shipping_insurance]'),
				inputInsurance_ary={}, inputInsurancePrice_ary={},
				insurancePrice=0;
			inputInsurance.val()!='[]' && (inputInsurance_ary=$.evalJSON(inputInsurance.val()));
			inputInsurance.attr('price')!='[]' && (inputInsurancePrice_ary=$.evalJSON(inputInsurance.attr('price')));
			for(k in inputInsurance_ary){
				if(inputInsurance_ary[k]==1){
					insurancePrice+=parseFloat(inputInsurancePrice_ary[k]);
				}
			};

			var amount=parseFloat($('#PlaceOrderFrom').attr('amountPrice')); //产品总价
			var userPrice=parseFloat($('#PlaceOrderFrom').attr('userPrice')); //会员优惠
			var discountPrice=parseFloat($('input[name=order_discount_price]').val()); //满额减价
			var cutprice=parseFloat($('input[name=order_coupon_code]').attr('cutprice')); //折扣
			var fee=parseFloat($('#ot_fee').attr('fee'));
			var affix=parseFloat($('#ot_fee').attr('affix'));
			if(isNaN(fee)) fee=0;
			if(isNaN(affix)) affix=0;
			
			var totalAmount=amount-userPrice+shipPrice+insurancePrice-cutprice-discountPrice; //最终价格
			var feePrice=totalAmount*(fee/100)+affix; //付款手续费
			
			$('#ot_fee').text($('html').currencyFormat(feePrice.toFixed(2), ueeshop_config.currency));
			$('#ot_coupon').text($('html').currencyFormat(cutprice.toFixed(2), ueeshop_config.currency)).hide();
			$('#ot_total').text($('html').currencyFormat((totalAmount+feePrice).toFixed(2), ueeshop_config.currency));
			
			cart_obj.return_payment_list(totalAmount, feePrice);
			
			$('#to-use-coupon').show(200);
			$('#new-coupon-valid>span').hide().children('strong:eq(0)').text('').siblings('span').text('').siblings('strong:eq(1)').text('');
			$('#removeCoupon').hide();

			$('#couponSavings').hide();
			
			$.post('/?do_action=cart.remove_coupon');
		});
		/**** set coupon code end ****/		


		/**** submit for place an order start ****/
		$('#orderFormSubmit').click(function(){
			var $obj=$(this);
			$obj.attr('id', 'orderFormProcessing');
			$obj.attr('disabled', 'disabled');
			
			if($('.itemFrom tr.null').length){//检查是否存在错误产品
				$('body,html').animate({scrollTop:$('.itemFrom').offset().top}, 500);
				global_obj.win_alert(lang_obj.cart.attribute_error);
				$obj.attr('id', 'orderFormSubmit');
				$obj.removeAttr('disabled');
				return false;
			}
			
			var addrId=$('input[name=order_shipping_address_aid]');
			var countryId=$('input[name=order_shipping_address_cid]');
			var ShipId=$('input[name=order_shipping_method_sid]');
			var PayId=$('input[name=order_payment_method_pid]');
			if(addrId.val()==-1 || countryId.val()==-1){//检查收货地址 && $('.editAddr input[name=typeAddr]').val()!=1  address_perfect || 
				$('body,html').animate({scrollTop:$('#addressObj').offset().top}, 500);
				global_obj.win_alert(lang_obj.cart.address_error);
				$obj.attr('id', 'orderFormSubmit');
				$obj.removeAttr('disabled');
				return false;
			}
			if(ShipId.val()==-1){//检查运费方式
				$('body,html').animate({scrollTop:$('#shippingObj').offset().top}, 500);
				global_obj.win_alert(lang_obj.cart.shipping_error);
				$obj.attr('id', 'orderFormSubmit');
				$obj.removeAttr('disabled');
				return false;
			}
			if(PayId.val()==-1){//检查运费方式
				$('body,html').animate({scrollTop:$('#paymentObj').offset().top}, 500);
				global_obj.win_alert(lang_obj.cart.payment_error);
				$obj.attr('id', 'orderFormSubmit');
				$obj.removeAttr('disabled');
				return false;
			}
			
			var Attr='';
			if($('.editAddr input[name=typeAddr]').val()==1){
				Attr=$('#PlaceOrderFrom').attr('nologin');
			}
			var Remark='';
			if($('.itemFrom input[name=Remark\\[\\]]').length){
				$('.itemFrom input[name=Remark\\[\\]]').each(function(){
					Remark+='&Remark_'+$(this).attr('proid')+'_'+$(this).attr('cid')+'='+$(this).val();
				});
			}
			setTimeout(function(){
				$.post('/?do_action=cart.placeorder', $('#PlaceOrderFrom').serialize()+Attr+Remark, function(data){
					if(data.ret==1){
						parseInt(ueeshop_config.FbPixelOpen)==1 && $('html').fbq_checkout();
						window.top.location.href='/cart/complete/'+data.msg.OId+'.html';
						/*if(data.msg.Method=='Paypal' && $('form[name=paypal_checkout_form]').length){ //Paypal支付方式
							//$('form[name=paypal_checkout_form]').attr('action', '/cart/complete/'+data.msg.OId+'.html');
							//$('#paypal_now_checkout_button').click();
							$('form[name=paypal_checkout_form]').animate({'action':'/cart/complete/'+data.msg.OId+'.html'}, 2000, function(){
								$('#paypal_now_checkout_button').click();
							});
						}else{
							window.top.location.href='/cart/complete/'+data.msg.OId+'.html';
						}*/
						return false;
					}else if(data.ret==-1){
						$('body,html').animate({scrollTop:$('#addressObj').offset().top}, 500);
						global_obj.win_alert(lang_obj.cart.address_error);
					}else if(data.ret==-2){
						$('body,html').animate({scrollTop:$('#shippingObj').offset().top}, 500);
						global_obj.win_alert(lang_obj.cart.shipping_error);
					}else if(data.ret==-3){
						$('body,html').animate({scrollTop:$('#paymentObj').offset().top}, 500);
						global_obj.win_alert(lang_obj.cart.payment_error);
					}else if(data.ret==-4){
						global_obj.win_alert(lang_obj.cart.product_error, function(){window.location.reload();});
					}else if(data.ret==-5){
						$('body,html').animate({scrollTop:$('.cartFrom').offset().top}, 500);
						global_obj.win_alert(lang_obj.cart.low_error+': '+data.msg);
					}else if(data.ret==-6){
						var arr=data.msg.split(',');
						for(i in arr){
							if(!$('.cartFrom tr[cid='+arr[i]+'] .stock_error').length){
								$('.cartFrom tr[cid='+arr[i]+'] .prList dl:eq(0) dd').append('<p class="error stock_error">'+lang_obj.cart.prod_stock_error+'</p>');
							}
						}
						$('body,html').animate({scrollTop:$('.cartFrom').offset().top}, 500);
						global_obj.win_alert(lang_obj.cart.stock_error);
					}
					$obj.attr('id', 'orderFormSubmit');
					$obj.removeAttr('disabled');
				}, 'json');
			}, 1000);
			return false;
		});
		/**** submit for place an order start ****/
		
	},
	
	checkout_no_login:function(){
		$.post('/?do_action=cart.set_no_login_address', $('.editAddr form').serialize(), function(data){
			if(data.ret==1){
				$('#PlaceOrderFrom').attr('nologin', data.msg.info);
				var html="<input type='radio' name='address' checked='checked' /> <strong>";
					html+=data.msg.v.FirstName+' '+data.msg.v.LastName+'</strong> (';
					html+=data.msg.v.AddressLine1+' '+(data.msg.v.AddressLine2 ? data.msg.v.AddressLine2+' ' : '');
					html+=data.msg.v.City+' '+(data.msg.v.StateName ? data.msg.v.StateName : data.msg.v.State)+' '+data.msg.v.ZipCode+' '+data.msg.v.Country+')';
					html+="<a href='javascript:;' class='edit_nologin_address_info'>"+lang_obj.global.edit+"</a>";
				
				$('#addressInfo').html(html).addClass('cur').slideDown(500);
				$('#addressForm').slideUp(500);
				$('input[name=order_shipping_address_aid]').val(0).next('input[name=order_shipping_address_cid]').val(data.msg.v.CId);
				cart_obj.get_shipping_method_from_country(data.msg.v.CId);
			}
		}, 'json');
	},
	
	complete_init:function(){
		$('#lib_cart .complete').delegate('a.payButton', 'click', function(){
			$('.payment_info').slideUp(300).siblings('.pay_form').slideDown(500);
		});
		
		$('.pay_form').delegate('#Cancel', 'click', function(){
			$('.payment_info').slideDown(300).siblings('.pay_form').slideUp(500);
		});
		
		$('#PaymentForm').delegate('input[name=SentMoney]', 'keypress keyup', function(){// keydown
			$(this).val(($(this).val()).replace(/[^\d.]/g, ''));
		});
		$('#PaymentForm').delegate('input[name=MTCNNumber]', 'keypress keyup', function(){// keydown
			$(this).val(($(this).val()).replace(/[^\d]/g, ''));
		});
		$('#PaymentForm').delegate('input,select', 'click', function(){
			$(this).removeAttr('style');
		});
		
		$('#PaymentForm').submit(function(){
			if(global_obj.check_form($(this).find('*[notnull]'), $(this).find('*[format]'))){return false;}
			$('#paySubmit').attr('disabled', 'disabled');
			
			$.post('/?do_action=cart.offline_payment', $(this).serialize(), function(data){
				if(data.ret==1){
					window.top.location.reload();
				}
			}, 'json');
			
			return false;
		});
		
		//提交编辑支付方式
		$('form[name=pay_edit_form]').submit(function(){ return false; });
		$('#pay_button').click(function(){
			var obj=$('form[name=pay_edit_form]');
			$(this).attr('disabled', 'disabled').blur();
			
			$.post('/?do_action=cart.orders_payment_update', obj.serialize(), function(data){
				window.top.location=$('form[name=pay_edit_form] input[name=BackLocation]').val();
			});
			return false;
		});
	},
	
	get_shipping_method_from_country:function(CId){	//change shipping method
		if(!CId){
			cart_obj.set_shipping_method(0, -1, 0, '', 0);
			return false;
		}
		var dataVal="CId="+CId;
		
		if($('form input[name=order_products_info]').val()){
			dataVal+=$('form input[name=shipping_method_where]').val();
			dataVal+='&Attr='+$('form input[name=shipping_method_where]').attr('attr');
		}
		if($('input[name=order_cid]').val()) dataVal+='&order_cid='+$('input[name=order_cid]').val();
		
		$('#submitCart').hide();
		
		$.post('/?do_action=cart.get_shipping_methods', dataVal, function(data){
			if(data.ret==1){
				/*
				var v=data.msg.info;
				var str='';
				for(i=0; i<v.length; i++){
					if(parseFloat(v[i].ShippingPrice)<0) continue;
					str = str + '<li name="'+v[i].Name.toUpperCase()+'">';
						str = str + '<span class="name">';
							str = str + '<input type="radio" name="_shipping_method" value="' + v[i].SId + '" price="'+ v[i].ShippingPrice + '" insurance="'+ v[i].InsurancePrice + '" ShippingType="' + v[i].type + '" cid="' + CId + '" />';
							str = str + '<label>' + v[i].Name + '</label>';
						str = str + '</span>';
						str = str + '<span title="' + v[i].Brief + '">' + v[i].Brief + '</span>';
						if(v[i].IsAPI==1 && v[i].Name.toUpperCase()=='DHL' && v[i].Shipping!=1000){
							if(v[i].ShippingPrice>0){
								str = str + '<span class="price waiting"></span>';
							}else str = str + '<span class="price">'+lang_obj.products.free_shipping+'</span>';
						}else{
							str = str + '<span class="price">' + (v[i].ShippingPrice>0 ? ueeshop_config.currency_symbols + $('html').currencyFormat(v[i].ShippingPrice, ueeshop_config.currency) : lang_obj.products.free_shipping) + '</span>';
						}
						str = str + '<div class="clear"></div>';
					str = str + '</li>';
					
					if(v[i].IsAPI==1 && v[i].Name.toUpperCase()=='DHL' && v[i].Shipping!=1000){
						$('#shipping_method_list li[name=DHL] input[name=_shipping_method]').attr('disabled', true);
						var AId=$('input[name=order_shipping_address_aid]').val();
						$.post('/?do_action=cart.ajax_get_dhl_info', 'AId='+AId, function(data){
							data=$.evalJSON(data);
							if(data.ret==1){
								$('#shipping_method_list li[name=DHL]>span.price').removeClass('waiting').text(ueeshop_config.currency_symbols + $('html').currencyFormat(data.msg, ueeshop_config.currency)).parent().find('input[name=_shipping_method]').attr({'price':data.msg, 'disabled':false});
								$('#PlaceOrderFrom').append('<input type="hidden" name="order_shipping_DHL" value="'+data.msg+'" />');
							}else{
								ShippingPrice=$('#shipping_method_list li[name=DHL] input').attr('price');
								$('#shipping_method_list li[name=DHL]>span.price').removeClass('waiting').text(ShippingPrice>0 ? ueeshop_config.currency_symbols + $('html').currencyFormat(ShippingPrice, ueeshop_config.currency) : lang_obj.products.free_shipping);
							}
						}, 'html');
					}
				}
				$('#shipping_method_list').html(str);
				
				if(str==''){
					cart_obj.set_shipping_method(-1, 0, '', 0);
				}else{
					$('#shipping_method_list li:eq(0)').click();
				}
				*/
				
				var rowObj, rowStr;
				for(OvId in data.msg.info){
					if(!$('#shippingObj ul[data-id='+OvId+']').length) continue;//没有这个海外仓选项
					rowStr='';
					for(i=0; i<data.msg.info[OvId].length; i++){
						rowObj=data.msg.info[OvId][i];
						if(parseFloat(rowObj.ShippingPrice)<0) continue;
						rowStr+='<li name="'+rowObj.Name.toUpperCase()+'">';
						rowStr+=	'<span class="name">';
						rowStr+=		'<input type="radio" name="_shipping_method['+OvId+']" value="'+rowObj.SId+'" price="'+ rowObj.ShippingPrice+'" insurance="'+rowObj.InsurancePrice+'" ShippingType="'+rowObj.type+'" cid="'+CId+'" />';
						rowStr+=		'<label>'+rowObj.Name+'</label>';
						rowStr+=	'</span>';
						rowStr+=	'<span title="'+rowObj.Brief+'">'+rowObj.Brief+'</span>';
						if(rowObj.IsAPI==1 && rowObj.Name.toUpperCase()=='DHL' && rowObj.Shipping!=1000){
							if(rowObj.ShippingPrice>0){
								rowStr+='<span class="price waiting"></span>';
							}else{
								rowStr+='<span class="price">'+lang_obj.products.free_shipping+'</span>';
							}
						}else{
							rowStr+='<span class="price">'+(rowObj.ShippingPrice>0 ? ueeshop_config.currency_symbols+$('html').currencyFormat(rowObj.ShippingPrice, ueeshop_config.currency) : lang_obj.products.free_shipping)+'</span>';
						}
						rowStr+=	'<div class="clear"></div>';
						rowStr+='</li>';
						
						if(rowObj.IsAPI==1 && rowObj.Name.toUpperCase()=='DHL' && rowObj.Shipping!=1000){
							$('#shipping_method_list li[name=DHL] input[name=_shipping_method]').attr('disabled', true);
							var AId=$('input[name=order_shipping_address_aid]').val();
							$.post('/?do_action=cart.ajax_get_dhl_info', 'AId='+AId, function(data){
								data=$.evalJSON(data);
								if(data.ret==1){
									$('#shipping_method_list li[name=DHL]>span.price').removeClass('waiting').text(ueeshop_config.currency_symbols+$('html').currencyFormat(data.msg, ueeshop_config.currency)).parent().find('input[name=_shipping_method]').attr({'price':data.msg, 'disabled':false});
									$('#PlaceOrderFrom').append('<input type="hidden" name="order_shipping_DHL" value="'+data.msg+'" />');
								}else{
									ShippingPrice=$('#shipping_method_list li[name=DHL] input').attr('price');
									$('#shipping_method_list li[name=DHL]>span.price').removeClass('waiting').text(ShippingPrice>0 ? ueeshop_config.currency_symbols+$('html').currencyFormat(ShippingPrice, ueeshop_config.currency) : lang_obj.products.free_shipping);
								}
							}, 'html');
						}
					}
					$('#shippingObj ul[data-id='+OvId+'] .shipping_method_list').html(rowStr);
					if(rowStr==''){
						$('#shippingObj ul[data-id='+OvId+'] .shipping_method_list').html(''); //清空内容
						cart_obj.set_shipping_method(0, -1, 0, '', 0);
					}else{
						$('#shippingObj ul[data-id='+OvId+'] .shipping_method_list li:eq(0)').click(); //默认点击第一个选项
					}
				}
			}else{
				$('.shipping_method_list').html(''); //清空内容
				cart_obj.set_shipping_method(0, -1, 0, '', 0);
			}
			$('#submitCart').show();
		}, 'json');
	},
	
	set_shipping_method:function(OvId, SId, price, type, insurance){ //选择运费
		if(SId==-1){
			global_obj.win_alert(lang_obj.cart.no_delivery);
		}
		
		//运费记录
		var inputSId=$('input[name=order_shipping_method_sid]'),
			inputType=$('input[name=order_shipping_method_type]'),
			inputPrice=$('input[name=order_shipping_price]'),
			inputInsurance=$('input[name=order_shipping_insurance]'),
			inputSId_ary={}, inputType_ary={}, inputPrice_ary={}, inputInsurance_ary={}, inputInsurancePrice_ary={};
		
		inputSId.val()!='[]' && (inputSId_ary=$.evalJSON(inputSId.val()));
		inputSId_ary['OvId_'+OvId]=SId;
		inputSId.val($.toJSON(inputSId_ary));

		inputType.val()!='[]' && (inputType_ary=$.evalJSON(inputType.val()));
		inputType_ary['OvId_'+OvId]=type;
		inputType.val($.toJSON(inputType_ary));
		
		inputPrice.val()!='[]' && (inputPrice_ary=$.evalJSON(inputPrice.val()));
		inputPrice_ary['OvId_'+OvId]=price;
		inputPrice.val($.toJSON(inputPrice_ary));
		
		var shipPice=0; //运费
		for(k in inputPrice_ary){
			shipPice+=parseFloat(inputPrice_ary[k]);
		}
		
		//保险费记录
		var obj=$('#shippingObj ul[data-id='+OvId+']'),
			v=obj.find('.shipping_insurance').attr('checked')=='checked'?1:0;
		obj.find('li.insurance dd.price em').text($('html').currencyFormat(insurance, ueeshop_config.currency));
		insurance=parseFloat(insurance);
		insurance=v==1?insurance:0;
		
		inputInsurance.val()!='[]' && (inputInsurance_ary=$.evalJSON(inputInsurance.val()));
		inputInsurance_ary['OvId_'+OvId]=v;
		inputInsurance.val($.toJSON(inputInsurance_ary));
		
		inputInsurance.attr('price')!='[]' && (inputInsurancePrice_ary=$.evalJSON(inputInsurance.attr('price')));
		inputInsurancePrice_ary['OvId_'+OvId]=insurance;
		inputInsurance.attr('price', $.toJSON(inputInsurancePrice_ary));
		
		var insurancePrice=0, insuranceShow=0;
		for(k in inputInsurance_ary){
			if(inputInsurance_ary[k]==1){
				insurancePrice+=parseFloat(inputInsurancePrice_ary[k]);
				insuranceShow=1;
			}
		};
		cart_obj.show_shipping_insurance(insuranceShow);
		
		//价格显示
		var amount=parseFloat($('#PlaceOrderFrom').attr('amountPrice')); //产品总价
		var userPrice=parseFloat($('#PlaceOrderFrom').attr('userPrice')); //会员优惠
		var discountPrice=parseFloat($('input[name=order_discount_price]').val()); //满额减价
		var cutprice=parseFloat($('input[name=order_coupon_code]').attr('cutprice')); //折扣
		var shippingPrice=shipPice+insurancePrice; //运费+保险费
		var fee=parseFloat($('#ot_fee').attr('fee'));
		var affix=parseFloat($('#ot_fee').attr('affix'));
		if(isNaN(fee)) fee=0;
		if(isNaN(affix)) affix=0;
		
		var totalAmount=amount-userPrice+shippingPrice-cutprice-discountPrice; //最终价格
		var feePrice=totalAmount*(fee/100)+affix; //付款手续费
		
		$('#ot_fee').text($('html').currencyFormat(feePrice.toFixed(2), ueeshop_config.currency));
		$('#ot_shipping').text($('html').currencyFormat(shipPice.toFixed(2), ueeshop_config.currency));
		$('#ot_combine_shippnig_insurance').text($('html').currencyFormat(shippingPrice.toFixed(2), ueeshop_config.currency));
		$('#ot_total').text($('html').currencyFormat((totalAmount+feePrice).toFixed(2), ueeshop_config.currency));
		
		cart_obj.return_payment_list(totalAmount, feePrice);
	},
	
	/**** function start ****/
	return_payment_list:function(totalAmount, feePrice){//判断支付下拉显示内容
		var minPrice=maxPrice=0;
		totalAmount=parseFloat((totalAmount-feePrice).toFixed(2));
		$('select[name=_payment_method] option:gt(0)').each(function(){
			minPrice=parseFloat($(this).attr('min'));
			maxPrice=parseFloat($(this).attr('max'));
			if((!minPrice && !maxPrice) || (maxPrice?(totalAmount>=minPrice && totalAmount<=maxPrice):(totalAmount>=minPrice))){
				$(this).css('display', 'block');
				$(this)[0].disabled=false;
			}else{
				$(this).css('display', 'none');
				$(this)[0].disabled=true;
				if($(this).parent().val()==$(this).attr('value')){
					$('select[name=_payment_method]').val(-1).change();
				}
			}
		});
	},
	/**** function end ****/
	show_shipping_insurance:function(v){
		if(v==1){
			$('#shippingInsuranceCombine').show().prev().hide();
		}else{
			$('#shippingInsuranceCombine').hide().prev().show();
		}
	}
	
};