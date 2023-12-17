class Authentication < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
