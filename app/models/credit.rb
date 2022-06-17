class Credit < ApplicationRecord
  belongs_to :exchange_rate
  belongs_to :client
  belongs_to :company

  enum status: { pending: 0, approved: 5, rejected: 10 }

  validates :real_amount, :rubi_amount, presence: true
  validates :real_amount, :rubi_amount, numericality: true

  def self.builder(client, credit_params, company, exchange_rate)
    credit = Credit.new(credit_params)
    credit.client = client if client.valid?
    credit.company = company
    credit.exchange_rate = exchange_rate
    credit.rubi_amount = credit.real_amount / exchange_rate.real if credit.real_amount
    credit
  end
end
