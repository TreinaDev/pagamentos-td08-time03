class ExchangeRatesController < ApplicationController
  before_action :authenticate_approved_admin

  def index
    @exchange_rates = ExchangeRate.all_approved
  end

  def new
    @exchange_rate = ExchangeRate.new
  end

  def create
    @exchange_rate = ExchangeRate.new(exchange_rate_params)
    @exchange_rate.admin = current_admin
    approval = ExchangeRateApproval.new(admin: current_admin, exchange_rate: @exchange_rate)

    if @exchange_rate.save
      approval.save
      if ExchangeRate.where(status: 10).count.zero? || (ExchangeRate.fluctuation(@exchange_rate) && ExchangeRate.fluctuation(@exchange_rate).abs <= 10.0)
        ExchangeRateApproval.create!(admin: current_admin, exchange_rate: @exchange_rate)
        redirect_to exchange_rates_path, notice: 'Taxa de câmbio criada com sucesso.'
      else
        redirect_to exchange_rates_path, notice: 'Taxa com variação maior que 10%. Aprovação pendente'
      end
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
    redirect_to root_path unless current_admin.approved?
  end
end
