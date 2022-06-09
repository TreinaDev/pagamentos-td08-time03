require 'rails_helper'

RSpec.describe ExchangeRate, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:real) }
    it { should validate_numericality_of(:real) }
  end
end
