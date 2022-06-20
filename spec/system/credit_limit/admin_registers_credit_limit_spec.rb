require 'rails_helper'

describe 'Administrador cadastra um limite de crédito diário' do
  it 'com sucesso' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit root_path
    click_on('Limite de crédito diário')
    click_on('Configurar limite')
    within('form') do
      fill_in('Valor R$', with: '10.000')
      click_on('Criar limite')
    end

    expect(page).to have_content('Limite de crédito diário criado com sucesso!')
    expect(page).to have_content('R$ 10.000')
    expect(page).not_to have_content('Nenhum limite diário cadastrado')
  end
end