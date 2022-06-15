require 'rails_helper'

describe "Admin visualiza lista de admins não-aprovados" do
  it 'apenas se estiver aprovado' do
    admin = create(:admin)
    admin.not_approved!

    login_as(admin)
    visit(approvals_path)

    expect(current_path).to eq(root_path)
  end

  it 'com sucesso' do
    admin = create(:admin) #superadmin
    admin.approved!
    first = Admin.create!(full_name: "Fernando", cpf:"12555778904", email:"fernando@userubis.com.br", password:"123456")
    second = Admin.create!(full_name: "Gabriel", cpf:"00355778901", email:"gabriel@userubis.com.br", password:"123456")
    third = Admin.create!(full_name: "Maria", cpf:"10455778900", email:"maria@userubis.com.br", password:"123456")
    Approval.create!(super_admin_email: "joao@userubis.com.br", admin: third)
    Approval.create!(super_admin_email: "josimar@userubis.com.br", admin: third)
    Approval.create!(super_admin_email: "lucas@userubis.com.br", admin: second)

    login_as(admin)
    visit(root_path)
    within("nav") do
      click_on("Aprovações Pendentes")
    end
    expect(page).to have_content("Admins não aprovados")

     within(".pending_admin-0") do
      expect(page).to have_content("Fernando")
      expect(page).to have_content("fernando@userubis.com.br")
      expect(page).to have_content("Aprovações 0/2")
      expect(page).to have_button("Aprovar")
    end
    within(".pending_admin-1") do
      expect(page).to have_content("Gabriel")
      expect(page).to have_content("gabriel@userubis.com.br")
      expect(page).to have_content("Aprovações 1/2")
      expect(page).to have_button("Aprovar")
    end

    expect(page).not_to have_content("Maria")
    expect(page).not_to have_content("maria@userubis.com.br")
    expect(page).not_to have_content("Aprovações 2/2")
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

  it 'mas todos os admins já estão aprovados' do
    super_admin = create(:admin)
    super_admin.approved!
    first_admin = Admin.create!(full_name: "Fernando", cpf:"12555778904", email:"fernando@userubis.com.br", password:"123456")
    second_admin = Admin.create!(full_name: "Gabriel", cpf:"00355778901", email:"gabriel@userubis.com.br", password:"123456")
    third_admin = Admin.create!(full_name: "Maria", cpf:"10455778900", email:"maria@userubis.com.br", password:"123456")
    first_admin.approved!
    second_admin.approved!
    third_admin.approved!

    login_as(super_admin)
    visit approvals_path

    expect(page).to have_content("Solicitações: 0")
    expect(page).to have_content("Nenhum pedido de aprovação encontrado.")
  end

end
