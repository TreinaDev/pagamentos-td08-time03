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
    client_ids = params[:client_category][:client_ids]
    if @client_category.valid? && client_ids
      @client_category.save!
      client_ids.each { |client_id| Client.update(client_id, client_category: @client_category) }
      redirect_to client_categories_path, notice: 'Categoria de cliente cadastrada com sucesso!'
    else
      @client_category.errors.add(:base, 'A categoria deve estar associada a pelo menos um cliente') unless client_ids
      flash.now[:alert] = 'Erro ao criar categoria de clientes'
      render :new
    end
  end

  def inactivate
    @client_category = ClientCategory.find(params[:client_category_id])

    return unless @client_category.inactive!

    flash[:notice] = 'Categoria de clientes desativada com sucesso!'
    redirect_to client_categories_path
  end

  private

  def client_category_params
    params.require(:client_category).permit(:name, :discount)
  end

  def authenticate_approved_admin
    redirect_to root_path unless current_admin.approved?
  end
end
