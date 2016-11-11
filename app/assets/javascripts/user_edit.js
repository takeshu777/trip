$(function () {

  /* avatar画像のプレビュー */
  $("#avatar_image").on('change', function(ev) {
    var reader = new FileReader();
    var target = ev.target;
    var file = target.files[0];
    reader.readAsDataURL(file);
    reader.addEventListener('load', function(reader){
      $(".useredit__container-form-avatar-imgbox-img").attr("src", reader.target.result );
    });
  });

  /* 項目切り替え */
  $(".useredit__container-menu-li-text").on('click', function(ev) {
    // 選択項目のハイライトリセット
    $(".useredit__container-menu-li").removeClass("useredit__container-menu-li-active");
    // 選択項目をハイライト
    $(this).parent().addClass("useredit__container-menu-li-active");

    // 表示項目のリセット
    $(".useredit__container-form-list").children().addClass("display-none");

    // 項目の表示
    if (ev.target.text == "プロフィール設定") {
      $(".useredit__container-form-list-profile").removeClass("display-none");
    } else if (ev.target.text == "個人情報") {
      $(".useredit__container-form-list-private").removeClass("display-none");
    } else if (ev.target.text == "アカウント設定") {
      $(".useredit__container-form-list-account").removeClass("display-none");
    } else if (ev.target.text == "パスワード設定") {
      $(".useredit__container-form-list-password").removeClass("display-none");
    }
  });
});
