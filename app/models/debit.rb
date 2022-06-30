class Debit < ApplicationRecord
  belongs_to :exchange_rate
  belongs_to :client
  belongs_to :order
end
