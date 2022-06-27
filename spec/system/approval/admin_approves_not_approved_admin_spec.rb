require 'rails_helper'

describe 'Admin aprova um admin cadastrado' do
  it 'apenas uma vez' do
    admin = create(:admin, :approved)
    create(:admin, :not_approved, full_name: 'Fernando', email: 'fernando@userubis.com.br', cpf: '12555778904',
                                  password: '123456')

    login_as(admin)
    visit(admin_approvals_path)
    within('.pending_admin-0') do
      click_on('Aprovar')
    end

    expect(page).to have_content('Permissão concedida a um administrador pendente.')
    expect(page).to have_content('Solicitações: 0')
    expect(page).not_to have_content('Fernando')
    expect(page).not_to have_content('fernando@userubis.com.br')
    expect(page).not_to have_content('Aprovações 1/2')
  end

  it 'sem afetar os demais' do
    admin = create(:admin, :approved)
    create(:admin, :not_approved, full_name: 'Fernando', email: 'fernando@userubis.com.br', cpf: '12555778904',
                                  password: '123456')
    create(:admin, :not_approved, full_name: 'Márcio', email: 'marcio@userubis.com.br', cpf: '12355778904',
                                  password: '123456')

    login_as(admin)
    visit(admin_approvals_path)
    within('.pending_admin-0') do
      click_on('Aprovar')
    end

    expect(page).to have_content('Solicitações: 1')
    expect(page).to have_content('Márcio')
    expect(page).to have_content('marcio@userubis.com.br')
    expect(page).not_to have_content('Fernando')
    expect(page).not_to have_content('fernando@userubis.com.br')
  end

  it 'atríbuindo a aprovação final' do
    admin = create(:admin, :approved)
    to_approve_admin = create(:admin, :not_approved, full_name: 'Fernando', email: 'fernando@userubis.com.br',
                                                     cpf: '12555778904', password: '123456')
    create(:admin_approval, super_admin_email: 'gabriela@userubis.com.br', admin: to_approve_admin)

    login_as(admin)
    visit(admin_approvals_path)
    within('.pending_admin-0') do
      click_on('Aprovar')
    end

    expect(AdminApproval.last.super_admin_email).to eq('joao@userubis.com.br')
    expect(AdminApproval.last.admin).to eq(to_approve_admin)
    expect(Admin.last.approved?).to eq(true)
    expect(page).to have_content('Permissão concedida a um administrador pendente.')
    expect(page).to have_content('Solicitações: 0')
    expect(page).not_to have_content('Fernando')
    expect(page).not_to have_content('fernando@userubis.com.br')
    expect(page).not_to have_content('Aprovações 2/2')
  end
end
