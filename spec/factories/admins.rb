FactoryBot.define do
  factory :admin do
    full_name { 'João' }
    cpf { '12345678901' }
    email { 'joao@userubis.com.br' }
    password { '123456' }
  end
end
