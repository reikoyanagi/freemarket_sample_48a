
// $(window).load(function(){
//   setTimeout(function(){
//   },500)
// })

// 商品出品ボタン押す
$(function(){
  $('#edit_item_form').on('submit',function(e){
    e.preventDefault();
    var item_id = $('#default_images').data('itemid')
    console.log(item_id)
    var formdata = new FormData(this);

    $.ajax({
      url: "/items/" + item_id,
      type: "PATCH",
      data: formdata,
      dataType: "json",
      processData: false,
      contentType: false
    })



    .done(function(){
      console.log('成功')
    })

    .fail(function(XMLHttpRequest,textStatus,errorThrown){
      console.log('失敗')
       console.log(XMLHttpRequest.status);
      console.log(errorThrown);

    console.log(...formdata.entries())

      $(function(){
        // if ( !send_file_obj_edit[0]){
        //   $('.item_image-fail').removeClass('hide');
        // } else  {
        //   $('.item_image-fail').addClass('hide');
        // }


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

        if ( $('#item_delivery_attributes_shipping').val().length == 0 && $('#item_delivery_attributes_postage').val().length != 0){
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

        if ( $('#item_price').val() < 300 || $('#item_price').val() >= 9999999){
          $('.price-fail').removeClass('hide');
        } else {
          $('.price-fail').addClass('hide');
        }
        $(".sell_item_submit").prop("disabled", false);
      });
    });
  });
});

