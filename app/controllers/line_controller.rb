require 'line/bot'

class LineController < ApplicationController

  protect_from_forgery with: :null_session

	def client
	  @client ||= Line::Bot::Client.new { |config|
	    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
	    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
	  }
	end

	def callback
		# リクエストの内容を取得
	  body = request.body.read

	  # LINEからのリクエストが正しいかどうかの確認
	  signature = request.env['HTTP_X_LINE_SIGNATURE']
	  unless client.validate_signature(body, signature)
	    error 400 do 'Bad Request' end
	  end
	end
end
