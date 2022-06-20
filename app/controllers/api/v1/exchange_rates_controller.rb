class Api::V1::ExchangeRatesController < ActionController::API
  def current
    @exchange_rate = ExchangeRate.last
  end
end