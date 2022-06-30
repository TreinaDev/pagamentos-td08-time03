require 'rails_helper'

RSpec.describe ClientCategory, type: :model do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:discount) }
    end
    context 'numericality' do
      it { should validate_numericality_of(:discount).is_greater_than(0) }
      it { should validate_numericality_of(:discount).is_less_than(99) }
    end
    context 'uniqueness' do
      it { should validate_uniqueness_of(:name).case_insensitive }
    end
    context 'length' do
      it { should validate_length_of(:name).is_at_most(15) }
    end
  end
end
