require 'rails_helper'

describe 'Admin visualiza categorias de clientes' do
  it 'com sucesso' do
    admin = create(:admin, :approved)
    create(:client_category, name: 'Premium', discount: '10')
    create(:client_category, name: 'Bronze', discount: '5')

    login_as(admin)
    visit root_path
    click_on 'Categoria de Clientes'
    visit client_categories_path

    expect(page).to have_content('Premium')
    expect(page).to have_content('10.0%')
    expect(page).to have_content('Bronze')
    expect(page).to have_content('5.0%')
  end

  it 'sem nenhuma cadastrada' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit root_path
    click_on 'Categoria de Clientes'
    visit client_categories_path

    expect(page).to have_content('Nenhuma categoria de clientes cadastrada.')
  end
end
