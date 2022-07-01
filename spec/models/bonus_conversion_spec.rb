require 'rails_helper'

RSpec.describe BonusConversion, type: :model do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:start_date) }
      it { should validate_presence_of(:end_date) }
      it { should validate_presence_of(:bonus_percentage) }
      it { should validate_presence_of(:deadline) }
    end

    context 'belong' do
      it { should belong_to(:client_category) }
    end

    context 'numericality' do
      it { should validate_numericality_of(:deadline).is_greater_than(0) }
      it { should validate_numericality_of(:bonus_percentage).is_greater_than(0) }
    end

    context 'custom validations' do
      it 'start_date should be greater than end date' do
        bonus = BonusConversion.new(start_date: 10.days.ago, end_date: 12.days.ago)
        bonus.valid?
        res = bonus.errors[:start_date]

        expect(res).to include('deve ser menor que a data final')
      end

      it 'with client category and start date already covered' do
        client_categ = create(:client_category, name: 'PREMIUM')
        first_bc = create(:bonus_conversion, start_date: '23/06/2022', end_date: '11/10/2022', bonus_percentage: 12.5,
                          deadline: 4, client_category: client_categ)
        second_bc = BonusConversion.new(start_date: '25/06/2022', end_date: '01/11/2022', bonus_percentage: 15,
                                        deadline: 4, client_category: client_categ)

        second_bc.valid?

        expect(second_bc.errors.full_messages).to include('Período já contemplado para essa categoria')
      end

      it 'with client category and end date already covered' do
        client_categ = create(:client_category, name: 'PREMIUM')
        first_bc = create(:bonus_conversion, start_date: '23/06/2022', end_date: '11/10/2022', bonus_percentage: 12.5,
                          deadline: 4, client_category: client_categ)
        second_bc = BonusConversion.new(start_date: '01/06/2022', end_date: '01/10/2022', bonus_percentage: 15,
                                        deadline: 4, client_category: client_categ)

        second_bc.valid?

        expect(second_bc.errors.full_messages).to include('Período já contemplado para essa categoria')
      end

      it 'with period already covered, but different client category' do
        first_client_categ = create(:client_category, name: 'BASIC')
        second_client_categ = create(:client_category, name: 'PREMIUM')
        first_bc = create(:bonus_conversion, start_date: '23/06/2022', end_date: '11/10/2022', bonus_percentage: 12.5,
                          deadline: 4, client_category: first_client_categ)
        second_bc = BonusConversion.new(start_date: '23/06/2022', end_date: '11/10/2022', bonus_percentage: 15,
                                        deadline: 4, client_category: second_client_categ)

        expect(second_bc.valid?).to eq(true)
      end
    end
  end
end
