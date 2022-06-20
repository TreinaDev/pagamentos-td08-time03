class ExchangeRateApprovalsController < ApplicationController
  def index
    @pending_exchange_rates = ExchangeRate.where.not(admin: current_admin).merge(ExchangeRate.where(status: 0))
  end
end
