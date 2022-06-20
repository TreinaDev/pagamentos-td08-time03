FactoryBot.define do
  factory :approval do
    association(:admin)
    super_admin_email { "joao@userubis.com.br" }
  end
end
