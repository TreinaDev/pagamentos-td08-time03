FactoryBot.define do
  factory :bonus_conversion do
    start_date { 5.days.ago.to_date }
    end_date { 10.days.from_now.to_date }
    bonus_percentage { 15 }
    deadline { 4 }
    association(:client_category)
  end
end
