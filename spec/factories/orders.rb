FactoryBot.define do
  factory :order do
    order_code { '#AABBCCDDEEFFGGHHIIJJKKK' }
    transaction_total_value { 2.99 }
    rate_used { 10.00 }
    association :client

    trait :pending do
      status { 'pending' }
    end

    trait :approved do
      status { 'approved' }
    end
  end
end
