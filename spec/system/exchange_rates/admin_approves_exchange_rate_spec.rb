require 'rails_helper'

describe 'Admin aprova uma taxa de câmbio com variação maior que 10%' do
  it 'com sucesso' do
    first_admin = create(:admin, :approved, full_name: 'Fernando', email: 'fernando@userubis.com.br',
                                            cpf: '12555778904', password: '123456')
    second_admin = create(:admin, :approved)
    create(:exchange_rate, admin: first_admin)
    create(:exchange_rate, admin: first_admin, real: 20)

    login_as(second_admin)
    visit exchange_rates_path
    click_on 'Taxas pendentes'
    within(".pending_exchange_rate-0") do
      click_on 'Aprovar'
    end

    expect(page).to have_content 'Taxa aprovada com sucesso.'
    expect(page).to have_content 'Não foram encontradas taxas pendentes no sistema.'
  end

  it 'criada por ele mesmo' do
    first_admin = create(:admin, :approved, full_name: 'Fernando', email: 'fernando@userubis.com.br',
                                            cpf: '12555778904', password: '123456')
    second_admin = create(:admin, :approved)
    create(:exchange_rate, admin: first_admin, status: 'approved')

    login_as(second_admin)
    visit exchange_rate_approvals_path

    expect(page).not_to have_button 'Aprovar'
  end
end
