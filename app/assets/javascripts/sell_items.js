
$(function(){

  send_file_obj = {}
  var stock_index = []
  // プレビューの表示、表示、送信ファイル作成
  function make_preview(send_img_cnt,filelist){

    var num = stock_index.length
    $.each(filelist, function(i,file){
      stock_index.push(i)
      if (send_img_cnt > 0){
        var i = i + num
      }
      // キー、ハッシュでファイルを追加
      send_file_obj[i] = file
      // ファイルリーダーのインスタンスを作成する
      var reader = new FileReader();
      // ファイルの読み込みが成功した時の記述
      reader.onload =function(e){
        var url = e.target.result;
        // imageをデータとして取得する
        var preview = `<li id='preview' data-id='${i}' class="sell_upload_item">
                         <figure class='sell_upload_item__image'>
                           <img class="sell_upload_item__image__pic" src="${url}" />
                         </figure>
                         <div id = '#btns' class='sell_upload_item__buttons'>
                           <a class="sell_upload_item__buttons__btn edit-btn">編集</a>
                           <a id = 'remove_btn' class="sell_upload_item__buttons__btn remove-btn">削除</a>
                         </div>
                       </li>`

        var over_five = `<div id = "second_preview_div" class="form-group__sell_upload_items ">
                          <ul id = "second_preview_ul" class="uploaded_images"></ul>
                         </div>`

        var count_preview1 = $('#first_preview_ul').children().length
        var count_preview2 = $('#second_preview_ul').children().length
        var count_all = count_preview1 + count_preview2
        var less_width = $('#image_file_filed ').css('width',$('#image_file_filed').width()-128)

        if (count_all == 9){
          $('#second_preview_ul').append(preview);
          $('#image_file_filed ').css('display','none');
        }
        else if ( count_preview1 == 4){
          $('#first_preview_ul').append(preview);
          $('.sell_upload_items_container').append(over_five)
          $('#image_file_filed ').css('width','100%')
        }
        else if ( count_preview1 == 5){
          $('#second_preview_ul').append(preview);
          less_width
        }
        else{
          $('#first_preview_ul').append(preview);
          less_width
        }

      }
      reader.readAsDataURL(file);
    })

  }

  // プレビューの削除
  $(function(){
    $('.sell_upload_items_container').on('click','#remove_btn',function(){
      var preview = $(this).parent().parent()
      var i = preview.attr('data-id');
      preview.remove();
      delete send_file_obj[i]

      var count_preview1 = $('#first_preview_ul').children().length;
      var count_preview2 = $('#second_preview_ul').children().length;
      var count_all = count_preview1 + count_preview2
      var add_width =  $('#image_file_filed ').css('width',$('#image_file_filed').width()+128)

      if (count_preview1 == 4 && count_preview2 > 0){
        move_to_first_preview_ul = $('#second_preview_ul li:first').appendTo("#first_preview_ul")
      }

      console.log(send_file_obj)

      if (count_all == 9){
        $('#image_file_filed ').css('width',108);
        $('#image_file_filed ').css('display','block');
      }
      else if (count_preview1 == 4 && count_preview2 == 0){
        $('#image_file_filed ').css('width',108);
      }
      else if (count_preview1 == 4 && count_preview2 != 0){
        add_width
      }
      else {
        add_width
      }
    });

  });
// -------------------------------------------------------------------
  // 発火（ドラッグ）
  $('#image_file_filed').on('dragover',function(e){
    e.preventDefault();
  })

  $('#image_file_filed').on('drop',function(e){
    e.preventDefault();
    var image_filelist = e.originalEvent.dataTransfer.files;
    var file_count = image_filelist.length
    var send_img_cnt = Object.keys(send_file_obj).length

    if ( file_count != 0 && file_count + send_img_cnt <= 10){
      make_preview(send_img_cnt,image_filelist);
      $('.item_image').val('');
    }
  })

// --------------------------------------------------------
  // 発火（画像投稿）
  $('.item_image').change(function(){
    // 投稿された画像をfileオブジェクトで取得する
    var image_filelist = $('.item_image').prop('files');
    var file_count = image_filelist.length;
    var send_img_cnt = Object.keys(send_file_obj).length;

    if ( file_count != 0 && file_count + send_img_cnt <= 10){
      make_preview(send_img_cnt,image_filelist);
      $('.item_image').val('');
    }
  })

})
// -----------------------------------------------------------

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
    $.each(send_file_obj,function(index,file){
      formdata.append('item[images_attributes][0][item_image][]',file)
    })

    console.log(...formdata.entries())

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
        if ( !send_file_obj[0]){
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
  $('.go_to_show').on('click', function(){
    $('#after_sell').removeClass('show');
    $('.overlay').removeClass('show');
    $('html').removeClass('modal-open');
    window.location.href = "/items/new";
  });
});
