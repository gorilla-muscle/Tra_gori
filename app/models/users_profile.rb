class UsersProfile < ApplicationRecord
  belongs_to :user

  validates :target_weight, numericality: { greater_than: 30, less_than: 150, allow_nil: true }
  validate :check_decimal_point

  private

  def check_decimal_point
    return if target_weight.blank?
    unless target_weight.to_s.match?(/\A\d+(\.\d)?\z/)
      errors.add(:target_weight, "は小数点第一位まで入力して下さい")
    end
  end
end
