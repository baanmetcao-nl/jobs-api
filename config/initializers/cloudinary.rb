# frozen_string_literal: true

Cloudinary.config do |config|
  config.cloud_name = 'dpypxioff'
  config.api_key = '595678167483169'
  config.cloud_name = ENV.fetch('CLOUDINARY_CLOUD_NAME')
  config.api_key = ENV.fetch('CLOUDINARY_API_KEY')
  config.api_secret = ENV.fetch('CLOUDINARY_API_SECRET')
  config.secure = true
end
