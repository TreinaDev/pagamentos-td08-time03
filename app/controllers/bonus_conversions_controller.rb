class BonusConversionsController < ApplicationController
  before_action :authenticate_approved_admin

  def index
    @bonus_conversions = BonusConversion.where(status: 10).order(created_at: :desc)
  end

  def new
    @bonus_conversion = BonusConversion.new
  end

  def create
    @bonus_conversion = BonusConversion.new(bonus_conversion_params)

    if @bonus_conversion.save
      redirect_to bonus_conversions_path, notice: 'Conversão bônus cadastrada com sucesso!'
    else
      flash.now[:alert] = 'Erro ao criar categoria de clientes'
      render :new
    end
  end

  def inactivate
    @bonus_conversion = BonusConversion.find(params[:bonus_conversion_id])
    if @bonus_conversion.inactive!
      flash[:notice] = 'Conversão bônus desativada com sucesso!'
      return redirect_to bonus_conversions_path
    end

    flash[:alert] = 'Algo deu errado.'
  end

  private

  def bonus_conversion_params
    params.require(:bonus_conversion).permit(:start_date, :end_date, :bonus_percentage, :deadline, :client_category_id)
  end

  def authenticate_approved_admin
    redirect_to root_path unless current_admin.approved?
  end
end
