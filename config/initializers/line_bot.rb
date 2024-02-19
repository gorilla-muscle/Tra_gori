require 'line/bot'

LineBot = Line::Bot::Client.new { |config|
  config.channel_id = Rails.application.credentials.line_bot[:channel_id]
  config.channel_secret = Rails.application.credentials.line_bot[:secret_id]
  config.channel_token = Rails.application.credentials.line_bot[:token_id]
}
