require 'rails_helper'

RSpec.describe BonusConversion, type: :model do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:start_date) }
      it { should validate_presence_of(:end_date) }
      it { should validate_presence_of(:bonus_percentage) }
      it { should validate_presence_of(:deadline) }
    end

    context "belong" do
      it { should belong_to(:client_category) }
    end

    context "numericality" do
      it { should validate_numericality_of(:deadline).is_greater_than(0) }
      it { should validate_numericality_of(:bonus_percentage).is_greater_than(0) }
      it { should validate_numericality_of(:bonus_percentage).is_less_than(99) }
    end

    context "custom validations" do
      it 'start_date should be greater than end date' do
        bonus = BonusConversion.new(start_date: 10.day.ago, end_date: 12.day.ago)
        bonus.valid?
        res = bonus.errors[:start_date]

        expect(res).to include("deve ser menor que a data final")
      end
    end
  end
end
