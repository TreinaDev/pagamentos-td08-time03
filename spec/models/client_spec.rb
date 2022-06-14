require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'validation' do
    context 'presence' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:registration_number) }
    end
  end
end
