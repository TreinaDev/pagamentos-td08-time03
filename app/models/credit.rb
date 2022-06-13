class Credit < ApplicationRecord
  belongs_to :exchange_rate
  belongs_to :client
  belongs_to :company

  enum status: { pending: 0, approved: 5, rejected: 10 }

  validates :real_amount, :rubi_amount, presence: true
  validates :real_amount, :rubi_amount, numericality: true
end
