
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
    var item_image_form = `<input class = "item_image" multiple="multiple" type="file" name="item[images_attributes][0][item_image][]" id="item_images_attributes_0_item_image" />`

    return item_image_form;
  }

  // プレビューのhtml
  function build_preview(i,url){
    var preview = `<li id='preview${i}' data-id='${i}' class="sell_upload_item">
                     <figure class='sell_upload_item__image'>
                       <img class="sell_upload_item__image__pic" src="${url}" />
                     </figure>
                     <div id = '#btns' class='sell_upload_item__buttons' index='${i}'>
                       <a class="sell_upload_item__buttons__btn">編集</a>
                       <a id = 'remove_btn' class="sell_upload_item__buttons__btn">削除</a>
                     </div>
                   </li>`

    return preview;
  }

  // プレビューの削除
  $(function(){
    $('.uploaded_images').on('click','#remove_btn',function(){
      var preview_box = $(this).parent().parent()
      var i = preview_box.attr('data-id');
      preview_box.remove();

    });
  });








  // プレビューの追加
  function add_preview(i,url){
    var preview = build_preview(i,url);
    $('.input_area').css('width','')
    $('.uploaded_images').append(preview);
  }

  // ファイルデータを格納
  images_file = [];
  // urlを格納
  images_stock = [];
  function get_images(){

    if ( $('.item_image').val().length != 0 ){
        // 投稿された画像をfileオブジェクトで取得する
        var images = $('.item_image').prop('files');

        if ( (index.length + images.length) <= 10){
          $.each(images, function(index,image){
            images_file.push(image)
            // ファイルリーダーのインスタンスを作成する
            var reader = new FileReader();
            // ファイルの読み込みが成功した時の記述
            reader.onload =function(e){
              var url = e.target.result;
              // imageをデータとして取得する
              images_stock.push(url);
            }

            reader.readAsDataURL(image);
          })
        }
    }
  }

  // 発火（画像投稿）
  var index = []
  $('.item_image').change(function(){
    $.when(
      get_images()
    )
    .done(
      setTimeout(function(){
        $.each(images_stock,function(i,url){
          if (($.inArray(i,index)) === -1 ){
            index.push(i)
            add_preview(i,url);
          }
        })
      },1000)
    )
    $(this).val('');
    console.log(images_file)

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


// 商品出品ボタン押す
$(function(){
  $('#sell_items_form').on('submit',function(e){
    e.preventDefault();
    var formdata = new FormData(this);
    $.each(images_file,function(index,image){
      formdata.append('item[images_attributes][0][item_image][]',image)
    })

    $.ajax({
      url: '/items',
      type: 'POST',
      data: formdata,
      dataType: 'json',
      processData: false,
      contentType: false
    })

    .done(function(){
      $('#after_sell').css('display', 'block');
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
