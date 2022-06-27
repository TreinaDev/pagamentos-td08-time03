require 'rails_helper'

describe 'Administrador visualiza histórico de cotação' do
  it 'apenas se estiver aprovado' do
    admin = create(:admin)

    login_as(admin)
    visit(exchange_rates_path)

    expect(current_path).to eq(root_path)
  end
  it 'a partir da página inicial' do
    admin = create(:admin, :approved)
    create(:exchange_rate, :approved, admin: admin)

    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Cotação de Rubis'
    end

    within('table') do
      expect(page).to have_content 'R$ 10,00'
    end
  end

  it 'mas não há nenhuma taxa criada' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit exchange_rates_path

    expect(page).to have_content('Nenhuma taxa criada')
    expect(page).not_to have_css('table')
  end
end
