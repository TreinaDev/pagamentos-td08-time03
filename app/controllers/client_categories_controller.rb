class ClientCategoriesController < ApplicationController
  before_action :authenticate_approved_admin
  def index
    @client_categories = ClientCategory.where(status: 10)
  end

  def new
    @client_category = ClientCategory.new
  end

  def create
    @client_category = ClientCategory.new(client_category_params)

    if @client_category.save
      redirect_to client_categories_path, notice: 'Categoria de cliente cadastrada com sucesso!'
    else
      flash.now[:alert] = 'Erro ao criar categoria de clientes'
      render :new
    end
  end

  def inactivate
    @client_category = ClientCategory.find(params[:client_category_id])
    if @client_category.inactive!
      flash[:notice] = "Categoria de clientes desativada com sucesso!"
      return redirect_to client_categories_path
    end

    flash[:alert] = "Algo deu errado."
  end

  private

  def client_category_params
    params.require(:client_category).permit(:name, :discount)
  end

  def authenticate_approved_admin
    redirect_to root_path unless current_admin.approved?
  end
end
