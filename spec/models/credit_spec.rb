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

  
end
