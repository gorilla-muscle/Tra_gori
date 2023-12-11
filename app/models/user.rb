class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).{5,}\z/ }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
end
