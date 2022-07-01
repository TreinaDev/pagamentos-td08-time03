require 'rails_helper'

describe 'Desconto de uma categoria de cliente é aplicado no pagamento' do
  it 'com sucesso' do
    admin = create(:admin, :approved)
    client_categ = create(:client_category, name: 'BASIC', discount: 5)
    client = create(:client, client_category: client_categ)
    create(:credit, real_amount: 5000, client: client)
    create(:order, :approved, transaction_total_value: 200)

    login_as(admin)
    visit search_clients_path
    fill_in 'CPF/CNPJ', with: client.registration_number
    click_on 'Consultar'

    expect(page).to have_content('Saldo: RB 310.0 (R$ 3.100,00)')
  end

  # it 'mas o desconto é nulo' do

  # end
end