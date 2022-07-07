FactoryBot.define do
  factory :admin do
    full_name { 'João' }
    cpf { '12345678901' }
    email { 'joao@userubis.com.br' }
    password { '123456' }

    trait :approved do
      activation { 10 }
    end

    trait :half_approved do
      activation { 5 }
    end

    trait :pending do
      activation { 0 }
    end
  end
end
