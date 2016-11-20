require 'line/bot'

class LineController < ApplicationController

  protect_from_forgery with: :null_session

  # メインプログラム
	def callback
		@log = Logger.new('log/hogehoge.log')

    # APIとの通信に必要な認証情報
    @channel_access_token = ENV['LINE_ACCESS_TOKEN']
    @channel_secret = ENV['LINE_CHANNEL_SECRET']

		#リクエストの内容を取得。
		body = request.body.read

		#リクエストボディの取り出し
	  events = client.parse_events_from(body)

	  # bodyの出力。array型
		@log.info(events)

		@log.info(postback.data)

	  events.each { |event|
	  	@log.info(event)
	  	@replyToken = event['replyToken']
	  	@callback_type = event['type']
	  }

	  case @callback_type
	  when "message"
			reply_near_apply_date
			@log.info("okay")
		when "follow", "join"
			reply_welcome
		end


	end

	private

	def reply_welcome
		#push通知用URL
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
    req["Authorization"] = "Bearer " + @channel_access_token

    # 投げるデータの定義
    data = {
	    "type": "text",
	    "text": "初めましてTripPieceです！楽しい企画が沢山あるよーん(^^)/"
    }

    data2 = {
		  "type": "template",
		  "altText": "this is a buttons template",
		  "template": {
		      "type": "buttons",
		      "text": "どんな企画があるか調べるね。ボタンを押すか、キーワードを打ってね。",
		      "actions": [
		          {
		            "type": "postback",
		            "label": "急げ！締め切り間近！",
		            "data": "action=view&name=near",
		            "text": "締め切り間近の企画を検索"
		          },
		          {
		            "type": "postback",
		            "label": "新着企画",
		            "data": "action=view&name=new",
		            "text": "新着企画を検索"
		          },
		      ]
		  }
		}

    data_array = [data,data2]

    payload = { "replyToken" => @replyToken, "messages"  => data_array }.to_json

    req.body = payload

    res = http.request(req)

    render :nothing => true, status: :ok
	end


	# 申込日が近い企画のpush
	def reply_near_apply_date

		#push通知用URL
    base_url = "https://api.line.me/v2/bot/message/reply"

    # リクエストURIを解析
    uri = URI.parse(base_url)

    # リクエスト生成
    http = Net::HTTP.new(uri.host, uri.port)

    # 通信はSSL(HTTPS)
    http.use_ssl = true

    # ポストで投げる
    req = Net::HTTP::Post.new(uri.path)

    @event_list = Event.apply_end_date_between(Time.now,"").order(:apply_end_date).open.limit(5)

    # ヘッダーの定義
    req["Content-Type"] = "application/json; charser=UTF-8"
    req["Authorization"] = "Bearer " + @channel_access_token

    # carouselデータ配列の作成
    @carousel_data_list = []

    @event_list.each do |event|
      # メイン画像が未登録の場合はデフォルト画像をサムネイルurlにセット
      if event.image.present?
        @carousel_data = {
          "thumbnailImageUrl": "#{event.image}",
          "title": "#{event.title}",
          "text": "#{event.summary}",
          "actions": [
              {
                  "type": "uri",
                  "label": "View detail",
                  "uri": "https://training-not-trippiece.ienikki.com/events/#{event.id}"
              }
          ]
        }
      else
        @carousel_data = {
          "thumbnailImageUrl": "https://training-not-trippiece.ienikki.com#{event.image}",
          "title": "#{event.title}",
          "text": "#{event.summary}",
          "actions": [
              {
                  "type": "uri",
                  "label": "View detail",
                  "uri": "https://training-not-trippiece.ienikki.com/events/#{event.id}"
              }
          ]
        }
      end
      @carousel_data_list << @carousel_data
    end

    # 投げるデータの定義
    data = {
    "type": "template",
    "altText": "this is a carousel template",
    "template": {
        "type": "carousel",
        "columns": @carousel_data_list
      }
    }

    data_array = [data]

    payload = { "replyToken" => @replyToken, "messages"  => data_array }.to_json

    req.body = payload

    res = http.request(req)

    render :nothing => true, status: :ok
	end

	def client
	  @client ||= Line::Bot::Client.new { |config|
	    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
	    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
	  }
	end

end
