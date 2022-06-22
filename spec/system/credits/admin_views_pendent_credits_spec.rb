require 'rails_helper'

describe 'Administrador vê créditos pendentes' do
  it 'com sucesso' do
    admin = create(:admin)
    create(:daily_credit_limit)
    client = create(:client)
    credit_first = create(:credit, real_amount: 6_000, client: client)
    credit_second = create(:credit, real_amount: 5_000, client: client)

    login_as(admin)
    visit root_path
    click_on('Créditos Pendentes')

    within('h2') do
      expect(page).to have_content('Créditos Pendentes')
    end
    expect(page).to have_content(credit_second.created_at.to_date)
    expect(page).to have_content(client.registration_number)
    expect(page).to have_content(client.name)
    expect(page).to have_content('R$ 5.000,00')
    expect(page).not_to have_content('R$ 6.000,00')
  end
end