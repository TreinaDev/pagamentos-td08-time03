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
  end
  describe 'associations' do
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

        total_client_debits = Debit.all.pluck(:real_amount).map(&:to_f).sum
        expect(total_client_debits).to eq(380)
        expect(client.debits.length).to eq(2)
        expect(client.debits.first.account_type).to eq('bonus_account')
        expect(client.debits.first.real_amount).to eq(180)
        expect(client.debits.second.account_type).to eq('checking_account')
        expect(client.debits.second.real_amount).to eq(200)
        expect(client.balance_bonus).to eq(70)
      end
    end
  end
  describe 'methods' do
    context 'client_category_discount' do
      it 'desconto é aplicado' do
        er = create(:exchange_rate, :approved, real: 10)
        client_categ = create(:client_category, name: 'BASIC', discount: 5)
        client = create(:client, client_category: client_categ)
        create(:credit, real_amount: 5_000, client: client, exchange_rate: er)
        order = create(:order, transaction_total_value: 2_000, client: client)
        debit = create(:debit, real_amount: order.transaction_total_value, client: client, exchange_rate: er, order: order)

        expect(debit.rubi_amount).to eq(190)
        expect(debit.real_amount).to eq(1_900)
        expect(client.balance_rubi).to eq(310)
        expect(client.balance_brl).to eq(3_100)
      end

      it 'desconto da categoria do cliente é 0' do
        er = create(:exchange_rate, :approved, real: 10)
        client_categ = create(:client_category, name: 'BASIC', discount: 0)
        client = create(:client, client_category: client_categ)
        create(:credit, real_amount: 5_000, client: client, exchange_rate: er)
        order = create(:order, transaction_total_value: 2_000, client: client)
        debit = create(:debit, real_amount: order.transaction_total_value, client: client, exchange_rate: er, order: order)

        expect(debit.rubi_amount).to eq(200)
        expect(debit.real_amount).to eq(2_000)
        expect(client.balance_rubi).to eq(300)
        expect(client.balance_brl).to eq(3_000)
      end
    end
  end
end
