class CreditsController < ApplicationController
  before_action :set_credit, only: %i[approve reject]
  before_action :authenticate_approved_admin

  def index
    @credits = Credit.where(status: 'pending')
  end

  def approve
    if @credit.approved!
      redirect_to credits_path, notice: 'Crédito aprovado com sucesso!'
    else
      flash.now[:alert] = 'Algo deu errado...'
      render 'index'
    end
  end

  def reject
    if @credit.rejected!
      redirect_to credits_path, notice: 'Crédito reprovado com sucesso!'
    else
      flash.now[:alert] = 'Algo deu errado...'
      render 'index'
    end
  end

  private

  def set_credit
    @credit = Credit.find(params[:credit_id])
  end

  def authenticate_approved_admin
    redirect_to root_path unless current_admin.approved?
  end
end
