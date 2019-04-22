// 商品購入後のモーダルアップ
$(function(){
  $('#buy_items_form').on('submit',function(e){
    e.preventDefault();
    var formdata = new FormData(this);

    $.ajax({
      url: '/transactions',
      type: 'POST',
      data: formdata,
      dataType: 'json',
      processData: false,
      contentType: false
    })

    .done(function(){
      $('#after_buy').addClass('show');
      $('.overlay').addClass('show');
      $('html').addClass('modal-open');
    })

// 商品購入後の後に遷移するときにモーダルで追加した要素を消す
$(function(){
  $('.modal-btn').on('click', function(){
    $('#after_sell').removeClass('show');
    $('.overlay').removeClass('show');
    $('html').removeClass('modal-open');
    window.location.href = "/items/new";
  });
});
