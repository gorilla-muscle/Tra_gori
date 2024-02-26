class Illustration < ApplicationRecord
  has_many :users_illustrations, dependent: :destroy
  has_many :users, through: :users_illustrations
end
