class AddExchangeRatesToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :exchange_rate, null: false, foreign_key: true
  end
end
