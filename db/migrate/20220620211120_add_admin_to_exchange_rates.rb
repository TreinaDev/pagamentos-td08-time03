class AddAdminToExchangeRates < ActiveRecord::Migration[7.0]
  def change
    add_reference :exchange_rates, :admin, null: false, foreign_key: true
  end
end
