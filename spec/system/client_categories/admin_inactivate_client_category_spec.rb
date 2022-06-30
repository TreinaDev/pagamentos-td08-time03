require 'rails_helper'

describe 'Administrador desativa uma categoria de clientes' do
  it 'com sucesso' do
    admin = create(:admin, :approved)
    create(:client_category)

    login_as(admin)
    visit root_path
    click_on 'Categoria de Clientes'
    click_on 'Desativar'

    expect(page).to have_content('Nenhuma categoria de clientes cadastrada.')
  end

  it 'sem afetar as demais' do
    admin = create(:admin, :approved)
    create(:client_category)
    create(:client_category, name: 'LIGHT', discount: '12.5')

    login_as(admin)
    visit root_path
    click_on 'Categoria de Clientes'
    within('.client_category-0') do
      click_on 'Desativar'
    end

    expect(page).to have_content('Total: 1')
    expect(page).to have_content('LIGHT')
    expect(page).to have_content('12.5%')
  end
end
