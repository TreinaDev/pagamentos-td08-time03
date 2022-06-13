require 'rails_helper'

RSpec.describe Credit, type: :model do
  describe 'validation' do
    context 'presence' do
      it { should validate_presence_of(:real_amount) }
      it { should validate_presence_of(:rubi_amount) }
    end

    context 'numericality' do
      it { should validate_numericality_of(:real_amount) }
      it { should validate_numericality_of(:rubi_amount) }
    end
  end
end
