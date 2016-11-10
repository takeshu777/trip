$(function () {

	/* modal のon/off切り替え */
	$(".eventnew__container-basic-dest-btn").on('click', function(e) {
		e.preventDefault();
  	$(".eventnew__modal").removeClass("display-none");
	});

	$(".eventnew__modal-close").on('click', function() {
     $(".eventnew__modal").addClass("display-none");
	});


	/* 行き先のインクリメンタルサーチ */
	$(".eventnew__modal-search-input").on('keyup', function(text) {
		var searchText = $(".eventnew__modal-search-input").val();
		$(".eventnew__modal-search-list").empty();
		if (searchText != "") {
			$.ajax({
				url: "/places",
				type: "get",
				datatype: "json",
				data: {
					"searchText" : searchText
				},
			}).done( function(data) {
				// jsonに変換
				var searchResult = JSON.parse(data);

				// 検索結果の表示
				$(searchResult).each( function(i, place) {
					var displayString = "<li><a>" + place.name + "</a></li>"
					$(".eventnew__modal-search-list").append(displayString);
				});

				// 選択した行き先をViewにセットして、モーダルを非表示に
				$(".eventnew__modal-search-list li a").on('click', function(ev) {
					$(".eventnew__container-basic-dest-text").html(ev.target.textContent);
					$("#js-dest-value").attr("value",ev.target.textContent);
					$(".eventnew__modal").addClass("display-none");

					// グーグルマップの再読み込み
					initMap();
				});

			}).fail( function( data, textStatus, jqXHR) {
					console.log("fail")
			});
		}
	});
});
