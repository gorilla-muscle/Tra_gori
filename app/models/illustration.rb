class Illustration < ApplicationRecord
  has_many :users_illustrations
  has_many :users, through: :users_illustrations
end
