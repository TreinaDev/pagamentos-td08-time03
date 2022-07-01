FactoryBot.define do
  factory :bonus_credit do
    status { 0 }
    expiration_date { 15.days.from_now.to_date }
    amount { 10 }
    association(:client)
  end
end
