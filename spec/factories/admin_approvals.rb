FactoryBot.define do
  factory :admin_approval do
    association(:admin)
    super_admin_email { 'joao@userubis.com.br' }
  end
end
