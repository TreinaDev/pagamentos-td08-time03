require 'rails_helper'

RSpec.describe Approval, type: :model do
  describe 'email' do
    context "presence" do
      it { should validate_presence_of(:super_admin_email) }

      it { should validate_presence_of(:admin) }
    end
  end
end
