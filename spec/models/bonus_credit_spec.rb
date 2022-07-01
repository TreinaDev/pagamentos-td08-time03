require 'rails_helper'

RSpec.describe BonusCredit, type: :model do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:expiration_date) }
      it { should validate_presence_of(:amount) }
    end

    context 'numericality' do
      it { should validate_numericality_of(:amount) }
    end
  end

  describe 'associations' do
    context 'belongs_to' do
      it { should belong_to(:client) }
    end
  end

  describe 'enum' do
    context 'status' do
      it { should define_enum_for(:status).with_values({ active: 0, expired: 5 }) }
    end
  end

  describe 'methods' do
    context 'builder' do
      it 'build a bonus credit' do
        credit = create(:credit)
        create(:bonus_conversion, client_category: ClientCategory.last)

        bonus_credit = BonusCredit.builder(credit.client, credit.rubi_amount, credit)

        expect(bonus_credit).to be_persisted
      end
    end
    context 'real_amount' do
      it 'retorna o valor do bonus em reais' do
        client = create(:client)
        credit = create(:credit, real_amount: 200, client: client)
        bonus = create(:bonus_credit, credit: credit, amount: 25, client: client)
        expect(bonus.real_amount).to eq(250)
      end
    end
  end
end
