$(function () {
  //event_lister
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
