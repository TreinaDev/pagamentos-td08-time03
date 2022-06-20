require 'rails_helper'

describe 'API de Pagamentos' do
  context 'GET /api/v1/exchange_rates/current' do
    it 'com sucesso' do
      create(:exchange_rate)

      get '/api/v1/exchange_rates/current'
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      expect(json_response['status']).to eq('ok')
      expect(json_response['exchange_rate']).to eq('10.0')
    end
  end
end