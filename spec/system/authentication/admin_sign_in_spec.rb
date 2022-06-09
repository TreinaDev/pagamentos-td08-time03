require 'rails_helper'

describe 'Admin se autentica' do
  it 'com sucesso' do
    Admin.create!(full_name: "João Fernandes Aguiar", cpf:"012345678901", email:"joaofernandes@userubis.com.br", password: "123456")

    visit(root_path)

    fill_in "E-mail", with: "joaofernandes@userubis.com.br"
    fill_in "Senha", with: "123456"

    click_on("Fazer login")

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Sair")
  end

  it 'com dados inválidos ou incompletos' do
    Admin.create!(full_name: "João Fernandes Aguiar", cpf:"012345678901", email:"joaofernandes@userubis.com.br", password: "123456")

    visit(root_path)

    fill_in "E-mail", with: ""
    fill_in "Senha", with: "1"

    click_on("Fazer login")

    expect(page).to have_content("Invalid Email or password.")
  end

  it 'e faz logout'do
    Admin.create!(full_name: "João Fernandes Aguiar", cpf:"012345678901", email:"joaofernandes@userubis.com.br", password: "123456")

    visit(root_path)

    fill_in "E-mail", with: "joaofernandes@userubis.com.br"
    fill_in "Senha", with: "123456"

    click_on("Fazer login")
    click_on("Sair")

    expect(page).to have_button("Fazer login")
    expect(current_path).to eq(new_admin_session_path)
    expect(Admin.all.length).to eq(1)
  end
end
