FactoryBot.define do
  factory :user do
    name                  { "test" }
    email                 { "test@example.com" }
    password              { "A123456789" }
    password_confirmation { "A123456789" }

    trait :with_authentications do
      after(:create) do |user|
        FactoryBot.create(:authentication, user: user, provider: "google")
        FactoryBot.create(:authentication, user: user, provider: "line")
      end
    end
  end
end
