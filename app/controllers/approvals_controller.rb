class ApprovalsController < ApplicationController
  before_action :authenticate_approved_admin

  def index
    @requested_admins = Admin.where("activation != ?", 10).left_outer_joins(:approvals).merge(Approval.where(super_admin_email: nil).or(Approval.where.not(super_admin_email: current_admin.email))).where(activation: [0, 5])

  end

  def create
    admin = Admin.find(params[:id])
    approval = Approval.new(admin: admin, super_admin_email: current_admin.email)

    if approval.save!
      redirect_to approvals_path, notice: 'Admin aprovado com sucesso!'
    end
  end

  private
    def authenticate_approved_admin
      redirect_to root_path if !current_admin.approved?
    end

    def approvals_parameters
      params.require(:approval).permit(:admin, :super_admin_email)
    end
end
