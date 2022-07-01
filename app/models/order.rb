class Order < ApplicationRecord
  belongs_to :client
  belongs_to :exchange_rate, optional: true
  validate :check_client_balance, on: :create
  validate :check_exchange_rate, on: :create
  validates :order_code, :transaction_total_value, :rate_used, presence: true
  validates :transaction_total_value, numericality: { greater_than_or_equal_to: 0 }
  enum status: { pending: 0, approved: 5, rejected: 10 }

  private

  def check_exchange_rate
    if ExchangeRate.current && ExchangeRate.current.real == rate_used.to_d
      self.exchange_rate = ExchangeRate.current
    else
      errors.add(:exchange_rate, :outdated_exchange_rate)
    end
  end

  def check_client_balance
    return if client.present? && client.balance_brl + client.balance_bonus >= transaction_total_value

    errors.add(:client, :insufficient_balance)
  end
end
