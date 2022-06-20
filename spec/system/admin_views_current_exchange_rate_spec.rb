require 'rails_helper'

describe 'Admin visualiza taxa de câmbio atual' do
  it 'com sucesso' do
    create(:exchange_rate)
    create(:exchange_rate, real: 11.00)
    admin = create(:admin)
    update_date = I18n.l(ExchangeRate.last.created_at.localtime)

    login_as(admin)
    visit root_path

    within('div.current-exchange-rate') do
      expect(page).to have_content 'RB 1 R$ 11,00 | 10.0%'
      expect(page).to have_content "Última atualização em #{update_date}"
    end
  end

  it 'e não existe uma taxa de câmbio cadastrada' do
    admin = create(:admin)

    login_as(admin)
    visit root_path

    expect(page).to have_content('Você precisa cadastrar uma nova taxa de câmbio.')
    expect(page).not_to have_content 'Taxa de câmbio'
    expect(page).not_to have_content 'RB 1 R$ 11,00 | 10.0%'
    expect(page).not_to have_content 'Última atualização'
  end
end
