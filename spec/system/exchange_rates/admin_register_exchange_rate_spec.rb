require 'rails_helper'

describe 'Administrador cria uma taxa de câmbio' do
  it 'a partir do menu inicial' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Cotação de Rubis'
    end
    click_on 'Configurar taxa de câmbio'

    expect(current_path).to eq(new_exchange_rate_path)
    expect(page).to have_field('Cotação')
    expect(page).to have_button('Enviar')
  end

  it 'e volta para o histórico de cotações' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit new_exchange_rate_path
    click_on 'Voltar para histórico de cotações'

    expect(current_path).to eq(exchange_rates_path)
  end

  it 'com sucesso' do
    admin = create(:admin, :approved)
    today = DateTime.now.strftime('%d/%m/%Y')

    login_as(admin)
    visit new_exchange_rate_path
    fill_in 'Cotação', with: '15.00'
    click_on 'Enviar'

    expect(current_path).to eq(exchange_rates_path)
    expect(page).to have_content 'Taxa de câmbio criada com sucesso.'
    within('table') do
      expect(page).to have_content '15.0'
      expect(page).to have_content today
    end
  end

  it 'com dados inválidos' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit new_exchange_rate_path
    fill_in 'Cotação', with: ''
    click_on 'Enviar'

    expect(current_path).to eq(exchange_rates_path)
    expect(page).to have_content 'Erro ao criar a taxa.'
    expect(page).to have_content 'Cotação não pode ficar em branco'
  end
end
