require 'rails_helper'

describe 'Admin aprova uma taxa de câmbio com variação maior que 10%' do
  it 'com sucesso' do
    first_admin = create(:admin, :approved, full_name: 'Fernando', email: 'fernando@userubis.com.br',
      cpf: '12555778904', password: '123456')
    second_admin = create(:admin, :approved)
    first_exchange_rate = create(:exchange_rate, admin: first_admin)
    create(:exchange_rate_approval, exchange_rate: first_exchange_rate, admin: first_admin)

    login_as(second_admin)
    visit exchange_rates_path
    click_on 'Taxas pendentes'
    click_on 'Aprovar'

    expect(page).to have_content 'Taxa aprovada com sucesso.'
  end
end 