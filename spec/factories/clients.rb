FactoryBot.define do
  factory :client do
    registration_number { '123.456.789-00' }
    name { 'João Almeida' }
    association(:client_category)
  end
end
