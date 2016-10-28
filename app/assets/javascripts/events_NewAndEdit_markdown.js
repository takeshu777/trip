$(function() {
  /*Realtime markdown display*/
  $(".eventnew__container-details-body-text").on('keyup', function(ev){
    var inputText = $(".eventnew__container-details-body-text").val();
    var mdText = marked(inputText);
    $(".eventnew__container-details-markdown-prev").html(mdText);
  });

  /*insert headline */
  $(".eventnew__container-details-md-headline-text").on('click', function(){
    // 挿入文字列の設定
    var insertText = "## 見出し";
    // テキストエリアのobj取得
    var obj = $(".eventnew__container-details-body-text");
    // テキストエリアにフォーカスを当てる
    obj.focus();

    // テキストエリアのテキストデータの取得
    var originalText = obj.val();

    // カーソル位置の取得
    var p = obj.get(0).selectionStart;

    // カーソル位置と挿入文字列の長さの計算
    var np = p + insertText.length;

    // オリジナルテキストの最初から選択まで箇所までのテキストを挿入
    // 文字列の挿入
    // オリジナル＋挿入文字列の後に残りを挿入
    obj.val(originalText.substr(0,p) + insertText + originalText.substr(p));
    obj.get(0).setSelectionRange(np, np);
  });
});
