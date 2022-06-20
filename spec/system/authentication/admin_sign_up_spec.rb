require 'rails_helper'

describe "Administrador se registra" do
  it 'com sucesso' do
    visit(root_path)
    click_on("Inscrever-se")
    fill_in "Nome Completo",	with: "João Fernandes Aguiar"
    fill_in "CPF", with: "12345678901"
    fill_in "E-mail", with: "joaofernandes@userubis.com.br"
    fill_in "Senha", with: "123456"
    fill_in "Confirme sua senha",	with: "123456"
    click_on("Inscrever-se")

    expect(page).to have_content("Aguarde a aprovação do seu cadastro")
    expect(Admin.all.length).to eq(1)
    expect(Admin.last.email).to eq("joaofernandes@userubis.com.br")
  end

  it "com dados inválidos" do
    visit root_path
    click_on("Inscrever-se")
    fill_in "Nome Completo",	with: "João Fernandes Aguiar"
    fill_in "CPF", with: ""
    fill_in "E-mail", with: "joaofernandes@userubis.com.br"
    fill_in "Senha", with: ""
    fill_in "Confirme sua senha",	with: ""
    click_on("Inscrever-se")

    expect(page).to have_content("Senha não pode ficar em branco")
    expect(page).to have_content("CPF não pode ficar em branco")
  end

  it "com e-mail inválido" do
    visit root_path
    click_on("Inscrever-se")
    fill_in "Nome Completo",	with: "João Fernandes Aguiar"
    fill_in "CPF", with: "12345678901"
    fill_in "E-mail", with: "joaofernandes@erro.com.br"
    fill_in "Senha", with: "123456789"
    fill_in "Confirme sua senha",	with: "123456789"
    click_on("Inscrever-se")

    expect(page).to have_content("E-mail não é válido")
  end
end
