require 'ruby/openai'

class OpenaiComplimentGenerator
  # 仮想のOpenAIクライアントライブラリの例外クラスを定義
  class OpenAIError < StandardError; end

  def self.generate_compliment(sport_content)
    client = OpenAI::Client.new
    prompt = "私の今日の運動内容は『#{sport_content}』です。この運動に対して、語尾に「ウホ」を付けた労いの言葉を90文字以内で生成してください。"

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

    if response.success?
      response.dig('choices', 0, 'message', 'content')
    else
      handle_error(response)
    end
  end

  def self.handle_error(response)
    case response.status
    when 400
      raise OpenAIError, "リクエストが不正です。入力内容を確認してください。"
    when 401
      raise OpenAIError, "認証に失敗しました。開発元にお問い合わせ下さい。"
    when 403..404
      raise OpenAIError, "リクエスト先のページが存在しません。URLを確認して下さい。"
    when 408
      raise OpenAIError, "リクエストがタイムアウトしました。しばらくしてから再試行してください。"
    when 500..599
      raise OpenAIError, "サーバー側の問題が発生しました。しばらくしてから再試行してください。"
    else
      raise OpenAIError, "予期せぬエラーが発生しました。ステータスコード: #{response.status}"
    end
  end
end
