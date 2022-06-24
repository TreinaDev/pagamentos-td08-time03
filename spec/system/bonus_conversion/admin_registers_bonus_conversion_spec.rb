require 'rails_helper'

describe 'Admin registra uma conversão bônus' do
  it 'a partir do menu inicial' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit root_path
    click_on 'Conversões Bônus'
    click_on 'Criar conversão bônus'

    expect(current_path).to eq(new_bonus_conversion_path)
    expect(page).to have_content("Nova Conversão Bônus")
    expect(page).to have_button('Criar')
  end

  it 'com sucesso' do
    admin = create(:admin, :approved)
    create(:client_category, name: "PREMIUM")

    login_as(admin)
    visit new_bonus_conversion_path

    select '11', :from => 'bonus_conversion_start_date_3i'
    select 'maio', :from => 'bonus_conversion_start_date_2i'
    select '2022', :from => 'bonus_conversion_start_date_1i'
    select '11', :from => 'bonus_conversion_end_date_3i'
    select 'outubro', :from => 'bonus_conversion_end_date_2i'
    select '2022', :from => 'bonus_conversion_end_date_1i'
    fill_in "Bônus",	with: "12"
    fill_in "Prazo de uso",	with: "5"
    select 'PREMIUM', from: 'bonus_conversion_client_category_id'
    click_on 'Criar'

    expect(page).to have_content('Conversão bônus cadastrada com sucesso!')
    within('table') do
      expect(page).to have_content('11/05/2022')
      expect(page).to have_content('11/10/2022')
      expect(page).to have_content("PREMIUM")
      expect(page).to have_content("12.0")
      expect(page).to have_content(5)
    end
  end

  it 'com dados inválidos' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit new_bonus_conversion_path
    fill_in "Prazo de uso",	with: "5"
    click_on 'Criar'

    expect(page).to have_content("Erro ao criar categoria de clientes")
    expect(page).to have_content("Categoria de cliente é obrigatório(a)")
    expect(page).to have_content("Bônus não pode ficar em branco")
    expect(page).to have_content("Data inicial deve ser menor que a data final")
  end
end
