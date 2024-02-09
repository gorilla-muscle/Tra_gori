require 'ruby/openai'

class OpenaiComplimentGenerator
  def self.generate_compliment(sport_content)
    client = OpenAI::Client.new
    prompt = "私の今日の運動内容は『#{sport_content}』です。この運動に対してゴリラ口調で労いの言葉を90文字以内で生成してください。"

    response = client.chat(
      parameters: {
        model: 'gpt-4',
        # 生成テキストの予測可能性を制御
        temperature: 0.5,
        # 生成テキストの多様性を制御
        top_p: 0.8,
        # 生成テキストの最大トークン数を制御
        max_tokens: 150,
        messages: [{ role: 'user', content: prompt }],
      }
    )

    response.dig('choices', 0, 'message', 'content')
  end
end
