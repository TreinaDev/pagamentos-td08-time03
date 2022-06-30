class Debit < ApplicationRecord
  belongs_to :exchange_rate
  belongs_to :client
  belongs_to :order
  before_create :rubi_value

  private

  def rubi_value
    self.rubi_amount = real_amount / exchange_rate.real if real_amount
  end
end
