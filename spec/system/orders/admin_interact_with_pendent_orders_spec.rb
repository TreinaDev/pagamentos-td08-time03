require 'rails_helper'

describe 'Administrador acessa página de pedidos pendentes' do
  it 'e aprova um pedido' do
    admin = create(:admin, :approved)
    er = create(:exchange_rate, :approved, admin: admin)
    company = create(:company)
    client_category = create(:client_category, discount: 0)
    first_client = create(:client, registration_number: '987.654.321-01', name: 'Sergio', client_category: client_category)
    create(:credit, real_amount: 100, company: company, client: first_client, exchange_rate: er)
    order = create(:order, client: first_client, rate_used: 10.00, transaction_total_value: 44.33)
    json_data = {
      order_code: order.order_code,
      order_status: 'paid'
    }.to_json
    fake_response = double('faraday_response', status: 204)
    allow(Faraday).to receive(:patch).with('http://localhost:3000/api/v1/orders/update_status', json_data, content_type: 'application/json').and_return(fake_response)

    login_as(admin)
    visit root_path
    visit orders_path
    within('.pending_order-0') do
      click_on('Aprovar')
    end

    expect(page).to have_content('Pedido aprovado com sucesso')
    expect(page).not_to have_content('#AABBCCDDEEFFGGHHIIJJKKK')
    expect(page).not_to have_content('Sergio')
    expect(page).not_to have_content('987.654.321-01')
    expect(page).not_to have_content('R$ 2,99')
    expect(page).not_to have_button('Aprovar')
    expect(page).not_to have_button('Reprovar')
    expect(Order.last.approved?).to eq(true)
    expect(Client.last.balance_brl.to_f).to eq(55.67)
    expect(Client.last.balance_rubi.to_f).to eq(5.567)
  end

  it 'e reprova um pedido' do
    admin = create(:admin, :approved)
    er = create(:exchange_rate, :approved, admin: admin)
    company = create(:company)
    first_client = create(:client, registration_number: '987.654.321-01', name: 'Sergio')
    create(:credit, real_amount: 100, company: company, client: first_client, exchange_rate: er)
    order = create(:order, client: first_client, rate_used: 10.00, transaction_total_value: 44.33)
    json_data = {
      order_code: order.order_code,
      order_status: 'refused'
    }.to_json
    fake_response = double('faraday_response', status: 204)
    allow(Faraday).to receive(:patch).with('http://localhost:3000/api/v1/orders/update_status', json_data, content_type: 'application/json').and_return(fake_response)

    login_as(admin)
    visit root_path
    visit orders_path
    within('.pending_order-0') do
      click_on('Reprovar')
    end

    expect(page).to have_content('Pedido reprovado com sucesso')
    expect(page).not_to have_content('#AABBCCDDEEFFGGHHIIJJKKK')
    expect(page).not_to have_content('Sergio')
    expect(page).not_to have_content('987.654.321-01')
    expect(page).not_to have_content('R$ 2,99')
    expect(page).not_to have_button('Aprovar')
    expect(page).not_to have_button('Reprovar')
    expect(Order.last.approved?).to eq(false)
    expect(Client.last.balance_brl.to_f).to eq(100)
    expect(Client.last.balance_rubi.to_f).to eq(10)
  end
end
