class TrainingRecord < ApplicationRecord
  belongs_to :user
  validates :sport_content, length: { maximum: 100 }

  def self.check_report?(user)
    last_report = user.training_records.order(start_time: :desc).first
    last_report && last_report.start_time.to_date == Date.today
  end

  def generate_openai_compliment
    OpenaiComplimentGenerator.generate_compliment(self.sport_content)
  end
end
