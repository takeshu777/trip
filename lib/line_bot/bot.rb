module LineBot
  class Bot
    @@routes = Rails.application.routes.url_helpers
    def push
      #URLの定義
      base_url = "https://api.line.me/v2/bot/message/push"

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

      @event_list = Event.all.limit(5)

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

      payload = { "to" => ENV['LINE_TEST_ID'], "messages"  => data_array }.to_json

      req.body = payload

      res = http.request(req)

    end
  end
end