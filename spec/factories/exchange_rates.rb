FactoryBot.define do
  factory :exchange_rate do
    real { 10.00 }
    association :admin
  end
end
