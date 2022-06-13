class Api::V1::ClientsController < ActionController::API
  def credit
    credit_params = params.permit(:client_id, :company_id, :real_amount)
    credit = Credit.new(credit_params)
    exchange_rate = ExchangeRate.last
    credit.exchange_rate = exchange_rate

    credit.rubi_amount = credit.real_amount / exchange_rate.real if credit.real_amount
    if credit.save
      render status: 201, json: credit
    else
      render status: 402, json: { errors: credit.errors.full_messages }
    end
  end
end
