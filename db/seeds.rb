# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# Examples:
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts('### Criando Admins')
Admin.create!(full_name: 'Maria', cpf: '12344444901', email: 'maria@userubis.com.br', password: '123456')
Admin.create!(full_name: 'Gabriel', cpf: '10123478901', email: 'gabriel@userubis.com.br', password: '123456')
Admin.create!(full_name: 'Mateus Cézar', cpf: '99023478901', email: 'mateus@userubis.com.br', password: '123456')
Admin.create!(full_name: 'Fábio Júnior', cpf: '01211278901', email: 'fabiojr@userubis.com.br', password: '123456')
Admin.create!(full_name: 'Márcia', cpf: '19122228921', email: 'marcia@userubis.com.br', password: '123456')
Admin.create!(full_name: 'Márcio', cpf: '29133378921', email: 'marcio@userubis.com.br', password: '123456')
Admin.create!(full_name: 'Agatha', cpf: '39116478921', email: 'agatha@userubis.com.br', password: '123456')
Admin.create!(full_name: 'Vlad', cpf: '49141478921', email: 'vlad@userubis.com.br', password: '123456')
Admin.create!(full_name: 'Júlio', cpf: '95145478921', email: 'julio@userubis.com.br', password: '123456')

puts('### Criando Aprovações de admin')
Admin.find(1).approved!
Admin.find(2).approved!
AdminApproval.create!(super_admin_email: 'maria@userubis.com.br', admin: Admin.find(3))
AdminApproval.create!(super_admin_email: 'gabriel@userubis.com.br', admin: Admin.find(3))
AdminApproval.create!(super_admin_email: 'maria@userubis.com.br', admin: Admin.find(4))
AdminApproval.create!(super_admin_email: 'gabriel@userubis.com.br', admin: Admin.find(4))
AdminApproval.create!(super_admin_email: 'maria@userubis.com.br', admin: Admin.find(5))
AdminApproval.create!(super_admin_email: 'gabriel@userubis.com.br', admin: Admin.find(6))

puts('### Criando Taxas de Câmbio')
ExchangeRate.create!(real: 29.9, admin: Admin.find(4))
ExchangeRate.create!(real: 31.9, admin: Admin.find(4))
ExchangeRate.create!(real: 32.9, admin: Admin.find(3))

puts('### Criando Aprovação de Taxa de Câmbio')
ExchangeRateApproval.create!(admin: Admin.find(4), exchange_rate: ExchangeRate.find(1))
ExchangeRateApproval.create!(admin: Admin.find(3), exchange_rate: ExchangeRate.find(1))
ExchangeRateApproval.create!(admin: Admin.find(4), exchange_rate: ExchangeRate.find(2))
ExchangeRateApproval.create!(admin: Admin.find(3), exchange_rate: ExchangeRate.find(2))

puts('### Criando limite de crédito diário')
DailyCreditLimit.create!(value: 1_000)

puts('### Criando Categoria de Clientes')
ClientCategory.create!(name: 'BASIC', discount: 5)
ClientCategory.create!(name: 'PREMIUM', discount: 20)

puts('### Criando Clientes')
Client.create!(name: 'João Almeida', registration_number: '123.456.789-00')
Client.create!(name: 'Erika Campos', registration_number: '987.654.321-01')
Client.create!(name: 'Luana Sales', registration_number: '555.851.100-76')
Client.create!(name: 'Apple inc.', registration_number: '99.521.666/0001-98')

puts('### Criando Empresas Fornecedoras de Crédito')
Company.create!(corporate_name: 'Renner', registration_number: '12.345.678/0009-10')
Company.create!(corporate_name: 'Americanas S.A.', registration_number: '61.268.816/0001-99')
Company.create!(corporate_name: 'Amazon', registration_number: '86.121.752/0001-26')

puts('### Criando Créditos de Clientes ###')
Credit.create!(real_amount: 100, exchange_rate: ExchangeRate.find(1), rubi_amount: 100 / ExchangeRate.find(1).real, company: Company.find(1), client: Client.find(1), created_at: DateTime.now.days_ago(2))
Credit.create!(real_amount: 200, exchange_rate: ExchangeRate.find(1), rubi_amount: 200 / ExchangeRate.find(1).real, company: Company.find(2), client: Client.find(1), created_at: DateTime.now.days_ago(2))
Credit.create!(real_amount: 300, exchange_rate: ExchangeRate.find(1), rubi_amount: 300 / ExchangeRate.find(1).real, company: Company.find(3), client: Client.find(1), created_at: DateTime.now.days_ago(2))
Credit.create!(real_amount: 150, exchange_rate: ExchangeRate.find(2), rubi_amount: 150 / ExchangeRate.find(2).real, company: Company.find(1), client: Client.find(1), created_at: DateTime.now.yesterday)
Credit.create!(real_amount: 250, exchange_rate: ExchangeRate.find(2), rubi_amount: 250 / ExchangeRate.find(2).real, company: Company.find(2), client: Client.find(1), created_at: DateTime.now.yesterday)
Credit.create!(real_amount: 350, exchange_rate: ExchangeRate.find(2), rubi_amount: 350 / ExchangeRate.find(2).real, company: Company.find(3), client: Client.find(1), created_at: DateTime.now.yesterday)
Credit.create!(real_amount: 175, exchange_rate: ExchangeRate.find(3), rubi_amount: 175 / ExchangeRate.find(3).real, company: Company.find(1), client: Client.find(1))
Credit.create!(real_amount: 275, exchange_rate: ExchangeRate.find(3), rubi_amount: 275 / ExchangeRate.find(3).real, company: Company.find(2), client: Client.find(1))
Credit.create!(real_amount: 375, exchange_rate: ExchangeRate.find(3), rubi_amount: 375 / ExchangeRate.find(3).real, company: Company.find(3), client: Client.find(1))
Credit.create!(real_amount: 300, exchange_rate: ExchangeRate.find(1), rubi_amount: 300 / ExchangeRate.find(1).real, company: Company.find(2), client: Client.find(2), created_at: DateTime.now.days_ago(2))
Credit.create!(real_amount: 400, exchange_rate: ExchangeRate.find(1), rubi_amount: 400 / ExchangeRate.find(1).real, company: Company.find(3), client: Client.find(2), created_at: DateTime.now.days_ago(2))
Credit.create!(real_amount: 250, exchange_rate: ExchangeRate.find(2), rubi_amount: 250 / ExchangeRate.find(2).real, company: Company.find(1), client: Client.find(2), created_at: DateTime.now.yesterday)
Credit.create!(real_amount: 350, exchange_rate: ExchangeRate.find(2), rubi_amount: 350 / ExchangeRate.find(2).real, company: Company.find(2), client: Client.find(2), created_at: DateTime.now.yesterday)
Credit.create!(real_amount: 450, exchange_rate: ExchangeRate.find(2), rubi_amount: 450 / ExchangeRate.find(2).real, company: Company.find(3), client: Client.find(2), created_at: DateTime.now.yesterday)
Credit.create!(real_amount: 275, exchange_rate: ExchangeRate.find(3), rubi_amount: 275 / ExchangeRate.find(3).real, company: Company.find(1), client: Client.find(2))
Credit.create!(real_amount: 375, exchange_rate: ExchangeRate.find(3), rubi_amount: 375 / ExchangeRate.find(3).real, company: Company.find(2), client: Client.find(2))
Credit.create!(real_amount: 475, exchange_rate: ExchangeRate.find(3), rubi_amount: 475 / ExchangeRate.find(3).real, company: Company.find(3), client: Client.find(2))
Credit.create!(real_amount: 300, exchange_rate: ExchangeRate.find(1), rubi_amount: 300 / ExchangeRate.find(1).real, company: Company.find(1), client: Client.find(3), created_at: DateTime.now.days_ago(2))
Credit.create!(real_amount: 400, exchange_rate: ExchangeRate.find(1), rubi_amount: 400 / ExchangeRate.find(1).real, company: Company.find(2), client: Client.find(3), created_at: DateTime.now.days_ago(2))
Credit.create!(real_amount: 500, exchange_rate: ExchangeRate.find(1), rubi_amount: 500 / ExchangeRate.find(1).real, company: Company.find(3), client: Client.find(3), created_at: DateTime.now.days_ago(2))
Credit.create!(real_amount: 350, exchange_rate: ExchangeRate.find(2), rubi_amount: 350 / ExchangeRate.find(2).real, company: Company.find(1), client: Client.find(3), created_at: DateTime.now.yesterday)
Credit.create!(real_amount: 450, exchange_rate: ExchangeRate.find(2), rubi_amount: 450 / ExchangeRate.find(2).real, company: Company.find(2), client: Client.find(3), created_at: DateTime.now.yesterday)
Credit.create!(real_amount: 550, exchange_rate: ExchangeRate.find(2), rubi_amount: 550 / ExchangeRate.find(2).real, company: Company.find(3), client: Client.find(3), created_at: DateTime.now.yesterday)
Credit.create!(real_amount: 375, exchange_rate: ExchangeRate.find(3), rubi_amount: 375 / ExchangeRate.find(3).real, company: Company.find(1), client: Client.find(3))
Credit.create!(real_amount: 475, exchange_rate: ExchangeRate.find(3), rubi_amount: 475 / ExchangeRate.find(3).real, company: Company.find(2), client: Client.find(3))
Credit.create!(real_amount: 575, exchange_rate: ExchangeRate.find(3), rubi_amount: 575 / ExchangeRate.find(3).real, company: Company.find(3), client: Client.find(3))

puts('### Criando Conversões Bônus')
BonusConversion.create!(start_date: 5.days.ago, end_date: 2.day.ago, bonus_percentage: 10, deadline: 7, client_category: ClientCategory.first)
BonusConversion.create!(start_date: 1.day.ago, end_date: 15.days.from_now, bonus_percentage: 5, deadline: 3, client_category: ClientCategory.first)
