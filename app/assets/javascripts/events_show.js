$(function (){
  /*参加者一覧表示*/
  // 申込み者一覧ボタンクリックでモーダル表示
  $(".eventshow__container-tab-apply").on('click', function(){
    $(".eventshow__modal").toggleClass("display-none");
    $("body").toggleClass("positon_fixed");
  });

  // 閉じるボタンでモーダル非表示
  $(".eventshow__modal-close").on('click', function(){
    $(".eventshow__modal").toggleClass("display-none");
    $("body").toggleClass("positon_fixed");
  });

});
