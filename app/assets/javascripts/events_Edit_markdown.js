$(function() {
  /*Realtime markdown display*/
  $(".eventedit__container-details-body-text").on('keyup', function(ev){
    var inputText = $(".eventedit__container-details-body-text").val();
    var mdText = marked(inputText);
    $(".eventedit__container-details-markdown-prev").html(mdText);
  });

  /*insert headline */
  $(".eventedit__container-details-md-headline-text").on('click', function(){
    // 挿入文字列の設定
    var insertText = "## 見出し";
    // テキストエリアのobj取得
    var obj = $(".eventedit__container-details-body-text");
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

  /*insert img string */
  $(".eventedit__container-details-md-file-btn-insert-text").on('click', function(){
    // 挿入画像情報の取得
    var imgObj = $(this).parent().parent().find("img");

    // URLの取得
    var imageUrl = imgObj.attr("src");

    // ファイル名の取得
    var imageName = imgObj.attr("value");

    // 挿入文字列の設定
    var insertText = "!" + "[" + imageName + "]" + "(" + imageUrl + ") \n";

    // テキストエリアのobj取得
    var obj = $(".eventedit__container-details-body-text");
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


  /*delete img string */
  $(".eventedit__container-details-md-file-btn-delete-text").on('click', function(){
    // 挿入画像情報の取得
    var imgObj = $(this).parent().parent().find("img");

    // URLの取得
    var imageUrl = imgObj.attr("src");

    // ファイル名の取得
    var imageName = imgObj.attr("value");

    // 挿入文字列の設定
    var insertText = "!" + "[" + imageName + "]" + "(" + imageUrl + ") \n";

    // テキストエリアのobj取得
    var originalText = $(".eventedit__container-details-body-text").val();

    var newText = originalText.replace(insertText, "");

    $(".eventedit__container-details-body-text").val(newText);

  });



});
