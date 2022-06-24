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
ExchangeRateApproval.create(admin: Admin.find(4), exchange_rate: ExchangeRate.find(1))
ExchangeRateApproval.create(admin: Admin.find(3), exchange_rate: ExchangeRate.find(1))
ExchangeRateApproval.create(admin: Admin.find(4), exchange_rate: ExchangeRate.find(2))
ExchangeRateApproval.create(admin: Admin.find(3), exchange_rate: ExchangeRate.find(2))

puts('### Criando Limite de Crédito Diário')
DailyCreditLimit.create!(value: 22)

puts('### Criando Categoria de Clientes')
ClientCategory.create!(name: "BASIC", discount: 5)
ClientCategory.create!(name: "PREMIUM", discount: 20)

puts('### Criando Conversões Bônus')
BonusConversion.create!(start_date: 3.day.ago, end_date: 1.day.ago, bonus_percentage: 10, deadline: 7, client_category: ClientCategory.first, )
BonusConversion.create!(start_date: 10.day.ago, end_date: 2.day.ago, bonus_percentage: 5, deadline: 3, client_category: ClientCategory.first, )
