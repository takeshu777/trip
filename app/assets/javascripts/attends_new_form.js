$(function () {
  var inputComment = $(".attendnew__container-comment-textbox");

  // 文字が入力されれば、赤枠を削除
  $(".attendnew__container-comment-textbox").on('keyup', function(){
    if ( inputComment.val() != "") {
      inputComment.removeClass("inp-error");
    }
  });

  /*次ページボタン押下時のコメント欄の入力チェック*/
  $(".attendnew__container-step1-btn").on('click', function(){
    if ( inputComment.val() == "" ) {
      inputComment.addClass("inp-error");
    } else {
      $(".attendnew__container-step1").hide('drop',{direction:"right"},1000);
      $(".attendnew__container-step2").delay(1000).show('drop',{direction:"left"},1000);
    }
  });

  $(".attendnew__container-form-btn-back").on('click', function(){
    $(".attendnew__container-step2").hide('drop',{direction:"left"},1000);
    $(".attendnew__container-step1").delay(1000).show('drop',{direction:"right"},1000);
  });

});
