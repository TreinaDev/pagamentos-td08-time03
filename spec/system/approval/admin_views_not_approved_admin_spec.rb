require 'rails_helper'

describe "Admin aprovado visualiza admins não-aprovados" do
  it 'com sucesso' do
    admin = create(:admin)
    admin.approved!

    first = Admin.create!(full_name: "Fernando", cpf:"12555778901", email:"fernando@userubis.com.br", password:"123456")
    second = Admin.create!(full_name: "Gabriel", cpf:"12355778901", email:"gabriel@userubis.com.br", password:"123456")
    third = Admin.create!(full_name: "Maria", cpf:"12455778901", email:"maria@userubis.com.br", password:"123456")

    first.not_approved!
    second.half_approved!
    third.approved!

    login_as(admin)
    visit(root_path)
    within("nav") do
      click_on("Aprovações Pendentes")
    end

    expect(page).to have_content("Solicitações: 2")

    within(".pending_admin-0") do
      expect(page).to have_content("Fernando")
      expect(page).to have_content("fernando@userubis.com.br")
      expect(page).to have_content("Aprovações 0/2")
      click_on("Aprovar")
    end

    within(".pending_admin-1") do
      expect(page).to have_content("Gabriel")
      expect(page).to have_content("gabriel@userubis.com.br")
      expect(page).to have_content("Aprovações 1/2")
      expect(page).to have_button("Aprovar")
    end

    expect(page).not_to have_content("Maria")
    expect(page).not_to have_content("maria@userubis.com.br")
  end

  it 'sem nenhum cadastrado' do
    admin = create(:admin) #superadmin
    admin.approved!

    login_as(admin)
    visit(root_path)
    within("nav") do
      click_on("Aprovações Pendentes")
    end

    expect(page).to have_content("Solicitações: 0")
    expect(page).to have_content("Nenhum pedido de aprovação encontrado.")
  end

end
