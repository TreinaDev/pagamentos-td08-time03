class ExchangeRateApprovalsController < ApplicationController
  before_action :authenticate_approved_admin

  def index
    @pending_exchange_rates = ExchangeRate.where.not(admin: current_admin).merge(ExchangeRate.where(status: 0)).order(created_at: :desc)
  end

  def create
    exchange_rate = ExchangeRate.find(params[:exchange_rate_id])
    approval = ExchangeRateApproval.new(admin: current_admin, exchange_rate: exchange_rate)

    if exchange_rate.exchange_rate_approvals.first.admin != current_admin
      approval.save!
      return redirect_to exchange_rate_approvals_path, notice: 'Taxa aprovada com sucesso.'
    end

    redirect_to exchange_rate_approvals_path, alert: 'Você não possui permissões'
  end

  private

  def authenticate_approved_admin
    redirect_to root_path unless current_admin.approved?
  end
end
