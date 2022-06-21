require 'rails_helper'

describe 'Admin visualiza taxas pendentes de aprovação%' do
  it 'com sucesso' do
    first_admin = create(:admin, :approved, full_name: 'Fernando', email: 'fernando@userubis.com.br',
                                            cpf: '12555778904', password: '123456')
    second_admin = create(:admin, :approved)
    create(:exchange_rate, admin: first_admin)
    create(:exchange_rate, admin: first_admin, real: 11)

    login_as(second_admin)
    visit exchange_rates_path
    click_on 'Taxas pendentes'

    expect(page).to have_content("fernando@userubis.com.br")
    expect(page).to have_content("R$ 10,00")

  end
end