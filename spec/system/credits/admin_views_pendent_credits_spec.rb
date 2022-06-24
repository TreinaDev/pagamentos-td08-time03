require 'rails_helper'

describe 'Administrador vê créditos pendentes' do
  it 'com sucesso' do
    admin = create(:admin, :approved)
    create(:daily_credit_limit, value: 10_000)
    er = create(:exchange_rate, admin: admin)
    company = create(:company)
    client = create(:client)
    first_credit = create(:credit, real_amount: 6_000, company: company, client: client, exchange_rate: er)
    second_credit = create(:credit, real_amount: 5_000, company: company, client: client, exchange_rate: er)

    login_as(admin)
    visit root_path
    within('.row') do
      click_on('Créditos Pendentes')
    end

    within('h2') do
      expect(page).to have_content('Créditos Pendentes')
    end
    within('table') do
      expect(page).to have_content('Data de entrada')
      expect(page).to have_content(I18n.localize(second_credit.created_at.to_date))
      expect(page).to have_content('CPF/CNPJ')
      expect(page).to have_content(client.registration_number)
      expect(page).to have_content('Nome do Cliente')
      expect(page).to have_content(client.name)
      expect(page).to have_content('Valor de crédito')
      expect(page).to have_content('R$ 5.000,00')
      expect(page).to have_content('Origem do crédito')
      expect(page).to have_content(company.corporate_name)
      expect(page).not_to have_content('R$ 6.000,00')
      expect(page).not_to have_content('R$ 3.500,00')
    end
    expect(page).not_to have_content('Não existem créditos pendentes')
  end

  it 'mas não existem créditos pendentes' do
    first_admin = create(:admin, :approved)
    second_admin = create(:admin, :approved, email: 'sergio@userubis.com.br', cpf: '98765432101', full_name: 'Sergio')
    create(:daily_credit_limit, value: 10_000)
    er = create(:exchange_rate, admin: second_admin)
    client = create(:client)
    first_credit = create(:credit, real_amount: 8_000, client: client, exchange_rate: er, created_at: DateTime.now.yesterday)
    second_credit = create(:credit, real_amount: 9_000, client: client, exchange_rate: er)

    login_as(first_admin)
    visit root_path
    within('.row') do
      click_on('Créditos Pendentes')
    end

    expect(page).not_to have_css('table')
    expect(page).to have_content('Não existem créditos pendentes')
    expect(page).not_to have_content(I18n.localize(first_credit.created_at.to_date))
    expect(page).not_to have_content(I18n.localize(second_credit.created_at.to_date))
    expect(page).not_to have_content(client.registration_number)
    expect(page).not_to have_content(client.name)
    expect(page).not_to have_content('R$ 8.000,00')
    expect(page).not_to have_content('R$ 9.000,00')
  end
end
