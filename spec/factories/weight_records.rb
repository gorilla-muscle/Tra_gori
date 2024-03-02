FactoryBot.define do
  factory :weight_record do
    weight { 70.5 }
    created_at { Time.zone.now }
  end
end
