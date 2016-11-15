$(function() {
  /* メイン画像のアップローダー */
  $("#js-event-image").on('change', function(ev) {
    var reader = new FileReader();
    var target = ev.target;
    var file = target.files[0];
    reader.readAsDataURL(file);
    reader.addEventListener('load', function(reader){
      $(".eventedit__container-img").css('background-image','url(' + reader.target.result + ')');
    });
  });

  /* 詳細項目でのajaxでの画像アップロード*/
  $("#js-form-file").on('change', function(){
    var $file = $(this);
    var formData = new FormData();
    formData.append( $file.attr('name'), $file.prop("files")[0] );
    $.ajax({
        url: "/events/" + $("#js-form-event_id").val() + "/details_images",
        type: "post",
        data: formData,
        processData: false,
        contentType: false,
    }).done(function( data, textStatus, jqXHR) {
      $("#js-form-file").val("");

      // markdown用jsの再読み込み
      eventsEditMarkdown();

      swal({
          title: "画像アップロード完了",
          type: "success",
          confirmButtonText: "閉じる",
          confirmButtonColor : "#fcb753;",
        });
    }).fail(function ( data, textStatus, jqXHR) {
      $("#js-form-file").val("");

      // markdown用jsの再読み込み
      eventsEditMarkdown();
      swal({
          title: "画像アップロード失敗",
          type: "error",
          confirmButtonText: "閉じる",
          confirmButtonColor : "#fcb753;"
        });
    });
  });
});
