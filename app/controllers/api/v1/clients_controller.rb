class Api::V1::ClientsController < ActionController::API
  before_action :credit, only: [:add_credit]

  def add_credit
    if @credit.save
      render status: 201
    else
      render status: 402, json: { errors: @credit.errors.full_messages }
    end
  end

  def balance
    @client = find_or_create_client
    if @client.save
      render status: 200
    else
      render status: 400, json: { errors: @client.errors.full_messages }
    end
  end

  private

  def client_params
    params.require(:client).permit(:registration_number, :name)
  end

  def credit_params
    params.permit(:real_amount)
  end

  def find_or_create_client
    Client.find_or_create_by(client_params)
  end

  def credit
    registration_number = params.require(:company).permit(:registration_number)
    company = Company.find_by(registration_number)
    exchange_rate = ExchangeRate.current
    @credit = Credit.builder(find_or_create_client, credit_params, company, exchange_rate)
  end
end
