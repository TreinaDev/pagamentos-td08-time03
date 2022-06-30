class CreditsController < ApplicationController
  before_action :set_credit, only: %i[approve reject]
  before_action :authenticate_approved_admin

  def index
    @credits = Credit.where(status: 'pending')
  end

  def approve
    return unless @credit.approved!

    redirect_to credits_path, notice: 'Crédito aprovado com sucesso!'
  end

  def reject
    return unless @credit.rejected!

    redirect_to credits_path, notice: 'Crédito reprovado com sucesso!'
  end

  private

  def set_credit
    @credit = Credit.find(params[:credit_id])
  end

  def authenticate_approved_admin
    redirect_to root_path unless current_admin.approved?
  end
end
