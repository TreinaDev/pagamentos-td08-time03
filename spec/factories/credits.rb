FactoryBot.define do
  factory :credit do
    real_amount { 10.00 }
    rubi_amount { 1.00 }
    association :exchange_rate
    association :client
    association :company
  end
end
