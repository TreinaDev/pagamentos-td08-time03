require 'rails_helper'

describe 'Administrador vê créditos pendentes' do
  it 'com sucesso' do
    admin = create(:admin)
    create(:daily_credit_limit)
    client = create(:client)
    first_credit = create(:credit, real_amount: 6_000, client: client)
    second_credit = create(:credit, real_amount: 5_000, client: client)

    login_as(admin)
    visit root_path
    click_on('Créditos Pendentes')

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
      expect(page).not_to have_content('R$ 6.000,00')
      expect(page).not_to have_content('R$ 3.500,00')
    end
  end

  it 'mas não existem créditos pendentes' do
    admin = create(:admin, :approved)
    create(:daily_credit_limit)
    client = create(:client)
    first_credit = create(:credit, real_amount: 8_000, client: client, created_at: DateTime.now.yesterday)
    second_credit = create(:credit, real_amount: 9_000, client: client)

    login_as(admin)
    visit root_path
    click_on('Créditos Pendentes')

    expect(page).not_to have_css('table')
    expect(page).to have_content('Não existem créditos pendentes')
    expect(page).not_to have_content(I18n.localize(third_credit.created_at.to_date))
    expect(page).not_to have_content(client.registration_number)
    expect(page).not_to have_content(client.name)
    expect(page).not_to have_content('R$ 8.000,00')
    expect(page).not_to have_content('R$ 9.000,00')
  end
end
