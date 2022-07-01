require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:order_code) }
      it { should validate_presence_of(:transaction_total_value) }
      it { should validate_presence_of(:rate_used) }
    end

    context 'numericality' do
      it { should validate_numericality_of(:transaction_total_value).is_greater_than_or_equal_to(0) }
    end
  end

  describe 'associations' do
    context 'belongs_to' do
      it { should belong_to(:client) }
    end
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values({ pending: 0, approved: 5, rejected: 10 }) }
  end
end
