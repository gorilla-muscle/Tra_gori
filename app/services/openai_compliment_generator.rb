require 'ruby/openai'

class OpenaiComplimentGenerator
  def self.generate_compliment(sport_content)
    client = OpenAI::Client.new
    prompt = "ユーザーが行った運動: #{sport_content}。ユーザーが行った運動に対して労いの言葉を「ウホ」口調で生成してください。"

    response = client.chat(
      parameters: {
        model: 'gpt-4',
        messages: [{ role: 'user', content: prompt }],
      }
    )

    response.dig('choices', 0, 'message', 'content')
  end
end
