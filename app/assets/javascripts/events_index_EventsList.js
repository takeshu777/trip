$(function() {
  // ソートメニューの表示
  $(".event__container-sort-now").on('click', function(){
    $(".event__container-sort-dropdown-items").toggleClass("display-none");
  });

  // スライダー表示
    $('.top__container-banner-box').slick({
      autoplay:true,
      slidesToShow: 1,
      slidesToScroll: 1,
      arrows: true,
      fade: true,
      asNavFor: '.top__container-banner-campaign-list'
    });

    $('.top__container-banner-campaign-list').slick({
      autoplay:true,
      slidesToShow: 4,
      slidesToScroll: 1,
      asNavFor: '.top__container-banner-box',
      centerMode: true,
      focusOnSelect: true
    });

});
