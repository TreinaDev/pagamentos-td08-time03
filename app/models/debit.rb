class Debit < ApplicationRecord
  belongs_to :exchange_rate
  belongs_to :client
  belongs_to :order
  before_validation :rubi_value
  validates :rubi_amount, :real_amount, presence: true
  validates :real_amount, :rubi_amount, numericality: { greater_than: 0 }
  before_create :select_account

  enum account_type: { checking_account: 0, bonus_account: 5 }

  private

  def rubi_value
    self.rubi_amount = real_amount / exchange_rate.real if real_amount
  end

  def select_account
    return if client.balance_brl > real_amount || bonus_account?

    if client.balance_bonus >= real_amount
      self.account_type = 'bonus_account'
    else
      bonus_debit = Debit.new(real_amount: real_amount - client.balance_brl, account_type: :bonus_account,
                              exchange_rate: exchange_rate, order: order, client: client)
      self.real_amount = client.balance_brl
      rubi_value
      bonus_debit.save!
    end
  end
end
