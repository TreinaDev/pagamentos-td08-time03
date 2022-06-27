require 'rails_helper'

describe 'Administrador consulta o saldo de um cliente' do
  it 'a partir da tela inicial' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit root_path
    click_on('Saldo de Clientes')

    within('h2') do
      expect(page).to have_content('Consultar Saldo de Clientes')
    end
    expect(page).to have_css('input')
    expect(page).to have_content('CPF/CNPJ')
    expect(page).to have_button('Consultar')
  end

  it 'com sucesso' do
    admin = create(:admin, :approved)
    er = create(:exchange_rate, :approved, admin: admin)
    company = create(:company)
    client = create(:client)
    create(:credit, real_amount: 500, exchange_rate: er, client: client, company: company)
    create(:credit, real_amount: 650, exchange_rate: er, client: client, company: company)

    login_as(admin)
    visit client_balances_path
    fill_in('CPF/CNPJ', with: '123.456.789-00')
    click_on('Consultar')

    expect(page).to have_content('123.456.789-00')
    expect(page).to have_content(client.name)
    expect(page).to have_content('Saldo: RB 115.0 (R$ 1.150,00)')
  end

  it 'e aceita o CPF/CNPJ sem os pontos, traços e barras' do
    admin = create(:admin, :approved)
    er = create(:exchange_rate, :approved, admin: admin)
    company = create(:company)
    client = create(:client)
    create(:credit, real_amount: 500, exchange_rate: er, client: client, company: company)
    create(:credit, real_amount: 650, exchange_rate: er, client: client, company: company)

    login_as(admin)
    visit client_balances_path
    fill_in('CPF/CNPJ', with: '12345678900')
    click_on('Consultar')

    expect(page).to have_content('123.456.789-00')
  end

  # it 'mas não aceita formatos inválidos de CPF/CNPJ' do

  # end

  # it 'mas não encontra nenhum cliente correspondente àquele CPF/CNPJ' do

  # end
end