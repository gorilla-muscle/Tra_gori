class Authentication < ApplicationRecord
  belongs_to :user

  validates :provider, uniqueness: { scope: :uid }
end
