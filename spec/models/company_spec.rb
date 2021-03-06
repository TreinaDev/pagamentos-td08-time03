require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:corporate_name) }
      it { should validate_presence_of(:registration_number) }
    end

    context 'format' do
      it { should allow_value('12.345.678/0001-90').for(:registration_number) }
      it { should_not allow_value('12345678000190').for(:registration_number) }
    end
  end

  describe 'associations' do
    context 'has_many' do
      it { should have_many(:credits) }
    end
  end
end
