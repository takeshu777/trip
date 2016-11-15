function initMap() {

	// event show と editページでのみ実行する。
	if (document.getElementById("js-event-dest-map") != null) {

		// 住所(行き先)の取得
		var address01 = $("#js-event-dest-text").text();

		// 緯度(latitude)と経度(longitude)の取得
		var geocoder = new google.maps.Geocoder();

		geocoder.geocode({
			// 住所の検索
			"address": address01
		},function(results, status){
			// レスポンスjsonデータのコンソール出力
			console.log(results);
			console.log(status);

			// マップの表示
			if (status == google.maps.GeocoderStatus.OK) {

				//緯度と経度の取得
				var latLng = results[0].geometry.location;

				// マップの表示
			  var map = new google.maps.Map($("#js-event-dest-map")[0], {
			    center: latLng,
			    zoom: 8,
			    mapTypeId: google.maps.MapTypeId.ROADMAP
			  });

			  // マップへのマーカーの表示

				var markerImg = new google.maps.MarkerImage(
				    'http://' + location.host + '/fallback/map_pin.png',
				    new google.maps.Size(25, 25),
				    new google.maps.Point(0, 0),
				    new google.maps.Point(0, 0),
				    new google.maps.Size(25, 25)
				);

			  var marker = new google.maps.Marker({
					animation: google.maps.Animation.DROP,
		      position: latLng, // マーカーを立てる位置を指定
		      map: map, // マーカーを立てる地図を指定
					icon: markerImg
			  });

			  var infoWindow = new google.maps.InfoWindow({
			  	content: '<div class="google_infowindow_title">開催地' + address01 + '</div>'
			  });

		    marker.addListener('click', function() { // マーカーをクリックしたとき
		        infoWindow.open(map, marker); // 吹き出しの表示
		    });

			} else {
	      swal({
	          title: "住所から位置が取得できませんでした。",
	          type: "error",
	          confirmButtonText: "閉じる",
	          confirmButtonColor : "#fcb753;"
	        });
			}
		});
	}

	// event show と editページでのみ実行する。
	if (document.getElementById("js-event-search-map")) {
		// mapの表示
	  var map = new google.maps.Map($("#js-event-search-map")[0], {
	    zoom: 8,
	    mapTypeId: google.maps.MapTypeId.ROADMAP
	  });

	  // 表示するイベントのマーカーのポジションを調整するメソッド
		var bounds = new google.maps.LatLngBounds();

		// 表示イベントの名前とURLのタグ情報が入ったタグ情報の取得
		var eventTitleAndUrlList = $(".eventsearch__container-event-content-title");

		var eventTagList = $(".eventsearch__container-event-content-dest");

		var eventInfoList = [];

		$(eventTitleAndUrlList).each( function(i, event) {
			var tmpEventArray = [];
			tmpEventArray.push(event.text);
			tmpEventArray.push(event.href);
			tmpEventArray.push(event.dataset.dest);
			eventInfoList.push(tmpEventArray);
		});

		eventInfoList.map(function(event, i){
			var geocoder = new google.maps.Geocoder();
			var address = event[2];
			geocoder.geocode({
				// 住所の検索
				"address": address
			},function(results, status){


				// 位置情報が取得できたら処理を行う
				if (status == google.maps.GeocoderStatus.OK) {
					var latLng = results[0].geometry.location;

					// アイコンの設定
					var markerImg = new google.maps.MarkerImage(
				    'http://' + location.host + '/fallback/map_pin.png',
					    new google.maps.Size(25, 25),
					    new google.maps.Point(0, 0),
					    new google.maps.Point(0, 0),
					    new google.maps.Size(25, 25)
					);

					// マーキングの処理
				  var marker = new google.maps.Marker({
						animation: google.maps.Animation.DROP,
			      position: latLng, // マーカーを立てる位置を指定
			      map: map, // マーカーを立てる地図を指定
						icon: markerImg
				  });

				  // 情報ウインドウの表示設定
				  var infoWindow = new google.maps.InfoWindow({
				  	content:
				  	'<div class="google_infowindows_title">' + '<a href=' + event[1] + '>' + event[0] +' </a>' + '</div>'
				  });

				  // マーカーマウスオーバーで、情報ウインドウを表示
			    marker.addListener('mouseover', function() {
			        infoWindow.open(map, marker);
			    });

				  // // マーカーマウスアウトで、情報ウインドウをクローズ
			   //  marker.addListener('mouseout', function() {
			   //      infoWindow.close(map, marker);
			   //  });

			    // マーカーが地図の中に収まるように表示
			    bounds.extend(latLng);
        	map.fitBounds(bounds);

        	if(eventInfoList.length === 1) map.setZoom(7);

				} else {
		      swal({
		          title: event[0] + "の位置が取得できませんでした。",
		          type: "error",
		          confirmButtonText: "閉じる",
		          confirmButtonColor : "#fcb753;"
		      });
				}
			});
		});
	}
}