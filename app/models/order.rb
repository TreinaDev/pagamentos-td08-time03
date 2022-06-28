class Order < ApplicationRecord
  belongs_to :client
  belongs_to :exchange_rate
end
