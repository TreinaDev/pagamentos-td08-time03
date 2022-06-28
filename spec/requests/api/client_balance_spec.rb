require 'rails_helper'

describe 'API de Pagamentos' do
  context 'GET /api/v1/clients/balance' do
    it 'com sucesso' do
      admin = create(:admin, :approved)
      er = create(:exchange_rate, :approved, admin: admin, real: 10)
      company = create(:company)
      client = create(:client, registration_number: '123.456.789-00', name: 'João Almeida')
      create(:credit, real_amount: 500, exchange_rate: er, client: client, company: company)
      create(:credit, real_amount: 650, exchange_rate: er, client: client, company: company)      

      get '/api/v1/clients/balance'
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      expect(json_response['client']['registration_number']).to eq('123.456.789-00')
      expect(json_response['client']['name']).to eq('João Almeida')
      expect(json_response['client']['balance_rubi']).to eq(115)
      expect(json_response['client']['balance_brl']).to eq(1150)
    end
  end
end