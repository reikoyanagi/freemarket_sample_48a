
$(function() {
 $('.slick').slick({
  dots: true,
  speed: 300,
      customPaging: function(slick,index) {
    // スライダーのインデックス番号に対応した画像のsrcを取得
    var targetImage = slick.$slides.eq(index).find('img').attr('src');
    // slick-dots > liの中に上記で取得した画像を設定
    return '<img src=" ' + targetImage + ' "/>';
    }
  });
});
