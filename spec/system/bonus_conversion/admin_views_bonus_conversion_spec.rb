require 'rails_helper'

describe 'Admin visualiza conversões bônus' do
  it 'com sucesso' do
    admin = create(:admin, :approved)
    first_client_category = create(:client_category, name: "BASIC")
    second_client_category = create(:client_category, name: "PREMIUM")
    create(:bonus_conversion, client_category:first_client_category)
    create(:bonus_conversion, client_category:second_client_category, start_date: "2022-01-12", end_date: "2022-05-3", bonus_percentage: "11")

    login_as(admin)
    visit root_path
    click_on 'Conversões Bônus'

    within(".bonus_conversion-0") do
      expect(page).to have_content("12/01/2022")
      expect(page).to have_content("03/05/2022")
      expect(page).to have_content("11.0")
      expect(page).to have_content("PREMIUM")
      expect(page).to have_button("Desativar")
    end
    within(".bonus_conversion-1") do
      expect(page).to have_content("23/06/2022")
      expect(page).to have_content("11/10/2022")
      expect(page).to have_content("4")
      expect(page).to have_content("BASIC")
      expect(page).to have_button("Desativar")
    end
  end

  it 'sem nenhuma cadastrada' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit bonus_conversions_path

    expect(page).to have_content("Nenhuma conversão bônus cadastrada.")
  end

  
end
