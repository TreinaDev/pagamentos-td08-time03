require 'rails_helper'

describe 'Administrador vê limite de crédito diário atual' do
  it 'com sucesso' do
    admin = create(:admin, :approved)
    create(:daily_credit_limit)

    login_as(admin)
    visit root_path
    click_on('Limite de crédito diário')

    within('h1') do
      expect(page).to have_content('Limite de Crédito Diário')
    end
    expect(page).to have_content('Limite atual:')
    expect(page).to have_content('R$ 10.000,00')
    expect(page).not_to have_content('Nenhum limite diário cadastrado')
  end
end
