class ExchangeRateApproval < ApplicationRecord
  belongs_to :admin
  belongs_to :exchange_rate
  after_save :update_exchange_rate_status

  private

  def update_exchange_rate_status
    exchange_rate.exchange_rate_approvals.count == 2 && exchange_rate.approved!
  end
end
