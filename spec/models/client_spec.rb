require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:registration_number) }
    end

    context 'format' do
      it { should allow_value('123.456.789-10').for(:registration_number) }
      it { should allow_value('12.345.678/0001-90').for(:registration_number) }
      it { should_not allow_value('12345678910').for(:registration_number) }
      it { should_not allow_value('12345678000190').for(:registration_number) }
    end
  end

  describe 'associations' do
    context 'has_many' do
      it { should have_many(:credits) }
    end
  end

  describe 'methods' do
    context 'balance_rubi' do
      it 'cliente sem saldo' do
        client = create(:client)

        expect(client.balance_rubi).to eq(0)
      end

      it 'cliente possui saldo' do
        er = create(:exchange_rate, :approved, real: 10)
        company = create(:company)
        client = create(:client)
        create(:credit, real_amount: 500, exchange_rate: er, client: client, company: company)
        create(:credit, real_amount: 650, exchange_rate: er, client: client, company: company)

        expect(client.balance_rubi).to eq(115)
      end
    end

    context 'balance_brl' do
      it 'cliente sem saldo' do
        client = create(:client)

        expect(client.balance_brl).to eq(0)
      end

      it 'cliente possui saldo' do
        er = create(:exchange_rate, :approved, real: 10)
        company = create(:company)
        client = create(:client)
        create(:credit, real_amount: 500, exchange_rate: er, client: client, company: company)
        create(:credit, real_amount: 650, exchange_rate: er, client: client, company: company)

        expect(client.balance_brl).to eq(1150)
      end
    end

    context 'balance_bonus' do
      it 'cliente possui saldo bônus' do
        er = create(:exchange_rate, :approved, real: 10)
        company = create(:company)
        client_category = create(:client_category)
        client = create(:client, registration_number: '123.456.789-00', name: 'João Almeida',
                        client_category: client_category)
        create(:bonus_conversion, bonus_percentage: 15, client_category: client_category)
        create(:credit, real_amount: 500, exchange_rate: er, client: client, company: company)
        create(:credit, real_amount: 650, exchange_rate: er, client: client, company: company)

        expect(client.balance_bonus).to eq(17.25)        
      end

      it 'saldo bônus do cliente expirou' do
        client = create(:client)
        bonus_credit = create(:bonus_credit, expiration_date: 1.day.ago.to_date, client: client)

        expect(client.balance_bonus).to eq(0)    
        expect(bonus_credit.expired?).to eq(true)    
      end
    end
  end
end
