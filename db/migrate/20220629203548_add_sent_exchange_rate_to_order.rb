class AddSentExchangeRateToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :rate_used, :decimal, precision: 10, scale: 2
  end
end
