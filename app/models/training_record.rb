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
end
