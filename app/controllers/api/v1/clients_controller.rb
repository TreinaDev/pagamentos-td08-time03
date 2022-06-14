class Api::V1::ClientsController < ActionController::API
  before_action :credit, only: [:add_credit]

  def add_credit
    if @credit.save
      render status: 201
    else
      render status: 402, json: { errors: @credit.errors.full_messages }
    end
  end

  private

  def client_params
    params.require(:client).permit(:registration_number, :name)
  end

  def credit_params
    params.permit(:real_amount)
  end

  def credit
    @credit ||= Credit.builder(client_params, credit_params, params.require(:company).permit(:registration_number))
  end
end
