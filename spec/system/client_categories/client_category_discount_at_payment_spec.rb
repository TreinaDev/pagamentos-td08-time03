require 'rails_helper'

describe 'Desconto de uma categoria de cliente é aplicado no pagamento' do
  it 'com sucesso' do
    admin = create(:admin, :approved)
    er = create(:exchange_rate, :approved, admin: admin)
    client_categ = create(:client_category, name: 'BASIC', discount: 5)
    client = create(:client, client_category: client_categ)
    create(:credit, real_amount: 5000, client: client, exchange_rate: er)
    order = create(:order, transaction_total_value: 2000, client: client)
    create(:debit, real_amount: order.transaction_total_value, client: client, exchange_rate: er, order: order)

    login_as(admin)
    visit clients_path
    fill_in 'CPF/CNPJ', with: client.registration_number
    click_on 'Consultar'

    expect(page).to have_content('Saldo: RB 310.0 (R$ 3.100,00)')
  end

  it 'mas o desconto é nulo' do
    admin = create(:admin, :approved)
    er = create(:exchange_rate, :approved, admin: admin)
    client_categ = create(:client_category, name: 'BASIC', discount: 0)
    client = create(:client, client_category: client_categ)
    create(:credit, real_amount: 5000, client: client, exchange_rate: er)
    order = create(:order, transaction_total_value: 2000, client: client)
    create(:debit, real_amount: order.transaction_total_value, client: client, exchange_rate: er, order: order)

    login_as(admin)
    visit clients_path
    fill_in 'CPF/CNPJ', with: client.registration_number
    click_on 'Consultar'

    expect(page).to have_content('Saldo: RB 300.0 (R$ 3.000,00)')
  end
end