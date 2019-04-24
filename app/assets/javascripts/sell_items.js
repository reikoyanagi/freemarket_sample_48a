
// $(function(){
//   $('.item_image1').change(function(){
//     if ( $(this).val().length !=0 ){
//       console.log($(this).val())
//       var html = build_item_image_form()
//       $('.input_area').append(html);
//     }
//   })
// })

// Dropzone.autoDiscover = false

// new Dropzone '#upload-dropzone'
//   paramName: 'item[images_attributes][0][item_image][]'




// プレビューの表示
$(function(){

  // フォームのhtml
  function build_item_image_form(){
    var item_image_form = `<input class = "item_image + count" multiple="multiple" type="file" name="item[images_attributes][0][item_image][]" id="item_images_attributes_0_item_image" />`

    return item_image_form;
  }

  // プレビューのhtml
  function build_preview(url){
    var preview = `<li class='sell_upload_item'>
                     <figure class='sell_upload_item__image'>
                       <img class="sell_upload_item__image__pic" src="${url}" />
                     </figure>
                     <div class='sell_upload_item__buttons'>
                       <a class="sell_upload_item__buttons__btn" href="#">編集</a>
                       <a class="sell_upload_item__buttons__btn" href="#">削除</a>
                     </div>
                   </li>`

    return preview;
  }

  // プレビューを追加する
  $('.item_image').change(function(){
  if ( $(this).val().length != 0 ){

    // 投稿された画像をfileオブジェクトで取得する
    var image = $(this).prop('files')[0];

    // ファイルリーダーのインスタンスを作成する
    var reader = new FileReader();

    // ファイルの読み込みが成功した時の記述
    reader.onload =function(e){
      var url = e.target.result;

      // プレビューを表示する
      var preview = build_preview(url);
      $('.uploaded_images').append(preview)
    }

    // imageをデータとして取得する
    reader.readAsDataURL(image);

    $('.input_area').css('width','491px')
    }
  })

})





























// 配送料が入力されると配送方法を表示させる
$(function(){
  $('#item_delivery_attributes_postage').change(function(){
    var postage = $('#item_delivery_attributes_postage').val();
    if ( postage.length != 0){
      $('.how_shipping').removeClass('hide');
    } else {
      $('.how_shipping').addClass('hide');
    }
  })
});

// 手数料の計算
$(function(){
  $('#item_price').keyup(function(){
    var price = $(this).val();

    if ( price >= 300 ){
      var commission = Math.ceil(price * 0.1) ;
      var profit = price - commission
      $('.default-fee').text('¥' + commission);
      $('.profit_price').text('¥' + profit);
    } else{
      $('.default-fee').text('-');
      $('.profit_price').text('-');
    }
  });
});


// 商品購入後のモーダルアップ
$(function(){
  $('#sell_items_form').on('submit',function(e){
    e.preventDefault();
    var formdata = new FormData(this);

    console.log(formdata)
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

// 商品購入後の後に遷移するときにモーダルで追加した要素を消す
$(function(){
  $('.modal-btn').on('click', function(){
    $('#after_sell').removeClass('show');
    $('.overlay').removeClass('show');
    $('html').removeClass('modal-open');
    window.location.href = "/items/new";
  });
});
