require 'rails_helper'

describe 'API de Pagamentos' do
  context 'POST /api/v1/clients/credit' do
    it 'com sucesso' do
      Company.create!(corporate_name: 'E-Commerce', registration_number: '00.000.000/0000-00')
      ExchangeRate.create!(real: 10.00)
      credit_params = {
        client: {
          name: 'João Almeida',
          registration_number: '123.456.789-00'
        },
        company: {
          name: 'E-Commerce',
          registration_number: '00.000.000/0000-00'
        },
        real_amount: 1500.00
      }

      post '/api/v1/clients/credit', params: credit_params

      expect(response).to have_http_status(201)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['credit']['status']).to eq('approved')
      expect(json_response['credit']['real_amount']).to eq('1500.0')
      expect(json_response['credit']['rubi_amount']).to eq('150.0')
      expect(json_response['client']['name']).to eq('João Almeida')
      expect(json_response['client']['registration_number']).to eq('123.456.789-00')
    end

    it 'com dados inválidos' do
      Company.create!(corporate_name: 'E-Commerce', registration_number: '00.000.000/0000-00')
      ExchangeRate.create!(real: 10.00)
      credit_params = {
        client: {
          name: '',
          registration_number: ''
        },
        company: {
          name: '',
          registration_number: ''
        },
        real_amount: ''
      }

      post '/api/v1/clients/credit', params: credit_params

      expect(response).to have_http_status(402)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to include 'Cliente é obrigatório(a)'
      expect(json_response['errors']).to include 'Empresa é obrigatório(a)'
      expect(json_response['errors']).to include 'Valor não pode ficar em branco'
    end
  end
end
