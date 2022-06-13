FactoryBot.define do
  factory :credit do
    real_amount { "9.99" }
    rubi_amount { "9.99" }
    exchange_rate { nil }
    client { nil }
    company { nil }
  end
end
