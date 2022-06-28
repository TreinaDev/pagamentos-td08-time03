require 'rails_helper'

describe 'Administrador consulta o saldo de um cliente' do
  it 'a partir da tela inicial' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit root_path
    click_on('Saldo de Clientes')

    expect(current_path).to eq(clients_path)
    within('h2') do
      expect(page).to have_content('Consultar Saldo de Clientes')
    end
    expect(page).to have_field('CPF/CNPJ')
    expect(page).to have_button('Consultar')
  end

  it 'com sucesso' do
    admin = create(:admin, :approved)
    er = create(:exchange_rate, :approved, admin: admin)
    company = create(:company)
    client = create(:client, registration_number: '123.456.789-00')
    create(:credit, real_amount: 500, exchange_rate: er, client: client, company: company)
    create(:credit, real_amount: 650, exchange_rate: er, client: client, company: company)

    login_as(admin)
    visit clients_path
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
    client = create(:client, registration_number: '123.456.789-00')
    create(:credit, real_amount: 500, exchange_rate: er, client: client, company: company)
    create(:credit, real_amount: 650, exchange_rate: er, client: client, company: company)

    login_as(admin)
    visit clients_path
    fill_in('CPF/CNPJ', with: '12345678900')
    click_on('Consultar')

    expect(page).to have_content('123.456.789-00')
  end

  it 'mas não encontra nenhum cliente correspondente àquele CPF/CNPJ' do
    admin = create(:admin, :approved)
    er = create(:exchange_rate, :approved, admin: admin)
    company = create(:company)
    client = create(:client, registration_number: '123.456.789-00', name: 'João Almeida')
    create(:credit, real_amount: 500, exchange_rate: er, client: client, company: company)
    create(:credit, real_amount: 650, exchange_rate: er, client: client, company: company)

    login_as(admin)
    visit clients_path
    fill_in('CPF/CNPJ', with: '915.772.461-79')
    click_on('Consultar')

    expect(page).to have_content('Cliente não encontrado')
    expect(page).not_to have_content('123.456.789-00')
    expect(page).not_to have_content('João Almeida')
  end
end