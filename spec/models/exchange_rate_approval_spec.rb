require 'rails_helper'

RSpec.describe ExchangeRateApproval, type: :model do
  describe 'validations' do
    it { should belong_to(:admin) }
    it { should belong_to(:exchange_rate) }
  end
end
