require 'rails_helper'

describe 'Administrador vê limite de crédito diário atual' do
  it 'com sucesso' do
    admin = create(:admin, :approved)
    create(:daily_credit_limit)

    login_as(admin)
    visit root_path
    click_on('Limite de Crédito Diário')

    expect(current_path).to eq(daily_credit_limits_path)
    within('h2') do
      expect(page).to have_content('Limite de Crédito Diário')
    end
    expect(page).to have_content('Limite atual:')
    expect(page).to have_content('R$ 10.000,00')
    expect(page).not_to have_content('Nenhum limite diário configurado')
  end

  it 'mas não há nenhum limite de crédito cadastrado' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit root_path
    visit daily_credit_limits_path

    expect(page).to have_content('Nenhum limite de crédito configurado')
    expect(page).not_to have_content('Limite atual:')
  end
end
