require 'line/bot'

class LineController < ApplicationController

  protect_from_forgery with: :null_session

  # メインプログラム
	def callback
		@log = Logger.new('log/hogehoge.log')

		#リクエストの内容を取得。
		@body = request.body.read

		#リクエストボディの取り出し
	  @events = client.parse_events_from(body)

	  # bodyの出力。array型
		@log.info(events)

	  events.each { |event|
	  	@log.info(event)
	  	@replyToken = event['replyToken']
	  	@callback_type = event['type']
	  }

	  if @callback_type == message
			reply_near_apply_date
			@log.info("okay")
		end
	end

	private

	# 申込日が近い規格の表示
	def reply_near_apply_date

		#push通知用URL
    base_url = "https://api.line.me/v2/bot/message/reply"

    # APIとの通信に必要な認証情報
    channel_access_token = ENV['LINE_ACCESS_TOKEN']
    channel_secret = ENV['LINE_CHANNEL_SECRET']

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
    req["Authorization"] = "Bearer " + channel_access_token

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
