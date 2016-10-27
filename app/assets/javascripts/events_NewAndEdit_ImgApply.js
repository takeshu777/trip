$(function() {
  $("#js-event-image").on('change', function(ev) {
    var reader = new FileReader();
    var target = ev.target;
    var file = target.files[0];
    reader.readAsDataURL(file);
    reader.addEventListener('load', function(reader){
      $(".eventnew__container-img").css('background-image','url(' + reader.target.result + ')');
    });
  });
});
