class ClientBalancesController < ApplicationController
  def index
    @client = Client.find_by(registration_number: params[:registration_number])
  end
end