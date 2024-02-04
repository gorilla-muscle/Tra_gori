class UsersProfile < ApplicationRecord
  belongs_to :user

  validates :target_weight, numericality: { greater_than: 30, less_than: 150, allow_nil: true }
end
