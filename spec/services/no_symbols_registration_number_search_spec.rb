require 'rails_helper'

describe NoSymbolsRegistrationNumberSearcher do
  describe '.search' do
    context 'consulta de cliente por CPF' do
      it 'com sucesso' do
        client = create(:client, registration_number: '123.456.789-00')

        client_search = NoSymbolsRegistrationNumberSearcher.new('123.456.789-00').search

        expect(client_search.registration_number).to eq(client.registration_number)
        expect(client_search.name).to eq(client.name)
      end

      it 'com sucesso sem pontos e traço' do
        client = create(:client, registration_number: '123.456.789-00')

        client_search = NoSymbolsRegistrationNumberSearcher.new('12345678900').search

        expect(client_search.registration_number).to eq(client.registration_number)
        expect(client_search.name).to eq(client.name)
      end

      it 'e o cliente não está cadastrado' do
        client = create(:client, registration_number: '123.456.789-00')

        client_search = NoSymbolsRegistrationNumberSearcher.new('987.654.321-00').search
        
        expect(client_search).to eq(nil)
      end
    end

    context 'consulta de cliente por CNPJ' do
      it 'com sucesso' do
        client = create(:client, registration_number: '99.521.666/0001-98')

        client_search = NoSymbolsRegistrationNumberSearcher.new('99.521.666/0001-98').search

        expect(client_search.registration_number).to eq(client.registration_number)
        expect(client_search.name).to eq(client.name)
      end

      it 'com sucesso sem pontos, barra e traço' do
        client = create(:client, registration_number: '99.521.666/0001-98')

        client_search = NoSymbolsRegistrationNumberSearcher.new('99521666000198').search

        expect(client_search.registration_number).to eq(client.registration_number)
        expect(client_search.name).to eq(client.name)
      end

      it 'e o cliente não está cadastrado' do
        client = create(:client, registration_number: '99.521.666/0001-98')

        client_search = NoSymbolsRegistrationNumberSearcher.new('98.666.521/0001-99').search
        
        expect(client_search).to eq(nil)
      end
    end
  end
end