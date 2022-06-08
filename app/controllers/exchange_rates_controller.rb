class ExchangeRatesController < ApplicationController
  def index; end

  def new
    @exchange_rate = ExchangeRate.new
  end
end