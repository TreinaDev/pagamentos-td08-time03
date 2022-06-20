class ExchangeRatesController < ApplicationController
  before_action :authenticate_approved_admin

  def index
    @exchange_rates = ExchangeRate.all.order(created_at: :desc)
  end

  def new
    @exchange_rate = ExchangeRate.new
  end

  def create
    @exchange_rate = ExchangeRate.new(exchange_rate_params)
    if @exchange_rate.save
      redirect_to exchange_rates_path, notice: 'Taxa de câmbio criada com sucesso.'
    else
      flash.now[:alert] = 'Erro ao criar a taxa.'
      render 'new'
    end
  end

  private

  def exchange_rate_params
    params.require(:exchange_rate).permit(:real)
  end

  def authenticate_approved_admin
      redirect_to root_path if !current_admin.approved?
  end
end
