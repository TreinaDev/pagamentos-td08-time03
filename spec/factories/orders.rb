FactoryBot.define do
  factory :order do
    order_code { "MyString" }
    client { nil }
    transaction_total_value { "9.99" }
    exchange_rate { "9.99" }
  end
end
