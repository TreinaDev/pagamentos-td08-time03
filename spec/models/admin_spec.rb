require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:email) }

      it { should validate_presence_of(:password) }

      it { should validate_presence_of(:cpf) }

      it { should validate_presence_of(:full_name) }
    end

    context 'uniqueness' do
      it { should validate_uniqueness_of(:cpf) }

      it { should validate_uniqueness_of(:full_name) }
    end

    context 'length' do
      it { should validate_length_of(:cpf).is_equal_to(11) }
    end
  end

  describe '#full_description' do
    it 'should display name and email' do
      admin = create(:admin, :approved)

      res = admin.full_description

      expect(res).to eq('João | joao@userubis.com.br')
    end
  end
end
