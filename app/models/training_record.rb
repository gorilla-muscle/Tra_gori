class TrainingRecord < ApplicationRecord
  belongs_to :user
  validates :sport_content, presence: true, length: { maximum: 100 }

  def self.check_report?(user)
    last_report = user.training_records.order(start_time: :desc).first
    last_report && last_report.start_time.to_date == Time.zone.today
  end

  def generate_openai_compliment
    OpenaiComplimentGenerator.generate_compliment(sport_content)
  end

  def self.openai_response_handling(user, record_params)
    ActiveRecord::Base.transaction do
      record = user.training_records.build(record_params)
      record.save!
      bot_content = record.generate_openai_compliment
      record.update!(bot_content: bot_content)
      if user.training_records.count % 5 == 0
        user.increment_banana_count_bonus
      else
        user.increment_banana_count
      end
      record
    end
  rescue OpenaiComplimentGenerator::OpenAIError => e
    raise e
  rescue StandardError => e
    raise e, "保存に失敗しました。管理者にお問い合わせ下さい。"
  end
end
