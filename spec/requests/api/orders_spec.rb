require 'rails_helper'

describe 'API de Pagamentos' do
  context 'POST /api/v1/orders' do
    it 'com sucesso' do
      credit = create(:credit, :approved)
      client = credit.client
      order_params = {
        order_code: 'ABCDEFG12356KAJSD',
        client: {
          name: client.name,
          registration_number: client.registration_number
        },
        transaction_total_value: 1.0
      }

      post '/api/v1/orders', params: order_params
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(201)
      expect(response.content_type).to include 'application/json'
      expect(json_response['order']['id']).to eq(1)
      expect(json_response['order']['status']).to eq('pending')
      expect(json_response['order']['client']['name']).to eq(client.name)
      expect(json_response['order']['client']['registration_number']).to eq(client.registration_number)
      expect(Order.all.count).to eq(1)
    end

    it 'e o cliente não está cadastrado' do
      create(:exchange_rate, :approved)
      order_params = {
        order_code: 'ABCDEFG12356KAJSD',
        client: {
          name: 'Fernando Albuquerque Menezes',
          registration_number: '542.504.948-48'
        },
        transaction_total_value: 55.0
      }

      post '/api/v1/orders', params: order_params
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(412)
      expect(response.content_type).to include 'application/json'
      expect(json_response['errors']).to include 'Usuário não encontrado'
      expect(json_response).not_to include 'order'
      expect(Order.all.count).to eq(0)
    end

    it 'e o cliente não possui saldo suficiente' do
      credit = create(:credit, :approved)
      client = credit.client
      order_params = {
        order_code: 'ABCDEFG12356KAJSD',
        client: {
          name: client.name,
          registration_number: client.registration_number
        },
        transaction_total_value: 100.0
      }

      post '/api/v1/orders', params: order_params
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(412)
      expect(response.content_type).to include 'application/json'
      expect(json_response['errors']).to include 'Saldo do cliente insuficiente'
      expect(Order.all.count).to eq(0)
    end
  end
end
