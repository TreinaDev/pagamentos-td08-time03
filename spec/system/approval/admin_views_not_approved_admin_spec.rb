require 'rails_helper'

describe 'Admin visualiza lista de admins não-aprovados' do
  it 'apenas se estiver aprovado' do
    admin = create(:admin, :not_approved)

    login_as(admin)
    visit(approvals_path)

    expect(current_path).to eq(root_path)
  end

  it 'com sucesso' do
    admin = create(:admin, :approved)
    create(:admin, :not_approved, full_name: 'Fernando', email: 'fernando@userubis.com.br', cpf: '12555778904',
                                  password: '123456')
    create(:admin, :half_approved, full_name: 'Gabriel', email: 'gabriel@userubis.com.br', cpf: '00355778901',
                                   password: '123456')
    create(:admin, :approved, full_name: 'Maria', email: 'maria@userubis.com.br', cpf: '12555778905',
                              password: '123456')
    create(:admin, :approved, full_name: 'Josimar', cpf: '19283774652', email: 'josimar@userubis.com.br',
                              password: '123456')
    create(:admin, :approved, full_name: 'Lucas', email: 'lucas@userubis.com.br', cpf: '18283774652',
                              password: '123456')

    login_as(admin)
    visit(root_path)
    within('nav') do
      click_on('Aprovações Pendentes')
    end

    expect(page).to have_content('Aprovações Pendentes')
    within('.pending_admin-0') do
      expect(page).to have_content('Fernando')
      expect(page).to have_content('fernando@userubis.com.br')
      expect(page).to have_content('Aprovações 0/2')
      expect(page).to have_button('Aprovar')
    end
    within('.pending_admin-1') do
      expect(page).to have_content('Gabriel')
      expect(page).to have_content('gabriel@userubis.com.br')
      expect(page).to have_content('Aprovações 1/2')
      expect(page).to have_button('Aprovar')
    end
    expect(page).not_to have_content('Maria')
    expect(page).not_to have_content('maria@userubis.com.br')
    expect(page).not_to have_content('Aprovações 2/2')
  end

  it 'sem nenhum cadastrado' do
    admin = create(:admin, :approved) # superadmin

    login_as(admin)
    visit(root_path)
    within('nav') do
      click_on('Aprovações Pendentes')
    end

    expect(page).to have_content('Solicitações: 0')
    expect(page).to have_content('Nenhum pedido de aprovação encontrado.')
  end

  it 'mas todos os admins já estão aprovados' do
    admin = create(:admin, :approved)
    create(:admin, :approved, full_name: 'Fernando', cpf: '12555778904', email: 'fernando@userubis.com.br',
                              password: '123456')
    create(:admin, :approved, full_name: 'Maria', cpf: '12555778905', email: 'gabriel@userubis.com.br',
                              password: '123456')
    create(:admin, :approved, full_name: 'Gabriel', cpf: '00355778901', email: 'maria@userubis.com.br',
                              password: '123456')

    login_as(admin)
    visit approvals_path

    expect(page).to have_content('Solicitações: 0')
    expect(page).to have_content('Nenhum pedido de aprovação encontrado.')
  end
end
