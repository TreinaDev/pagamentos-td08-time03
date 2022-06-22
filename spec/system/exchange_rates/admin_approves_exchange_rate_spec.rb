require 'rails_helper'

describe 'Admin aprova uma taxa de câmbio com variação maior que 10%' do
  it 'com sucesso' do
    first_admin = create(:admin, :approved, full_name: 'Fernando', email: 'fernando@userubis.com.br',
                                            cpf: '12555778904', password: '123456')
    second_admin = create(:admin, :approved)
    first_exchange_rate = create(:exchange_rate, admin: first_admin)

    login_as(second_admin)
    visit exchange_rates_path
    click_on 'Taxas pendentes'
    click_on 'Aprovar'

    expect(page).to have_content 'Taxa aprovada com sucesso.'
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
