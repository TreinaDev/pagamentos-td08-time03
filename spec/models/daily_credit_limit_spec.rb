require 'rails_helper'

RSpec.describe DailyCreditLimit, type: :model do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:value) }
    end
    context 'numericality' do
      it { should validate_numericality_of(:value).is_greater_than(0) }
    end
  end
end
