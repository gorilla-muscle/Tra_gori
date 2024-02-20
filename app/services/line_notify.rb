require 'line/bot'

class LineNotify
  def initialize
    @client = Line::Bot::Client.new { |config|
      config.channel_id = Rails.application.credentials.line_bot[:channel_id]
      config.channel_secret = Rails.application.credentials.line_bot[:secret_id]
      config.channel_token = Rails.application.credentials.line_bot[:token_id]
    }
  end

  def send_notification(line_uid)
    message = {
      type: 'text',
      text: '今日の運動報告をまだしていないウホね...？急いで『トレゴリ』を開いて今日の運動を報告するウホ！'
    }
    response = @client.push_message(line_uid, message)
    return response
  end
end
