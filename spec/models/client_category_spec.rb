require 'rails_helper'

RSpec.describe ClientCategory, type: :model do
 describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:discount) }
    end
    context "numericality" do
      it { should validate_numericality_of(:discount).is_greater_than(0) }
    end
  end
end
