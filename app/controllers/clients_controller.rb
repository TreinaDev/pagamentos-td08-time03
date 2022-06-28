class ClientsController < ApplicationController
  before_action :authenticate_approved_admin

  def index; end

  def search
    if params[:registration_number].present?
      reg_numb = params[:registration_number]
      @client = NoSymbolsRegistrationNumberSearcher.new(reg_numb).search
      @flag_search = true
    end
    render 'index'
  end

  private

  def authenticate_approved_admin
    redirect_to root_path unless current_admin.approved?
  end
end
