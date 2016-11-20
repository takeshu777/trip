require 'line/bot'

class LineController < ApplicationController

  protect_from_forgery with: :null_session

  # メインプログラム
	def callback
		@log = Logger.new('log/hogehoge.log')

    # APIとの通信に必要な認証情報
    channel_access_token = ENV['LINE_ACCESS_TOKEN']
    channel_secret = ENV['LINE_CHANNEL_SECRET']

		#返信通知URL
    base_url = "https://api.line.me/v2/bot/message/reply"

    # リクエストURIを解析
    uri = URI.parse(base_url)

    # リクエスト生成
    http = Net::HTTP.new(uri.host, uri.port)

    # 通信はSSL(HTTPS)
    http.use_ssl = true

    # ポストで投げる
    req = Net::HTTP::Post.new(uri.path)

    # ヘッダーの定義
    req["Content-Type"] = "application/json; charser=UTF-8"
    req["Authorization"] = "Bearer " + channel_access_token

		#リクエストの内容を取得。
		body = request.body.read

		# LINE API送信元チェック
	  signature = request.env['HTTP_X_LINE_SIGNATURE']
	  unless client.validate_signature(body, signature)
	    error 400 do 'Bad Request' end
	  end

		#リクエストボディの取り出し
	  events = client.parse_events_from(body)

	  # bodyの出力。array型
		@log.info(events)

		# リクエスト情報の取り出し
	  events.each { |event|
	  	@log.info(event)
	  	@replyToken = event['replyToken']
	  	@callback_type = event['type']
	  	@postback_data = event['postback']['data']	if @callback_type == "postback"
	  	@message_data = event['message']	if @callback_type == "message"
	  }

	  #返信data（メッセージ部分）の作成
    @data_array = []

	  #リクエスト別のアクション定義
		if @callback_type == "follow" || @callback_type == "join"
			@data_array << follow_join_msg
			@data_array << default_msg
		elsif @callback_type == "postback"
			@data_array << view_postback_events(@postback_data)
			@data_array << default_msg
	  elsif @callback_type == "message"
			@data_array << view_search_events(@message_data)
			@data_array << default_msg
		end


    payload = { "replyToken" => @replyToken, "messages"  => @data_array }.to_json

    req.body = payload

    res = http.request(req)

    render :nothing => true, status: :ok
	end

	private

	def follow_join_msg
    data = {
	    "type": "text",
	    "text": "初めましてTripPieceです！楽しい企画が沢山あるよーん(^^)/"
    }
		return data
	end

	def default_msg
    data = {
		  "type": "template",
		  "altText": "this is a buttons template",
		  "template": {
		      "type": "buttons",
		      "text": "どんな企画があるか調べる場合はボタンを押すか、キーワード(エジプトとか)を打ってね。",
		      "actions": [
		          {
		            "type": "postback",
		            "label": "急げ！締め切り間近！",
		            "data": "action=view&name=near"
		          },
		          {
		            "type": "postback",
		            "label": "新着企画",
		            "data": "action=view&name=new"
		          },
		      ]
		  }
		}
		return data
	end

	def view_postback_events(postback_data)
	  @log.info(postback_data)

		if postback_data == 'action=view&name=near'
	    event_list = Event.apply_end_date_between(Time.now,"").order(:apply_end_date).open.limit(5)
		elsif postback_data == 'action=view&name=new'
			event_list = Event.order('id DESC').open.limit(5)
		end

    # carouselデータ配列の作成
    carousel_data_list = []

    event_list.each do |event|
      # メイン画像が未登録の場合はデフォルト画像をサムネイルurlにセット
      if event.image.present?
        carousel_data = {
          "thumbnailImageUrl": "#{event.image}",
          "title": "#{event.title}",
          "text": "[受付]#{event.apply_start_date}から#{event.apply_end_date}\n[概要]#{event.summary}",
          "actions": [
              {
                  "type": "uri",
                  "label": "View detail",
                  "uri": "https://training-not-trippiece.ienikki.com/events/#{event.id}"
              }
          ]
        }
      else
        carousel_data = {
          "thumbnailImageUrl": "https://training-not-trippiece.ienikki.com#{event.image}",
          "title": "#{event.title}",
          "text": "[受付]#{event.apply_start_date}から#{event.apply_end_date}\n[概要]#{event.summary}",
          "actions": [
              {
                  "type": "uri",
                  "label": "View detail",
                  "uri": "https://training-not-trippiece.ienikki.com/events/#{event.id}"
              }
          ]
        }
      end
      carousel_data_list << carousel_data
    end

    # 投げるデータの定義
    data = {
    "type": "template",
    "altText": "this is a carousel template",
    "template": {
        "type": "carousel",
        "columns": carousel_data_list
      }
    }
    return data
	end

	def view_search_events(message_data)
		@log.info(message_data)
    event_list = Event.text_like(message_data['text']).apply_end_date_between(Time.now,"").order(:apply_end_date).open.limit(5)

    # carouselデータ配列の作成
    carousel_data_list = []

    event_list.each do |event|
      # メイン画像が未登録の場合はデフォルト画像をサムネイルurlにセット
      if event.image.present?
        carousel_data = {
          "thumbnailImageUrl": "#{event.image}",
          "title": "#{event.title}",
          "text": "[受付]#{event.apply_start_date}から#{event.apply_end_date}\n[概要]#{event.summary}",
          "actions": [
              {
                  "type": "uri",
                  "label": "View detail",
                  "uri": "https://training-not-trippiece.ienikki.com/events/#{event.id}"
              }
          ]
        }
      else
        carousel_data = {
          "thumbnailImageUrl": "https://training-not-trippiece.ienikki.com#{event.image}",
          "title": "#{event.title}",
          "text": "[受付]#{event.apply_start_date}から#{event.apply_end_date}\n[概要]#{event.summary}",
          "actions": [
              {
                  "type": "uri",
                  "label": "View detail",
                  "uri": "https://training-not-trippiece.ienikki.com/events/#{event.id}"
              }
          ]
        }
      end
      carousel_data_list << carousel_data
    end

    # 投げるデータの定義
    if carousel_data_list.present?
	    data = {
	    "type": "template",
	    "altText": "this is a carousel template",
	    "template": {
	        "type": "carousel",
	        "columns": carousel_data_list
	      }
	    }
	  else
	    data = {
	    "type": "text",
	    "text": "ごめんなさい。ヒットしませんでした。検索ワードを変えてみてね。"
	    }
	  end
    return data
	end

	def client
	  @client ||= Line::Bot::Client.new { |config|
	    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
	    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
	  }
	end

end
