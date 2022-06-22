require 'rails_helper'

describe 'REQUEST - Admin aprova uma taxa de câmbio' do
  it 'com sucesso' do
    first_admin = create(:admin, :approved, full_name: 'Fernando', email: 'fernando@userubis.com.br', cpf: '12555778904', password: '123456')
    second_admin = create(:admin, :approved)
    exchange_rate = create(:exchange_rate, admin: first_admin)

    login_as(second_admin)
    post(create_exchange_rate_approvals_path(exchange_rate),
         params: { exchange_rate: { admin: second_admin } })

    expect(exchange_rate.exchange_rate_approvals.count).to eq(2)
    expect(ExchangeRate.last.approved?).to eq(true)
  end

  it 'com falha caso o Admin logado tenha criado a taxa' do
    first_admin = create(:admin, :approved, full_name: 'Fernando', email: 'fernando@userubis.com.br', cpf: '12555778904', password: '123456')
    exchange_rate = create(:exchange_rate, admin: first_admin)

    login_as(first_admin)
    post(create_exchange_rate_approvals_path(exchange_rate), params: { exchange_rate: { admin: first_admin } })

    expect(exchange_rate.exchange_rate_approvals.count).not_to eq(2)
    expect(exchange_rate.approved?).to eq(false)
  end
end
