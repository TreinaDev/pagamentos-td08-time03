FactoryBot.define do
  factory :debit do
    real_amount { 12 }
    association :client
    association :exchange_rate
  end
end
