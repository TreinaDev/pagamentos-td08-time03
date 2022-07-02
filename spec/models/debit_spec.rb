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
    context 'select_account' do
      it 'cliente possui saldo bônus disponível para a compra' do
        client = create(:client)
        credit = create(:credit, client: client)
        create(:bonus_credit, credit: credit, amount: 25, client: client)
        order = create(:order, client: client, transaction_total_value: 200)
        debit = create(:debit, real_amount: order.transaction_total_value, exchange_rate: ExchangeRate.current, client: client, order: order)
        expect(debit.account_type).to eq('bonus_account')
      end
      it 'cliente possui saldo disponível combinado' do
        client = create(:client)
        credit = create(:credit, real_amount: 200, client: client)
        create(:bonus_credit, credit: credit, amount: 25, client: client)
        order = create(:order, client: client, transaction_total_value: 400)
        debit = create(:debit, real_amount: order.transaction_total_value, exchange_rate: ExchangeRate.current, client: client, order: order)
        expect(client.debits.length).to eq(2)
        expect(client.debits.first.account_type).to eq('bonus_account')
        expect(client.debits.first.real_amount).to eq(200)
        expect(client.debits.second.account_type).to eq('checking_account')
        expect(client.debits.second.real_amount).to eq(200)
        expect(client.balance_bonus).to eq(50)
      end
    end
  end
end
