class Order < ApplicationRecord
  belongs_to :client
  belongs_to :exchange_rate
  validate :check_client_balance, on: :create
  validates :order_code, :transaction_total_value, presence: true
  enum status: { pending: 0, approved: 5, rejected: 10 }

  private

  def check_client_balance
    return if client.present? && client.balance_brl >= transaction_total_value

    errors.add(:client, :insufficient_balance)
  end
end
