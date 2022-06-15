class ApprovalsController < ApplicationController
  before_action :authenticate_admin!

  def index

    @requested_admins = Admin.where("activation != ?", 10).left_outer_joins(:approvals).merge(Approval.where(super_admin_email: nil).or(Approval.where.not(super_admin_email: current_admin.email))).where(activation: [0, 5])

  end

  def new
    admin = Admin.find(params[:id])


    a = Approval.create!(admin: admin, super_admin_email: current_admin.email)

    if admin.half_approved?
      admin.approved!
    else
      admin.half_approved!
    end


    redirect_to approvals_path, notice: 'Usuário aprovado com sucesso'
  end
end
