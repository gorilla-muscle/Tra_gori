require 'ruby/openai'

class OpenaiComplimentGenerator
  # 仮想のOpenAIクライアントライブラリの例外クラスを定義
  class OpenAIError < StandardError; end

  def self.generate_compliment(sport_content)
    client = OpenAI::Client.new
    prompt = "私の今日の運動内容は『#{sport_content}』です。この運動に対して、語尾に「ウホ」を付けた労いの言葉を90文字以内で生成してください。"

    begin
      response = client.chat(
        parameters: {
          model: 'gpt-4',
          # 生成テキストの予測可能性を制御
          temperature: 0.6,
          # 生成テキストの多様性を制御
          top_p: 0.9,
          # 生成テキストの最大トークン数を制御
          max_tokens: 150,
          messages: [{ role: 'user', content: prompt }],
        }
      )
      # レスポンスが問題なく返ってきているかをチェック
      if response.key?('choices') && response['choices'].any?
        response.dig('choices', 0, 'message', 'content')
      else
        raise OpenAIError, "予期せぬレスポンス形式です。"
      end
    rescue Faraday::ClientError => e
      handle_faraday_error(e)
    rescue Faraday::ServerError => e
      handle_faraday_error(e)
    rescue Faraday::Error => e
      raise OpenAIError, "通信エラーが発生しました: #{e.message}"
    end
  end

  def self.handle_faraday_error(e)
    status = e.response[:status]
    case status
    when 400
      raise OpenAIError, "リクエストが不正です。入力内容を確認してください。"
    when 401
      raise OpenAIError, "認証に失敗しました。管理者にお問い合わせ下さい。"
    when 403..404
      raise OpenAIError, "リクエスト先のページが存在しません。URLを確認して下さい。"
    when 408
      raise OpenAIError, "リクエストがタイムアウトしました。しばらくしてから再試行してください。"
    when 429
      raise OpenAIError, "リクエストがレート/トークン上限を超えています。管理者にお問い合わせ下さい。"
    when 500..599
      raise OpenAIError, "サーバー側の問題が発生しました。しばらくしてから再試行してください。"
    else
      raise OpenAIError, "予期せぬエラーが発生しました。ステータスコード: #{status}"
    end
  end
end
