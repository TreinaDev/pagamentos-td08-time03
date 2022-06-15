require 'rails_helper'

describe "Admin aprova um admin recém cadastrado" do
  it 'com sucesso' do
    admin = create(:admin) #superadmin
    admin.approved!
    Admin.create!(full_name: "Fernando", cpf:"12455778901", email:"fernando@userubis.com.br", password:"123456")

    login_as(admin)
    visit(root_path)
    within("nav") do
      click_on("Aprovações Pendentes")
    end

    expect(page).to have_content("Solicitações: 1")
    expect(page).to have_content("Fernando")
    expect(page).to have_content("fernando@userubis.com.br")
    expect(page).to have_content("Aprovações 0/2")
    click_on("Aprovar")

    expect(page).to have_content("Usuário aprovado com sucesso")
    expect(page).not_to have_content("Fernando")
    expect(page).not_to have_content("fernando@userubis.com.br")
    expect(page).to have_content("Solicitações: 0")

  end

end
