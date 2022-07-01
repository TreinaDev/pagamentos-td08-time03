FactoryBot.define do
  factory :debit do
    real_amount { 1 }
    rubi_amount { 1 }
    exchange_rate { nil }
    client { nil }
  end
end
