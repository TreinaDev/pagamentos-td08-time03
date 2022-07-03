class Api::V1::ExchangeRatesController < ActionController::API
  include SuspensionService
  before_action :suspend_processing?

  def current
    @exchange_rate = ExchangeRate.current

    render status: 200 if @exchange_rate
  end
end
