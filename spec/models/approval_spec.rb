require 'rails_helper'

RSpec.describe Approval, type: :model do
  describe 'email' do
    context "presence" do
      it { should validate_presence_of(:super_admin_email) }

      it { should validate_presence_of(:admin) }
    end

    context 'custom validations' do
      it 'email not allowed when admin doesnt exist' do
        admin = create(:admin)
        approval = Approval.new(super_admin_email: "unknown@userubis.com.br", admin: admin)

        approval.valid?
        result = approval.errors.include? :super_admin_email

        expect(result).to be(true)
        expect(approval.errors[:super_admin_email]).to include("deve pertencer a algum Admin cadastrado")
      end
    end
  end
end
