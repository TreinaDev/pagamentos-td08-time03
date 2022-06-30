require 'rails_helper'

describe 'Administrador desativa uma conversão bônus' do
  it 'com sucesso' do
    admin = create(:admin, :approved)
    first_client_category = create(:client_category, name: 'BASIC')
    create(:bonus_conversion, client_category: first_client_category)

    login_as(admin)
    visit bonus_conversions_path
    click_on('Desativar')

    expect(page).to have_content('Conversão bônus desativada com sucesso!')
    expect(page).to have_content('Total: 0')
    expect(page).to have_content('Nenhuma conversão bônus cadastrada.')
    expect(BonusConversion.last.status).to eq('inactive')
  end

  it 'sem afetar as demais' do
    admin = create(:admin, :approved)
    first_client_category = create(:client_category, name: 'BASIC')
    second_client_category = create(:client_category, name: 'PREMIUM')
    create(:bonus_conversion, start_date: 5.days.ago.to_date, end_date: 10.days.from_now.to_date,
           client_category: first_client_category)
    create(:bonus_conversion, start_date: 1.day.from_now.to_date, end_date: 15.days.from_now.to_date,
           client_category: second_client_category)
    
    login_as(admin)
    visit bonus_conversions_path
    within('.bonus_conversion-0') do
      click_on('Desativar')
    end

    expect(page).to have_content('Total: 1')
    expect(page).to have_content(I18n.l(5.days.ago.to_date))
    expect(page).to have_content(I18n.l(10.days.from_now.to_date))
    expect(page).to have_content('4')
    expect(page).to have_content('BASIC')
    expect(page).not_to have_content('PREMIUM')
    expect(page).not_to have_content(I18n.l(1.day.from_now.to_date))
    expect(page).not_to have_content(I18n.l(15.days.from_now.to_date))
  end
end
