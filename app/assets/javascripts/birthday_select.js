
$(function() {

  var current = new Date();

  var year_val = current.getFullYear();
  // プルダウン生成
  //年
  $('#year_pulldown').html('<select required name="session[birth_year]" required ><option value="">---</opution>');
  for (var i = year_val ; i > 1989 ;  i--) {
    $('#year_pulldown select').append('<option value="' + i + '">' + i + '</option>');
  }

  //月
  $('#month_pulldown').html('<select name="session[birth_month]" required ><option value="">--</opution>');
  for (var i = 1; i <= 12; i++) {
    $('#month_pulldown select').append('<option value="' + i + '">' + i + '</option>');
  }

  //日
  $('#day_pulldown').html('<select name="session[birth_day]" required ><option value="">--</opution>');
  for (var i = 1; i <= 31; i++) {
    $('#day_pulldown select').append('<option value="' + i + '">' + i + '</option>');
  }

});
