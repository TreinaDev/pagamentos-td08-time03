require 'rails_helper'

describe 'API de Pagamentos' do
  context 'GET /api/v1/exchange_rates/current' do
    it 'com sucesso' do
      create(:exchange_rate, :approved)

      get '/api/v1/exchange_rates/current'
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      expect(json_response['exchange_rate']['value']).to eq('10.0')
    end

    it 'mas não existe taxa de câmbio cadastrada' do
      get '/api/v1/exchange_rates/current'
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(503)
      expect(response.content_type).to include 'application/json'
      expect(json_response).not_to include 'exchange_rate'
      expect(json_response['errors']).to include 'Sistema de pagamentos suspenso'
    end
  end
end
