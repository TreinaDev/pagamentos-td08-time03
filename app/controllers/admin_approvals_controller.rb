class AdminApprovalsController < ApplicationController
  before_action :authenticate_approved_admin

  def index
    @requested_admins = Admin.where('activation != ?', 10)
                             .left_outer_joins(:admin_approvals).merge(AdminApproval.where(super_admin_email: nil)
                             .or(AdminApproval.where.not(super_admin_email: current_admin.email)))
                             .where(activation: [0, 5])
  end

  def create
    admin = Admin.find(params[:admin_id])
    approval = AdminApproval.new(admin: admin, super_admin_email: current_admin.email)

    return unless approval.save!

    redirect_to admin_approvals_path, notice: 'Admin aprovado com sucesso!'
  end

  private

  def authenticate_approved_admin
    redirect_to root_path unless current_admin.approved?
  end

  def approvals_parameters
    params.require(:admin_approval).permit(:admin, :super_admin_email)
  end
end
