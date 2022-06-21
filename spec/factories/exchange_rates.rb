FactoryBot.define do
  factory :exchange_rate do
    real { 10.00 }
    association :admin

    trait :approved do
      status { 'approved' }
    end
  end
end
