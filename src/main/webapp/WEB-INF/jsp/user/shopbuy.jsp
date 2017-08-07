<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>无标题文档</title>
<!--购物数量加减-->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/num-alignment.js"></script>
<!--购物数量加减结束-->
<style>
<!--头部开始-->
.head{width:100%; height:100px; background:#993;}
.h_left{ height:100px; margin-left:50px; float:left;}
.h_left a{color:#000; font-size:16px; text-decoration:none;}
.h_left a:hover{color:#999; font-size:18px;}
.h_right{margin-right:150px; margin-top:-5px;  height:100px;}
.h_right ul{ float:right;}
.h_right ul li{ float:left; list-style:none; font-size:16px; margin-left:35px;}
.h_right ul li a{font-size:16px; text-decoration:none; color:#000;}
.h_right ul li a:hover{font-size:18px; color:#999;}
<!--搜索框开始-->
form { 
margin-top:20px; 
} 
#search_box {
margin-top:-42px;
margin-left:950px; 
width: 201px; 
height: 31px; 
background: url(http://files.jb51.net/demoimg/200912/bg_search_box.gif); 
} 
#search_box #s { 
float: left; 
padding: 0; 
margin: 6px 0 0 6px; 
border: 0; 
width: 159px; 
background: none; 
font-size: .8em; 
} 
#search_box #go { 
float: right; 
margin: 3px 4px 0 0; 
} 
<!--头部结束-->
<!--产品开始-->
<!--introduce开始-->
.detail{ width:100%;}
<!--产品结束-->
<!--分栏开始-->
.TTSlider{width:980px;margin: 30px auto}
.TTSlider li{list-style-type:none;float: left;}
.TTSlider li img{border: none;}
.TTSliderTitle{background: #FAFAFA;height: 63px;}
.TTSliderTitle ul{width: 980px;}
.TTSliderTitle li{width: 140px;height: 63px;position: relative;z-index: 3;left: 0;}
.TTSliderTitle li div{border-right: 1px solid #C3C5C7;border-top: 1px solid #C3C5C7;left: 0;right: 0;top: 0;bottom: 0;position: absolute;_width:139px;_height:62px}
.TTSliderTitle .cur div{border: 2px solid #C3C5C7;background: #fff;z-index: 3;border-bottom: none;bottom: -2px;_height:63px;_width:136px}
.TTSliderTitle .noneBorRight div{border-right: none;}
.TTSliderTitle li a{display: block;width: 50%;float: left;height: 100%;line-height: 61px;text-decoration: none;overflow: hidden;*width:49%;font-size: 12px; text-align:center; margin-left:30px;}
.TTSliderTitle li a img{height: 50px;margin: 6px;width: 50px}

.TTSliderPic{width:1050px;padding: 13px 33px;border: 2px solid #C3C5C7;position: relative;height: 180px;z-index: 1}
.TTSliderPicList{position: relative;width:100%;overflow: hidden;height:180px;}
.TTSliderPic ul{position: absolute;display: none;top:3px;left: 0}
.TTSliderPic ul.show{display: block;}
.TTSliderPic li img{width:150px }
.TTSliderPic li{width: 150px;padding: 0 14px;height: 180px;}
.TTSliderPic li a{display: block;height: 150px;overflow: hidden;}
.TTSliderPic li p{height: 30px;line-height: 30px;text-align: center;color: #ED0A0A}
<!--评论开始-->
.comment h2{ margin-left:50px;}
.comment table{ margin-left:100px; line-height:30px;}

<!--底部版权开始-->
.bottom{width:100%;clear:both;text-align:center;padding:10px 0;line-height:25px;color:#666;border-top:#ddd 1px solid;}
.footer{ background-color:#999; height:50px; margin-top:260px;}
.bottom a{margin-top:50px;color:#666; padding-top:30px; margin-left:15px;}
.bottom a:hover{color:#000;text-decoration:underline;}
.bottom p{ text-align:center; line-height:25px;}
</style>
</head>

<body>
<!--头部开始-->
<div class="head">
<div class="h_left"><p>欢迎光临***&nbsp;&nbsp; <a href="">退出</a></p></div>
<div class="h_right">
<ul>
<li><a href="">****</a></li>
<li><a href="">用户管理</a></li>
<li><a href="">购&nbsp;&nbsp;物&nbsp;&nbsp;车</a></li>
</ul>
</div>
</div>
<!--搜索框开始-->
<div id="search_box"> 
<form id="search_form" method="post" action="#"> 
<input type="text" id="s" value="Search" class="swap_value" /> 
<input type="image" src="http://files.jb51.net/demoimg/200912/btn_search_box.gif" width="27" height="24" id="go" alt="Search" title="Search" /> 
</form> 
</div> 
<!--头部结束-->
<hr style="width:100%;">
<!--产品开始-->
<!--滚动图开始-->
<div class="detail">
<div class="box-datouwang">	
	<div class="bigpic">
		<img class="bpic" src="img/good2.png"/>
		<div class="intro">
        <link href="css/datouwang.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/datouwang.js"></script>
		</div>
	</div>
	<div id="ztbox">
		<div class="spic">
			<div id="conter"> 	 
				<ul>
				  <li class="on"><img class="smallpic" src="img/good2.png"/><span class="snum"><b></b>/<strong></strong></span></li>
				  <li><img class="smallpic" src="img/good3.png" /><span class="snum"><b></b>/<strong></strong></span></li>
				  <li><img class="smallpic" src="img/good4.png"/><span class="snum"><b></b>/<strong></strong></span></li>
				</ul>	
			</div>
		</div>
	</div>
</div>
<!--商品介绍开始-->
<div class="introduce">
<table border="1" style="float:right; width:600px; height:300px; margin-top:-450px; margin-right:350px; text-align:center;">
  <tr>
    <td colspan="2"><h2 style=" margin-left:-185px;">赵丽颖同款长裙</h2></td>
    
  </tr>
  <tr>
    <td><h4>单&nbsp;&nbsp;价</h4></td>
    <td><h4 style="margin-left:-280px;">￥138.00</h4></td>
  </tr>
  <tr>
    <td><h4>购物数量</h4></td>
    <td><input id="5" data_step="1" data_min="1" data_max="100" data_digit="0" value="1" style="width:80px; padding-left:130px;"/></td>
  </tr>
  <tr>
    <td><input type="button" name="buy" value="购买"></td>
    <td><input type="button" name="add" value="加入购物车" style="margin-left:-280px;"></td>
  </tr>
</table>

</div>
</div>
<!--滚动图结束-->
<hr>
<!--产品结束-->
<!--分栏开始-->
<div class='TTSlider' id='TTSlider'>
		<div  class='TTSliderTitle'>
			 <ul>
			 	<li class='cur'><div><a href=''>栏目一</a></div></li>
			 	<li><div><a href=''>栏目二</a></div></li>
			 </ul>
		 </div>
		 <div class='TTSliderPic'>
		 	<div href='javascript:;' id='TTSliderPrevBtn' class='TTSliderPrevBtn'><a href='javascript:;'></a></div>
		 	<div href='javascript:;' id='TTSliderNextBtn' class='TTSliderNextBtn'><a href='javascript:;'></a></div>
		 	<div class='TTSliderPicList'>
			 	<ul class='show'>
			 		<li class='on'><a href=''><img src="img/good3.png"/></a><p>35元</p></li>
			 		<li><a href=''><img src="img/good2.png"/></a><p>35元</p></li>
			 		<li><a href=''><img src="img/good3.png"/></a><p>35元</p></li>
			 		<li><a href=''><img src="img/good4.png"/></a><p>35元</p></li>
			 		<li><a href=''><img src="img/good2.png"/></a><p>35元</p></li>
			 		<li><a href=''><img src="img/good3.png"/></a><p>35元</p></li>
			 		<li><a href=''><img src="img/good4.png"/></a><p>35元</p></li>
			 		<li><a href=''><img src="img/good2.png"/></a><p>35元</p></li>
			 	</ul>
			 	<ul>
			 		<li><a href=''><img src="img/good4.png"/></a><p>35元</p></li>
			 		<li><a href=''><img src="img/good2.png"/></a><p>35元</p></li>
			 		<li><a href=''><img src="img/good3.png"/></a><p>75元</p></li>
			 		<li><a href=''><img src="img/good4.png"/></a><p>75元</p></li>
			 		<li><a href=''><img src="img/good2.png"/></a><p>75元</p></li>
			 		<li><a href=''><img src="img/good3.png"/></a><p>35元</p></li>
			 		<li><a href=''><img src="img/good4.png"/></a><p>85元</p></li>
			 	</ul>
			 </div>
		 </div>
	</div>

<script>
window.onload=function()
{
var oTTSlider=document.getElementById('TTSlider');
var oTTSliderTitle=getByClass('TTSliderTitle',oTTSlider,'div')[0];
var aSubNav=oTTSliderTitle.getElementsByTagName('li');
var oTTSliderPrevBtn=document.getElementById('TTSliderPrevBtn');
var oTTSliderNextBtn=document.getElementById('TTSliderNextBtn');
var oTTSliderPicList=getByClass('TTSliderPicList',oTTSlider,'div')[0];
var aItem=oTTSliderPicList.getElementsByTagName('ul');
var len=aItem.length;
var showIndex=aItemImgWidth=iNow=0;
var aEle=[];
for(var i=0;i<len;i++)
{  
	var aItemImgs=aItem[i].getElementsByTagName('li');
	if(!aItemImgWidth)
	{
		aItemImgWidth=aItemImgs[0].offsetWidth;
	}
	aEle.push(aItemImgs);	//存入数组,考虑到有多个轮播,且每个轮播里面的图片个数可能一致.
	aSubNav[i].index=i;
	aSubNav[i].onmouseover=function()//切换
	{
		var index=showIndex=this.index;  
		for(var j=0;j<len;j++)
		{
			if(j!=index)
			{
					aItem[j].className='';
					aSubNav[j].className='';
			}
		}
		aSubNav[index-1] && (aSubNav[index-1].className='noneBorRight' );
		if(index>0)
		{
			(aSubNav[0].getElementsByTagName('div')[0].style.borderLeft='1px solid #C3C5C7');
		}
		else
		{
			aSubNav[0].getElementsByTagName('div')[0].style.borderLeft='2px solid #C3C5C7';
		}
		
		aSubNav[index].className='cur';
		aItem[index].className='show';
	}
}


for(var i=0;i<len;i++)
{
	var num=aEle[i].length;
	if(aItem[i].className=='show')
	{
		showIndex=i;
	}
	aItem[i].style.width=num*(aItemImgWidth)+'px'
}
oTTSliderNextBtn.onclick=function()
{
	var maxNum=aEle[showIndex].length-1;
	aItem[showIndex].insertBefore(aEle[showIndex][maxNum],aEle[showIndex][0]);
	aItem[showIndex].style.left=-aItemImgWidth+'px';
	doMove(aItem[showIndex],0);
}

oTTSliderPrevBtn.onclick=function()
{
	doMove(aItem[showIndex],-(aItemImgWidth),function(){
		aItem[showIndex].style.left=0;
		aItem[showIndex].appendChild(aEle[showIndex][0])
	});
}

function doMove(o,t,fn)
{
	clearInterval(o.timer);
	o.timer=setInterval(function(){
		var is= (t-getStyle(o,'left'))/8;
		is= is>0?Math.ceil(is):Math.floor(is);
		if(t==o.offsetLeft)
		{
			clearInterval(o.timer);
			(typeof fn==='function') && fn();
		}
		else
		{
			o.style.left=o.offsetLeft+is+'px';
		}

	},30)
}
function getStyle(o,a)
{
	return o.currentStyle ? parseFloat(o.currentStyle[a]) : parseFloat(getComputedStyle(o,false)[a]);
}
function getByClass(s,p,e)
{
	var reg=new RegExp('(\\b)'+s+'(\\b)');
	var aElement=(p||document).getElementsByTagName(e||'*');
	var aResult=[];
	for(var i=0;i<aElement.length;i++)
	{
		reg.test(aElement[i].className) && aResult.push(aElement[i]);
	}
	return aResult;
}
}
</script>
<hr>
<!--评论开始-->
<div class="comment">
<h2>评论</h2>
<table width="100%">
<tr>
<td>*****</td>
<td>#$%%%%%%%%%%%%</td>
<td>2017-9-28</td>
</tr>
<tr>
<td>***</td>
<td>$$$$$$$$$$$$$</td>
<td>2017-6-14</td>
</tr>
<tr>
<td>*</td>
<td>#############</td>
<td>2017-5-3</td>
</tr>
</table>
</div>
<!--版权开始-->
<div class="bottom">
<div class="footer">
<P>
<a href="#" rel="nofollow">关于我们</a> &nbsp;|<a href="#" rel="nofollow">联系我们</a>&nbsp;|<a href="#" rel="nofollow"><a href='http://www.veryhuo.com/z/falvapp/' target='_blank'><b>法律</b></a>声明</a>&nbsp;|<a href="#" rel="nofollow">网站地图</a>&nbsp;|<a target="_blank" href="#">版权声明</a>&nbsp;|<a href="#" rel="nofollow">帮助中心</a><br />
***商城 版权所有　© 2005-2020　京ICP备********号</P>
</div>
</div>
</body>
</html>
