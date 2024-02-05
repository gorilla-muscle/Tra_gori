class WeightRecord < ApplicationRecord
  belongs_to :user

  def self.weight_record_for_day(user)
    user.weight_records.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end
end
