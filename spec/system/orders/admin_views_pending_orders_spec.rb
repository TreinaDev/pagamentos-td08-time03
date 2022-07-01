require 'rails_helper'

describe 'Administrador vê pedidos pendentes' do
  it 'com sucesso' do
    admin = create(:admin, :approved)
    er = create(:exchange_rate, :approved, admin: admin)
    company = create(:company)
    client_category = create(:client_category)
    first_client = create(:client, registration_number: '987.654.321-01', name: 'Sergio',
                          client_category: client_category)
    second_client = create(:client, registration_number: '981.634.221-01', name: 'Maria',
                           client_category: client_category)
    create(:credit, real_amount: 12_000, company: company, client: first_client, exchange_rate: er)
    create(:credit, real_amount: 12_000, company: company, client: second_client, exchange_rate: er)

    create(:order, client: first_client, rate_used: 10.00)
    create(:order, client: second_client, rate_used: 10.00, order_code: '#DDXXCCDDEEFFDDFFFJJJJJ',
                   transaction_total_value: 112.95)

    login_as(admin)
    visit(root_path)
    within("nav") do
      click_on('Pedidos Pendentes')
    end
    expect(current_path).to eq(orders_path)
    expect(page).to have_content('Pedidos Pendentes')
    expect(page).to have_content('Total: 2')


  end

  it 'mas não existem pedidos pendentes' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit(orders_path)
    expect(page).to have_content('Total: 0')
    expect(page).to have_content('Não existem pedidos pendentes')
  end
end
