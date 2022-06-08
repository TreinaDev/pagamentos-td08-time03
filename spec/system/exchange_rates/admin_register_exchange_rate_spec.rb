require 'rails_helper'

describe 'Administrador cria uma taxa de câmbio' do
  it 'a partir do menu inicial' do
    visit root_path
    within('nav') do
      click_on 'Taxa de câmbio'
    end
    click_on 'Configurar taxa de câmbio'

    expect(current_path).to eq(new_exchange_rate_path)
    expect(page).to have_field('Cotação')
    expect(page).to have_button('Enviar')
  end

  it 'com sucesso' do
    today = DateTime.now.strftime('%d/%m/%Y')

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
  end
end 