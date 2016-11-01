$(function() {
  // ユーザーメニュードロップダウンメニューの表示
  $("#js-navbar-dropdown").on('click', function(){
    $(".header-nav-menu-dropdown-ul").toggleClass("display-none");
  });

  // 検索条件の表示
  $(".header-nav-search-input").focus(function(){
    $(".header-nav-search-box").show();
    $(".header-nav-search-input").attr("placeholder","タイトルと本文から文字検索");
  });

  // 検索項目からフォーカスが外れたら、検索条件ウインドウを消す
  $(document).on('click touchend', function(event) {
    if (!$(event.target).closest('.header-nav-search').length) {
      $(".header-nav-search-box").hide();
      $(".header-nav-search-input").attr("placeholder","旅を探そう");
      // ここに処理;
    }
  });

  // 検索条件 start-dateカレンダーの表示
  $(".header-nav-search-date-start-input").datepicker({
    showButtonPanel: true,
    showOtherMonths: true,
    selectOtherMonths: true,
    showAnim: 'blind'
  });

  // 検索条件 end-dateカレンダーの表示
  $(".header-nav-search-date-end-input").datepicker({
    showButtonPanel: true,
    showOtherMonths: true,
    selectOtherMonths: true,
    showAnim: 'blind'
  });

});


