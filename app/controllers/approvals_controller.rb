class ApprovalsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @pending_admins = Admin.where("activation != ?", 10)
  end

  def new
    puts params
    admin = Admin.find(params[:id])

    a = Approval.create!(admin: admin, super_admin_email: current_admin.email)
    if admin.half_approval?
      admin.approved!
    else
      admin.half_approval!
    end


    redirect_to approvals_path, notice: 'Usuário aprovado com sucesso'
  end
end