/**
	点击出现模态框
*/
$(".button").click(function(){
	//$("#modalDialog").removeClass("modalDialog").addClass("modalDialogshow");
	//$("#modal-overlay").removeClass("modal-overlay").addClass("modal-overlayshow");
	showModal("modal-overlay")
	
})

/**
	点击取消或者遮罩层,模态框关闭
*/
$("#modalDialog , #modalCancle").click(function(){
	$("#modal-overlay").removeClass("modal-overlayshow").addClass("modal-overlay");
	$("#modalDialog").removeClass("modalDialogshow").addClass("modalDialog");
	clearContent(modalDialog);
})

/**
	模态框显示(node:传入的模态框id)
*/
function showModal(node){
	$("#modalDialog").removeClass("modalDialog").addClass("modalDialogshow");
	$("#"+node).removeClass("modal-overlay").addClass("modal-overlayshow");
}

/**
	模态框隐藏(node:传入的模态框id)
*/
function hideModal(node){
	$("#"+node).removeClass("modal-overlayshow").addClass("modal-overlay");
	$("#modalDialog").removeClass("modalDialogshow").addClass("modalDialog");
}

var width = $("#modal-overlay").attr("width");
$(".modal-data").css("width",width);

function clearContent(node){
	$("#"+node .clearContent).each(
		function(i,n){
			console.log(n);
			n.val("");
		}
	);
}

