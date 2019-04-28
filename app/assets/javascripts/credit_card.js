document.addEventListener(
  "DOMContentLoaded", e => {
    Payjp.setPublicKey("pk_test_38a0bb351935345ed2755495");
    let btn = document.getElementById("token_submit");
    btn.addEventListener("click", e => {
      e.preventDefault();
      let card = {
        number: document.getElementById("card_number").value,
        cvc: document.getElementById("cvc").value,
        exp_month: document.getElementById("exp_month").value,
        exp_year: document.getElementById("exp_year").value
      };
      Payjp.createToken(card, (status, response) => {
        if (status === 200) { //成功した場合
          $("#card_number").removeAttr("name");
          $("#cvc").removeAttr("name");
          $("#exp_month").removeAttr("name");
          $("#exp_year").removeAttr("name");
          $("#card_token").append(
            $('<input type="hidden" name="payjp-token">').val(response.id)
          );
          document.inputForm.submit();
          alert("登録が完了しました");
        } else {
          alert("カード情報が正しくありません。");
          // document.getElementById('card_token').innerHTML = response.card.id;
        }
      });
    });
  },
  false
);
