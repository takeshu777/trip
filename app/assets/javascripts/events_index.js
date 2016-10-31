$(function() {
  // ユーザープロフィール画面表示
  $("#js-navbar-dropdown").on('click', function(){
    var hasClass = $(".header-nav-menu-dropdown-ul").attr("class");
    if (hasClass.match(/display-none/)) {
      $(".header-nav-menu-dropdown-ul").removeClass("display-none");
    } else {
      $(".header-nav-menu-dropdown-ul").addClass("display-none");
    }
  });

  // 検索ボックス

});
