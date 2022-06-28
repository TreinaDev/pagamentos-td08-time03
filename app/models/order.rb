class Order < ApplicationRecord
  belongs_to :client
  belongs_to :exchange_rate

  enum status: { pending: 0, approved: 5, rejected: 10 }
end
