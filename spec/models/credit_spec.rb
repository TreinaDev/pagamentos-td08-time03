require 'rails_helper'

RSpec.describe Credit, type: :model do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:real_amount) }
      it { should validate_presence_of(:rubi_amount) }
    end

    context 'numericality' do
      it { should validate_numericality_of(:real_amount) }
      it { should validate_numericality_of(:rubi_amount) }
    end
  end

  describe 'associations' do
    context 'belongs_to' do
      it { should belong_to(:company) }
      it { should belong_to(:client) }
      it { should belong_to(:exchange_rate) }
    end
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values({ pending: 0, approved: 5, rejected: 10 }) }
  end

  describe 'methods' do
    context 'validates_client_last_credit' do 
      it 'não existe um limite de crédito diário' do
        admin = create(:admin, :approved)
        er = create(:exchange_rate, admin: admin)
        client = create(:client)
        first_credit = create(:credit, real_amount: 5_000, exchange_rate: er, client: client)
        second_credit = create(:credit, real_amount: 10_000, exchange_rate: er, client: client)
        third_credit = create(:credit, real_amount: 15_000, exchange_rate: er, client: client)


        expect(first_credit.status).to eq ('approved')
        expect(second_credit.status).to eq ('approved')
        expect(third_credit.status).to eq ('approved')
      end

      it 'e os créditos estão abaixo do limite diário' do
        admin = create(:admin, :approved)
        er = create(:exchange_rate, admin: admin)
        client = create(:client)
        create(:daily_credit_limit, value: 10_000)
        first_credit = create(:credit, real_amount: 5_000, exchange_rate: er, client: client, created_at: DateTime.now.yesterday)
        second_credit = create(:credit, real_amount: 9_000, exchange_rate: er, client: client)

        expect(first_credit.status).to eq ('approved')
        expect(second_credit.status).to eq ('approved')
      end

      it 'e os créditos estão acima do limite diário' do
        admin = create(:admin, :approved)
        er = create(:exchange_rate, admin: admin)
        client = create(:client)
        create(:daily_credit_limit, value: 10_000)
        first_credit = create(:credit, real_amount: 5_000, exchange_rate: er, client: client)
        second_credit = create(:credit, real_amount: 9_000, exchange_rate: er, client: client)

        expect(first_credit.status).to eq ('approved')
        expect(second_credit.status).to eq ('pending')        
      end
    end
  end
end
