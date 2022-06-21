class DailyCreditLimitsController < ApplicationController
  def index
    @daily_credit_limit = DailyCreditLimit.last
  end

  def new
    @daily_credit_limit = DailyCreditLimit.new
  end

  def create
    dcl_params = params.require(:daily_credit_limit).permit(:value)
    @daily_credit_limit = DailyCreditLimit.new(dcl_params)
    if @daily_credit_limit.save
      redirect_to daily_credit_limits_path, notice: 'Limite de crédito diário criado com sucesso!'
    else
      puts 'Teste a ser implementado'
    end
  end

end