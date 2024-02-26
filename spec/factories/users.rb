FactoryBot.define do
  factory :user do
    name                  { "test" }
    email                 { "test@gmail.com" }
    password              { "A123456789" }
    password_confirmation { "A123456789" }
  end
end
