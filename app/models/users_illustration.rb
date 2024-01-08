class UsersIllustration < ApplicationRecord
  belongs_to :user
  belongs_to :illustration

  validates :user_id, uniqueness: { scope: :illustration_id }
end
