FactoryBot.define do
  factory :debit do
    real_amount { 1 }
    rubi_amount { real_amount / exchange_rate.real }
    association :exchange_rate
    association :client
  end
end
