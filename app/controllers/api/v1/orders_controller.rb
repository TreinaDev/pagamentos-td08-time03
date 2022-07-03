class Api::V1::OrdersController < ActionController::API
  include SuspensionService
  before_action :suspend_processing?

  def create
    @order = Order.new(orders_params)
    @order.client = Client.find_by(registration_number: params[:client][:registration_number])
    if @order.save
      render status: 201
    elsif @order.client.nil?
      render status: 412, json: { errors: @order.errors.full_messages << 'Usuário não encontrado' }
    else
      render status: 412, json: { errors: @order.errors.full_messages }
    end
  end

  private

  def orders_params
    params.permit(:order_code, :transaction_total_value, :rate_used)
  end
end
