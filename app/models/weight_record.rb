class WeightRecord < ApplicationRecord
  belongs_to :user

  def self.weight_record_for_day(user)
    user.weight_records.find_by(created_at: Time.zone.now.all_day)
  end
end
