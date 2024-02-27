FactoryBot.define do
  factory :authentication do
    provider            { "test" }
    uid                 { "test123456789" }
  end
end
