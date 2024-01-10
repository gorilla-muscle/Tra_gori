FactoryBot.define do
  factory :users_profile do
    user { nil }
    target_weight { 1.5 }
    line_notify_on { false }
  end
end
