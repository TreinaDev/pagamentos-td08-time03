require 'rails_helper'

describe 'Administrador acessa página de créditos pendentes' do
  it 'e aprova um crédito' do
    admin = create(:admin, :approved)
    create(:daily_credit_limit, value: 10_000)
    er = create(:exchange_rate, admin: admin)
    company = create(:company)
    first_client = create(:client)
    second_client = create(:client, registration_number: '987.654.321-01', name: 'Sergio')
    first_credit = create(:credit, real_amount: 12_000, company: company, client: first_client, exchange_rate: er)
    second_credit = create(:credit, real_amount: 15_000, company: company, client: second_client, exchange_rate: er)

    login_as(admin)
    visit root_path
    click_on('Créditos Pendentes')
    within('#pending_credit-1') do
      click_on('Aprovar')
    end
    
    expect(page).to have_content('Crédito aprovado com sucesso!')
    expect(page).to have_content('R$ 12.000,00')
    expect(page).not_to have_content('987.654.321-01')
    expect(page).not_to have_content('Sergio')
    expect(page).not_to have_content('R$ 15.000,00')
  end
end