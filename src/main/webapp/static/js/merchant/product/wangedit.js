$(function () {
	editor1 = new wangEditor('editArea');

	//默认插入代码语言
	editor1.config.codeDefaultLang = 'html';
	// 上传图片（举例）
	editor1.config.uploadImgUrl = "/fileupload/upload";

	// 普通的自定义菜单,下列数组顺序依次对应页面显示从左到右的顺序
	editor1.config.menus = [
				'|',
				'bold',
				'underline',
				'italic',
				'strikethrough',
				'|',
				'quote',
				'alignleft',
				'aligncenter',
				'alignright',
				'|',
				'link',
				'unlink',
				'|',
				'img',
				'insertcode',
				'|',
				'undo',
				'redo'
			];
	editor1.create(); //初始化



	

});