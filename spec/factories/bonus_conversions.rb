FactoryBot.define do
  factory :bonus_conversion do
    start_date { '2022-06-23' }
    end_date { '2022-10-11' }
    bonus_percentage { '12.5' }
    deadline { 4 }
  end
end
