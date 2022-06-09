require 'rails_helper'

describe 'Administrador visualiza histórico de cotação' do
  it 'a partir da página inicial' do
    exchange_rate = create(:exchange_rate)

    visit root_path
    within('nav') do
      click_on 'Cotação de Rubis'
    end

    within('table') do
      expect(page).to have_content exchange_rate.real
    end
  end

  it 'mas não há nenhuma taxa criada' do
    visit exchange_rates_path

    expect(page).to have_content('Nenhuma taxa criada')
    expect(page).not_to have_css('table')
  end

  it 'e volta para a página inicial' do
    visit exchange_rates_path
    within('nav') do
      click_on 'Início'
    end

    expect(current_path).to eq(root_path)
  end
end