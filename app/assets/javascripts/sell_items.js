

$(function())


// 商品購入後のモーダルアップ
$(function(){
  $('#sell_items_form').on('submit',function(e){
    e.preventDefault();
    var formdata = new FormData(this);

    $.ajax({
      url: '/items',
      type: 'POST',
      data: formdata,
      dataType: 'json',
      processData: false,
      contentType: false
    })

    .done(function(){
      $('#after_sell').addClass('show');
      $('.overlay').addClass('show');
      $('html').addClass('modal-open');
    })

    .fail(function(){
      $(function(){
        if ( $('#item_images_attributes_0_item_image').val().length == 0){
          $('.item_image-fail').removeClass('hide');
        } else  {
          $('.item_image-fail').addClass('hide');
        }

        if ( $('#item_name').val().length == 0){
          $('.item_name-fail').removeClass('hide');
        } else {
          $('.item_name-fail').addClass('hide');
        }

        if ( $('#item_detail').val().length == 0){
          $('.detail-fail').removeClass('hide');
        } else {
          $('.detail-fail').addClass('hide');
        }

        if ( $('#item_condition').val().length == 0){
          $('.condition-fail').removeClass('hide');
        } else {
          $('.condition-fail').addClass('hide');
        }

        if ( $('#item_delivery_attributes_postage').val().length == 0){
          $('.postage-fail').removeClass('hide');
        } else {
          $('.postage-fail').addClass('hide');
        }

        if ( $('#item_delivery_attributes_shipping').val().length == 0){
          $('.shipping-fail').removeClass('hide');
        } else {
          $('.shipping-fail').addClass('hide');
        }

        if ( $('#item_delivery_attributes_region').val().length == 0){
          $('.region-fail').removeClass('hide');
        } else {
          $('.region-fail').addClass('hide');
        }

        if ( $('#item_delivery_attributes_shipping_date').val().length == 0){
          $('.shipping_date-fail').removeClass('hide');
        } else {
          $('.shipping_date-fail').addClass('hide');
        }

        if ( $('#item_price').val() < 300){
          $('.price-fail').removeClass('hide');
        } else {
          $('.price-fail').addClass('hide');
        }
        $(".sell_item_submit").prop("disabled", false);
      });
    });
  });
});

// 商品購入後の後に遷移するときにモーダルで追加した要素を消す
$(function(){
  $('.modal-btn').on('click', function(){
    $('#after_sell').removeClass('show');
    $('.overlay').removeClass('show');
    $('html').removeClass('modal-open');
    window.location.href = "/items/new";
  });
});
