class Api::V1::ExchangeRatesController < ActionController::API
  def current
    @exchange_rate = ExchangeRate.current
    if @exchange_rate
      render status: 200
    else
      render status: 200, json: { errors: 'Nenhuma taxa cadastrada' }
    end
  end
end
