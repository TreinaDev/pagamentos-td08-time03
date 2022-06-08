require 'rails_helper'

describe 'Administrador se registra' do
  it 'com sucesso' do
    visit(root_path)

    click_on("Cadastrar")

    fill_in "Nome Completo",	with: "João Fernandes Aguiar"
    fill_in "CPF", with: "12345678901"
    fill_in "E-mail", with: "joaofernandes@userubis.com.br"
    fill_in "Senha", with: "123456"
    fill_in "Confirme sua senha",	with: "123456"

    click_on("Cadastrar")

    expect(page).to have_content("Sua conta ainda falta ser ativada.")

    expect(Admin.all.length).to eq(1)
    expect(Admin.last.email).to eq("joaofernandes@userubis.com.br")
  end

  it "com dados inválidos" do
    visit root_path
    click_on("Cadastrar")
    fill_in "Nome Completo",	with: "João Fernandes Aguiar"
    fill_in "CPF", with: ""
    fill_in "E-mail", with: "joaofernandes@userubis.com.br"
    fill_in "Senha", with: ""
    fill_in "Confirme sua senha",	with: ""
    click_on("Cadastrar")

    # expect(page).to have_content("Não foi possível cadastrar Administrador")
    expect(page).to have_content("Password can't be blank")
  end

end
