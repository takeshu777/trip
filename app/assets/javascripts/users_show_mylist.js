$(function () {
  $(".user__container-mylist-text").on('click', function(ev){
    $(".user__container-mylist-ul").children().removeClass("user__container-mylist-li-active");
    $(this).parent().addClass("user__container-mylist-li-active");
  });
});
