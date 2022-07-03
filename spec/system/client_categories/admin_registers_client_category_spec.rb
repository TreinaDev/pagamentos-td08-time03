require 'rails_helper'

describe 'Administrador cria uma categoria de clientes' do
  it 'a partir do menu inicial' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit root_path
    click_on 'Categoria de Clientes'
    click_on 'Criar categoria de clientes'

    expect(current_path).to eq(new_client_category_path)
    expect(page).to have_field('Nome')
    expect(page).to have_field('Desconto')
    expect(page).to have_button('Criar')
  end

  it 'com sucesso' do
    admin = create(:admin, :approved)
    create(:client, name: 'João Almeida', registration_number: '123.456.789-00')
    today = DateTime.now.strftime('%d/%m/%Y')

    login_as(admin)
    visit new_client_category_path
    fill_in 'Nome', with: 'Bronze'
    fill_in 'Desconto', with: '15.5'
    check '123.456.789-00 - João Almeida'
    click_on 'Criar'

    expect(page).to have_content 'Categoria de cliente cadastrada com sucesso!'
    within('table') do
      expect(page).to have_content '15.5%'
      expect(page).to have_content today
    end
  end

  it 'com dados inválidos' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit new_client_category_path
    fill_in 'Nome', with: ''
    fill_in 'Desconto', with: '-2'
    click_on 'Criar'

    expect(page).to have_content 'Erro ao criar categoria de clientes'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Desconto deve ser maior ou igual a 0'
  end
end
