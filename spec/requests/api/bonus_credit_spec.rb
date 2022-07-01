require 'rails_helper'

describe 'API de Pagamentos' do
  context 'POST /api/v1/clients/credit' do
    it 'com sucesso e adiciona crédito bonus' do
      company = create(:company)
      create(:exchange_rate, :approved)
      bc = create(:bonus_conversion)
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
      expect(json_response['client']['registration_number']).to eq('123.456.789-00')
      expect(json_response['client']['name']).to eq('João Almeida')
      expect(json_response['credit']['status']).to eq('approved')
      expect(json_response['credit']['real_amount']).to eq('1500.0')
      expect(json_response['credit']['rubi_amount']).to eq('150.0')
      expect(json_response['bonus_credit']['amount']).to eq('22.5')
    end

    it 'com sucesso e não tem conversão bônus ativa' do
      company = create(:company)
      create(:exchange_rate, :approved)
      create(:bonus_conversion, start_date: 1.day.from_now.to_date, end_date: 30.days.from_now.to_date)
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
      expect(json_response['client']['registration_number']).to eq('123.456.789-00')
      expect(json_response['client']['name']).to eq('João Almeida')
      expect(json_response['credit']['status']).to eq('approved')
      expect(json_response['credit']['real_amount']).to eq('1500.0')
      expect(json_response['credit']['rubi_amount']).to eq('150.0')
      expect(json_response.keys).not_to include 'bonus_credit'
    end
  end
end
