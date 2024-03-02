FactoryBot.define do
  factory :training_record do
    sport_content { "TestSport" }
    start_time    { Time.zone.now }
  end
end
