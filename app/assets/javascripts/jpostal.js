$(function () {
  $('#zip').jpostal({
    postcode : [
      '#zip'
    ],
    address : {
      '#session_prefecture_id'  : '%3',
      '#address'  : '%4%5'
    }
  });
});
