require 'rails_helper'

describe 'Administrador cadastra um limite de crédito diário' do
  it 'com sucesso' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit root_path
    click_on('Limite de crédito diário')
    click_on('Configurar limite')
    within('form#daily_credit_limit') do
      fill_in('Valor R$', with: '10000')
      click_on('Criar limite')
    end

    expect(page).to have_content('Limite de crédito diário criado com sucesso!')
    expect(page).to have_content('R$ 10.000,00')
    expect(page).not_to have_content('Nenhum limite diário configurado')
  end

  it 'mas não digita o valor' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit new_daily_credit_limit_path
    within('form#daily_credit_limit') do
      fill_in('Valor R$', with: '')
      click_on('Criar limite')
    end

    expect(page).to have_content('Valor de limite inválido. Tente novamente.')
    expect(page).to have_content('Valor R$ não pode ficar em branco')
  end

  it 'e volta para a tela de limite atual' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit root_path
    click_on('Limite de crédito diário')
    click_on('Configurar limite')
    click_on('Voltar para limite atual')

    expect(current_path).to eq(daily_credit_limits_path)
  end
end