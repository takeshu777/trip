require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['ACCESS_KEY_ID_TRIP'],
    aws_secret_access_key: ENV['SECRET_ACCESS_KEY_TRIP'],
    region: 'ap-northeast-1',
  }

    case Rails.env
    when 'development'
        config.fog_directory  = 'trip01-development'
        config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/trip01-development'
    when 'production'
        config.fog_directory  = 'trip01-production'
        config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/trip01-production'
    end
end