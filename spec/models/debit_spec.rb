require 'rails_helper'

RSpec.describe Debit, type: :model do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:rubi_amount) }
      it { should validate_presence_of(:real_amount) }
    end
    context 'numericality' do
      it 'real_amount should be greater than 0' do
        exchange_rate = create(:exchange_rate, :approved)

        debit = Debit.new(real_amount: -11, exchange_rate: exchange_rate)

        debit.valid?
        res = debit.errors[:real_amount]

        expect(res).to include('deve ser maior que 0')
      end
      it 'rubi_amount should be greater than 0' do
        exchange_rate = create(:exchange_rate, :approved)

        debit = Debit.new(rubi_amount: -11, exchange_rate: exchange_rate)
        debit.valid?
        res = debit.errors[:rubi_amount]

        expect(res).to include('deve ser maior que 0')
      end
    end
    context 'belong' do
      it { should belong_to(:client) }
      it { should belong_to(:order) }
      it { should belong_to(:exchange_rate) }
    end
  end
end
