# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# Examples:
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

first_admin = Admin.create!(full_name: 'Maria', cpf: '12344444901', email: 'maria@userubis.com.br', password: '123456')
second_admin = Admin.create!(full_name: 'Gabriel', cpf: '10123478901', email: 'gabriel@userubis.com.br', password: '123456')
 Admin.create!(full_name: 'Mateus Cézar', cpf: '99023478901', email: 'matheus@userubis.com.br', password: '123456')
 Admin.create!(full_name: 'Fábio Júnior', cpf: '91211278901', email: 'fabiojr@userubis.com.br', password: '123456')

first_admin.approved!
second_admin.approved!


Admin.create!(full_name: 'JOnata', cpf: '99122228921', email: 'sajdasd@userubis.com.br', password: '123456')
Admin.create!(full_name: 'aaa', cpf: '99133378921', email: 'aaa@userubis.com.br', password: '123456')
Admin.create!(full_name: 'askdansd', cpf: '99116478921', email: 'mariazinha@userubis.com.br', password: '123456')
Admin.create!(full_name: 'mariazinha', cpf: '99141478921', email: 'asdasd@userubis.com.br', password: '123456')
Admin.create!(full_name: 'fernandinho', cpf: '99145478921', email: 'asdsad@userubis.com.br', password: '123456')
Admin.create!(full_name: 'ladksadsaoda', cpf: '99149478921', email: 'ccccc@userubis.com.br', password: '123456')
