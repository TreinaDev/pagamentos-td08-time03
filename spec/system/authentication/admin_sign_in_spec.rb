require 'rails_helper'

describe "Administrador se autentica" do
  it "com sucesso" do
    create(:admin, :approved)

    visit(root_path)
    fill_in "E-mail", with: "joao@userubis.com.br"
    fill_in "Senha", with: "123456"
    click_on("Login")

    expect(page).to have_content("Login efetuado com sucesso.")
    expect(page).to have_content("Sair")
  end

  it "não estando aprovado ainda" do
    create(:admin, :not_approved)

    visit(root_path)

    fill_in "E-mail", with: "joao@userubis.com.br"
    fill_in "Senha", with: "123456"
    click_on("Login")

    expect(page).to have_content("Aguarde a aprovação do seu cadastro")
    expect(current_path).to eq(new_admin_session_path)
  end

  it "com dados inválidos ou incompletos" do
    create(:admin)

    visit(root_path)
    fill_in "E-mail", with: ""
    fill_in "Senha", with: "1"
    click_on("Login")

    expect(page).to have_content("E-mail ou senha inválidos.")
  end

  it "e faz logout" do
    admin = create(:admin)

    login_as(admin)
    visit(root_path)
    click_on("Sair")

    expect(page).to have_button("Login")
    expect(current_path).to eq(new_admin_session_path)
    expect(Admin.all.length).to eq(1)
  end
end
