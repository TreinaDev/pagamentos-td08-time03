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

<<<<<<< HEAD
    context 'transactions_extract' do
      it 'sem parâmetros definidos' do
        admin = create(:admin)
        er = create(:exchange_rate, :approved, admin: admin, real: 10)
        company = create(:company)
        client = create(:client)
        credit = create(:credit, real_amount: 500, exchange_rate: er, client: client, company: company)
        order = create(:order, client: client, transaction_total_value: 11.93)
        debit = create(:debit, exchange_rate: er, client: client, order: order)

        expect(client.transactions_extract.length).to eq(2)
        expect(client.transactions_extract[0]).to eq(debit)
        expect(client.transactions_extract[1]).to eq(credit)
      end
      it 'com parâmetro "max" definindo o tamanho máximo do retorno do extrato' do
        admin = create(:admin)
        er = create(:exchange_rate, :approved, admin: admin, real: 10)
        company = create(:company)
        client = create(:client)
        credit = create(:credit, real_amount: 500, exchange_rate: er, client: client, company: company)
        order = create(:order, client: client, transaction_total_value: 11.93)
        debit = create(:debit, exchange_rate: er, client: client, order: order)

        expect(client.transactions_extract(max: 1).length).to eq(1)
        expect(client.transactions_extract(max: 1)[0]).to eq(debit)
=======
    context 'balance_bonus' do
      it 'cliente possui saldo bônus' do
        client = create(:client, registration_number: '123.456.789-00', name: 'João Almeida')
        create(:bonus_credit, client: client, amount: 17.25)
        create(:bonus_credit, client: client, amount: 12.75)

        expect(client.balance_bonus).to eq(30)
      end

      it 'saldo bônus do cliente expirou' do
        client = create(:client)
        create(:bonus_credit, amount: 25, expiration_date: DateTime.now.days_ago(1).to_date, client: client)
        create(:bonus_credit, amount: 100, client: client)

        expect(client.balance_bonus).to eq(100)
        expect(BonusCredit.first.expired?).to eq(true)
      end
    end

    context 'expire_bonus_credit' do
      it 'não expira nenhum crédito bônus' do
        client = create(:client)
        create(:bonus_credit, amount: 25, client: client)
        create(:bonus_credit, amount: 100, client: client)

        client.expire_bonus_credits

        expect(client.bonus_credits.first).to be_active
        expect(client.bonus_credits.find(2)).to be_active
      end

      it 'expira 1 (um) crédito bônus' do
        client = create(:client)
        create(:bonus_credit, amount: 25, expiration_date: DateTime.now.days_ago(1).to_date, client: client)
        create(:bonus_credit, amount: 100, client: client)

        client.expire_bonus_credits

        expect(client.bonus_credits.first).to be_expired
        expect(client.bonus_credits.find(2)).to be_active
      end

      it 'expira 2(dois) créditos bônus' do
        client = create(:client)
        create(:bonus_credit, amount: 25, expiration_date: DateTime.now.days_ago(1).to_date, client: client)
        create(:bonus_credit, amount: 100, expiration_date: DateTime.now.days_ago(2).to_date , client: client)

        client.expire_bonus_credits

        expect(client.bonus_credits.first).to be_expired
        expect(client.bonus_credits.find(2)).to be_expired
>>>>>>> 9b52beef4134719a81f656a829621ade7be4ead3
      end
    end
  end
end
