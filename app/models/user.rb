class User < ApplicationRecord
  authenticates_with_sorcery!
  after_create :create_number_of_banana

  has_many :authentications, dependent: :destroy
  has_many :training_records, dependent: :destroy
  has_many :users_illustrations, dependent: :destroy
  has_many :illustrations, through: :users_illustrations
  has_many :weight_records, dependent: :destroy
  has_one :users_profile, dependent: :destroy
  has_one :number_of_banana, dependent: :destroy

  accepts_nested_attributes_for :authentications
  accepts_nested_attributes_for :users_profile

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :email, uniqueness: true, presence: true
  validates :password,
            length: { minimum: 5 },
            if: -> { new_record? || changes[:crypted_password] }
  validates :password,
            format: { with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).{5,}\z/ },
            if: -> { new_record? || changes[:crypted_password] }
  validates :password,
            confirmation: true,
            if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation,
            presence: true,
            if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  def google_check
    authentications.where(provider: "google").present?
  end

  def line_check
    authentications.where(provider: "line").present?
  end

  def increment_banana_count
    number_of_banana.count += 1
    number_of_banana.save!
  end

  def decrement_banana_count
    number_of_banana.count -= 5
    number_of_banana.save
  end

  private

  def create_number_of_banana
    create_number_of_banana!
  end
end
