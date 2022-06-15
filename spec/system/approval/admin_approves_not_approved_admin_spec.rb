require 'rails_helper'

describe "Admin aprova um admin recém cadastrado" do
  it 'apenas uma vez' do
    admin = create(:admin)
    admin.approved!
    Admin.create!(full_name: "Fernando", cpf:"12555778904", email:"fernando@userubis.com.br", password:"123456")

    login_as(admin)

    visit(approvals_path)
    expect(page).to have_content("Solicitações: 1")
    expect(page).to have_content("Fernando")
    expect(page).to have_content("fernando@userubis.com.br")
    expect(page).to have_content("Aprovações 0/2")
    click_on("Aprovar")

    expect(page).to have_content("Admin aprovado com sucesso!")
    expect(page).to have_content("Solicitações: 0")
    expect(page).not_to have_content("Fernando")
    expect(page).not_to have_content("fernando@userubis.com.br")
    expect(page).not_to have_content("Aprovações 1/2")
  end

  it 'sem afetar os demais' do
    admin = create(:admin)
    admin.approved!
    Admin.create!(full_name: "Fernando", cpf:"12555778904", email:"fernando@userubis.com.br", password:"123456")
    Admin.create!(full_name: "Márcio", cpf:"12444778904", email:"marcio@userubis.com.br", password:"123456")

    login_as(admin)
    visit(approvals_path) 
    within(".pending_admin-0") do
      click_on("Aprovar")
    end

    expect(page).to have_content("Solicitações: 1")
    expect(page).to have_content("Márcio")
    expect(page).to have_content("marcio@userubis.com.br")
    expect(page).not_to have_content("Fernando")
    expect(page).not_to have_content("fernando@userubis.com.br")
  end
end




