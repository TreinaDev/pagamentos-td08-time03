class ExchangeRateApproval < ApplicationRecord
  belongs_to :admin
  belongs_to :exchange_rate
end
