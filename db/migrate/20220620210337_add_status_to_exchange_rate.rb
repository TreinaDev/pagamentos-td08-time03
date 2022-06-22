class AddStatusToExchangeRate < ActiveRecord::Migration[7.0]
  def change
    add_column :exchange_rates, :status, :integer, default: 0
  end
end
