var ctx = 'http://localhost:8888';


/*模态框关闭时候清空*/
$('body').on('hidden.bs.modal', '.modal', function() {
  //清空模态框
  $(this).find('form').get(0).reset();
  $(this).find('textarea').val('')
  //清空错误消息
  $(this).find('.tips').text('');
  //清空隐藏域的值
  $(this).find('input[type="hidden"]').val('');
})


//input选中时候清空错误信息
$(document).on('focus', 'input', function() {
    $(this).nextAll('.tips').text('');
  })
//textarea选中时候清空错误消息
$(document).on('focus', 'textarea', function() {
  $(this).nextAll('.tips').text('');
})