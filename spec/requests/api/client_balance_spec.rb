require 'rails_helper'

describe 'API de Pagamentos' do
  context 'POST /api/v1/clients/balance' do
    it 'com sucesso e o cliente já está cadastrado' do
      admin = create(:admin, :approved)
      er = create(:exchange_rate, :approved, admin: admin, real: 10)
      company = create(:company)
      client = create(:client, registration_number: '123.456.789-00', name: 'João Almeida')
      create(:credit, real_amount: 500, exchange_rate: er, client: client, company: company)
      create(:credit, real_amount: 650, exchange_rate: er, client: client, company: company)
      client_params = { client: { registration_number: '123.456.789-00' } }

      post '/api/v1/clients/balance', params: client_params
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      expect(json_response['client']['registration_number']).to eq('123.456.789-00')
      expect(json_response['client']['name']).to eq('João Almeida')
      expect(json_response['client']['balance_rubi']).to eq('115.0')
      expect(json_response['client']['balance_brl']).to eq('1150.0')
    end

    it 'com sucesso e o cliente não está cadastrado' do
      client_params = { client: { registration_number: '123.456.789-00', name: 'João Almeida' } }

      post '/api/v1/clients/balance', params: client_params
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      expect(json_response['client']['registration_number']).to eq('123.456.789-00')
      expect(json_response['client']['name']).to eq('João Almeida')
      expect(json_response['client']['balance_rubi']).to eq(0)
      expect(json_response['client']['balance_brl']).to eq(0)
    end

    it 'com dados inválidos' do
      client_params = { client: { registration_number: '', name: '' } }

      post '/api/v1/clients/balance', params: client_params
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(402)
      expect(response.content_type).to include 'application/json'
      expect(json_response['errors']).to include 'CPF/CNPJ é obrigatório(a)'
      expect(json_response['errors']).to include 'Nome é obrigatório(a)'
    end
  end
end