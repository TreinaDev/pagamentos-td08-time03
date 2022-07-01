require 'rails_helper'

describe 'Administrador acessa página de créditos pendentes' do
  it 'e aprova um crédito' do
    admin = create(:admin, :approved)
    create(:daily_credit_limit, value: 10_000)
    er = create(:exchange_rate, admin: admin)
    company = create(:company)
    client_category = create(:client_category)
    first_client = create(:client, client_category: client_category)
    second_client = create(:client, registration_number: '987.654.321-01', name: 'Sergio', client_category: client_category)
    create(:credit, real_amount: 12_000, company: company, client: first_client, exchange_rate: er)
    create(:credit, real_amount: 15_000, company: company, client: second_client, exchange_rate: er)

    login_as(admin)
    visit root_path
    within('.row') do
      click_on('Créditos Pendentes')
    end
    within('.pending_credit-1') do
      click_on('Aprovar')
    end

    expect(page).to have_content('Crédito aprovado com sucesso!')
    expect(page).to have_content('R$ 12.000,00')
    expect(Credit.last.status).to eq('approved')
    expect(page).not_to have_content('987.654.321-01')
    expect(page).not_to have_content('Sergio')
    expect(page).not_to have_content('R$ 15.000,00')
  end

  it 'e reprova um crédito' do
    admin = create(:admin, :approved)
    create(:daily_credit_limit, value: 10_000)
    er = create(:exchange_rate, admin: admin)
    company = create(:company)
    client_category = create(:client_category)
    first_client = create(:client, client_category: client_category)
    second_client = create(:client, registration_number: '987.654.321-01', name: 'Sergio', client_category: client_category)
    create(:credit, real_amount: 12_000, company: company, client: first_client, exchange_rate: er)
    create(:credit, real_amount: 15_000, company: company, client: second_client, exchange_rate: er)

    login_as(admin)
    visit root_path
    within('.row') do
      click_on('Créditos Pendentes')
    end
    within('.pending_credit-1') do
      click_on('Reprovar')
    end

    expect(page).to have_content('Crédito reprovado com sucesso!')
    expect(page).to have_content('R$ 12.000,00')
    expect(Credit.last.status).to eq('rejected')
    expect(page).not_to have_content('987.654.321-01')
    expect(page).not_to have_content('Sergio')
    expect(page).not_to have_content('R$ 15.000,00')
  end
end
