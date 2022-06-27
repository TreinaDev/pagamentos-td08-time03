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
        admin = create(:admin)
        er = create(:exchange_rate, :approved, admin: admin, real: 10)
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
        admin = create(:admin)
        er = create(:exchange_rate, :approved, admin: admin, real: 10)
        company = create(:company)
        client = create(:client)
        create(:credit, real_amount: 500, exchange_rate: er, client: client, company: company)
        create(:credit, real_amount: 650, exchange_rate: er, client: client, company: company)

        expect(client.balance_brl).to eq(1150)
      end
    end
  end
end
