class OrdersController < ApplicationController
  before_action :set_order, only: %i[approve reject]
  def index
    @orders = Order.where(status: 0).order(created_at: :desc)
  end

  def approve
    debit = Debit.new(real_amount: @order.transaction_total_value, client: @order.client, exchange_rate: ExchangeRate.current, order: @order)
    
    redirect_to orders_path, notice: 'Pedido aprovado com sucesso!' if debit.save && @order.approved!
  end

  def reject
    return unless @order.rejected!

    redirect_to orders_path, alert: 'Pedido reprovado com sucesso!'
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end
end
