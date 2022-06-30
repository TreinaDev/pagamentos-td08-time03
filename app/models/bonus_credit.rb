class BonusCredit < ApplicationRecord
  belongs_to :client

  enum status: { active: 0, expired: 5 }

  def self.builder(client, rubi_amount)
    bonus_conversion = BonusConversion.where('client_category_id = ? AND start_date <= ? AND ? <= end_date',
                                             client.client_category, Date.current, Date.current).first
    unless bonus_conversion
      return bonus_credit = BonusCredit.new(amount: 0)
    end

    bonus_credit = BonusCredit.new
    bonus_credit.expiration_date = bonus_conversion.deadline.days.from_now.to_date
    bonus_credit.amount = (rubi_amount * bonus_conversion.bonus_percentage) / 100
    bonus_credit.client = client
    bonus_credit.save!
    bonus_credit
  end
end
