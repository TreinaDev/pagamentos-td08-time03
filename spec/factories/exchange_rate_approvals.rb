FactoryBot.define do
  factory :exchange_rate_approval do
    association :admin
    association :exchange_rate
  end
end
