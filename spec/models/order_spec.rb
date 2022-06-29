require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:order_code) }
      it { should validate_presence_of(:transaction_total_value) }
    end
  end

  describe 'associations' do
    context 'belongs_to' do
      it { should belong_to(:client) }
      it { should belong_to(:exchange_rate) }
    end
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values({ pending: 0, approved: 5, rejected: 10 }) }
  end
end
