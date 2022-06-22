class Api::V1::ExchangeRatesController < ActionController::API
  include PaymentSuspensionService
  before_action :suspend_payment_processing

  def current
    @exchange_rate = ExchangeRate.where(status: 'approved').last
    render status: 200 if @exchange_rate
  end
end
