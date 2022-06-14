class ApprovalsController < ApplicationController
  before_action :authenticate_admin!

  def index
    #unir as duas

    pending_admins = Admin.where("activation != ?", 10)
    #mostra todos os admins recém criados que não estejam aprovados

    requested_admins = pending_admins.joins(:approvals).where.not(approvals: {super_admin_email: current_admin.email})
    #consulta todos os admins que possuam relação com o model APPROVAL e que ainda não estejam aprovados pelo current_admin

    #### criar consulta com os admins que ainda nao possuem um model APPROVAL
    admins_without_approval = pending_admins.where(activation: "no_approval")

    @arrayfinal = requested_admins + admins_without_approval
    #Mostra na view o arrayfinal
  end

  def new
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
