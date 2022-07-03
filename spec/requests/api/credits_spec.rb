require 'rails_helper'

describe 'API de Pagamentos' do
  context 'POST /api/v1/clients/credit' do
    it 'com sucesso e o cliente ainda não está cadastrado' do
      company = create(:company)
      create(:exchange_rate, :approved)
      create(:client_category)
      credit_params = {
        client: {
          name: 'João Almeida',
          registration_number: '123.456.789-00'
        },
        company: {
          name: company.corporate_name,
          registration_number: company.registration_number
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

    it 'com sucesso e o cliente já está cadastrado' do
      client = create(:client)
      company = create(:company)
      create(:exchange_rate, :approved)
      old_balance = client.credits.sum(:rubi_amount)
      balance = client.credits
      credit_params = {
        client: {
          name: 'João Almeida',
          registration_number: '123.456.789-00'
        },
        company: {
          name: company.corporate_name,
          registration_number: company.registration_number
        },
        real_amount: 1500.00
      }

      post '/api/v1/clients/credit', params: credit_params
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(201)
      expect(response.content_type).to include 'application/json'
      expect(json_response['credit']['status']).to eq('approved')
      expect(json_response['credit']['real_amount']).to eq('1500.0')
      expect(json_response['credit']['rubi_amount']).to eq('150.0')
      expect(Credit.last.client.registration_number).to eq('123.456.789-00')
      expect(Credit.last.client.name).to eq('João Almeida')
      expect(balance.sum(:rubi_amount)).not_to eq(old_balance)
    end

    it 'com dados inválidos' do
      create(:company)
      create(:exchange_rate, :approved)
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
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(402)
      expect(response.content_type).to include 'application/json'
      expect(json_response['errors']).to include 'Cliente é obrigatório(a)'
      expect(json_response['errors']).to include 'Empresa é obrigatório(a)'
      expect(json_response['errors']).to include 'Valor não pode ficar em branco'
    end

    it 'e o sistema de pagamentos está suspenso' do
      create(:client)
      create(:company)
      create(:exchange_rate, :approved, created_at: DateTime.now.days_ago(4))
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
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(503)
      expect(response.content_type).to include 'application/json'
      expect(json_response['errors']).to include 'Sistema de pagamentos suspenso'
      expect(Credit.last).to be_nil
    end
  end
end
