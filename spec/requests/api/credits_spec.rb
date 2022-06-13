require 'rails_helper'

describe 'API de Pagamentos' do
  context 'POST /api/v1/clients/1/credit' do
    it 'com sucesso' do
      c = Client.create!(name: 'João', registration_number: '000.000.000-00')
      Company.create!(corporate_name: 'E-Commerce', registration_number: '00.000.000/0000-00')
      ExchangeRate.create!(real: 10.00)
      credit_params = {
        client_id: 1,
        company_id: 1,
        real_amount: 1500.00
      }

      post '/api/v1/clients/1/credit', params: credit_params

      expect(response).to have_http_status(201)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq('approved')
      expect(json_response['real_amount']).to eq('1500.0')
      expect(json_response['rubi_amount']).to eq('150.0')
      expect(json_response['id']).to eq(1)
      expect(json_response['client_id']).to eq(c.id)
    end

    it 'com dados inválidos' do 
      c = Client.create!(name: 'João', registration_number: '000.000.000-00')
      Company.create!(corporate_name: 'E-Commerce', registration_number: '00.000.000/0000-00')
      ExchangeRate.create!(real: 10.00)
      credit_params = {
        client_id: '',
        company_id: '',
        real_amount: ''
      }

      post '/api/v1/clients/1/credit', params: credit_params

      expect(response).to have_http_status(402)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to include 'Cliente é obrigatório(a)'
      expect(json_response['errors']).to include 'Empresa é obrigatório(a)'
      expect(json_response['errors']).to include 'Valor não pode ficar em branco'
    end
  end
end
