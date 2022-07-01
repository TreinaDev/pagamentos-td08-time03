require 'rails_helper'

describe 'Admin visualiza conversões bônus' do
  it 'com sucesso' do
    admin = create(:admin, :approved)
    first_client_category = create(:client_category, name: 'BASIC')
    second_client_category = create(:client_category, name: 'PREMIUM')
    create(:bonus_conversion, client_category: first_client_category, start_date: 5.days.ago.to_date,
           end_date: 10.days.from_now.to_date, bonus_percentage: 5)
    create(:bonus_conversion, client_category: second_client_category, start_date: 30.days.from_now.to_date,
           end_date: 45.days.from_now.to_date, bonus_percentage: 10)

    login_as(admin)
    visit root_path
    click_on 'Conversões Bônus'

    within('.bonus_conversion-0') do
      expect(page).to have_content(I18n.l(30.days.from_now.to_date))
      expect(page).to have_content(I18n.l(45.days.from_now.to_date))
      expect(page).to have_content('10.0')
      expect(page).to have_content('PREMIUM')
      expect(page).to have_button('Desativar')
    end
    within('.bonus_conversion-1') do
      expect(page).to have_content(I18n.l(5.days.ago.to_date))
      expect(page).to have_content(I18n.l(10.days.from_now.to_date))
      expect(page).to have_content('5.0')
      expect(page).to have_content('BASIC')
      expect(page).to have_button('Desativar')
    end
  end

  it 'sem nenhuma cadastrada' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit bonus_conversions_path

    expect(page).to have_content('Nenhuma conversão bônus cadastrada.')
  end
end
