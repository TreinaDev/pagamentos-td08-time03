FactoryBot.define do
  factory :credit do
    real_amount { 10.00 }
    rubi_amount { real_amount / exchange_rate.real }
    association :exchange_rate, status: 10  
    association :client
    association :company

    trait :approved do
      status { 'approved' }
    end
  end
end
