class DropClientBalances < ActiveRecord::Migration[7.0]
  def change
    drop_table :client_balances
  end
end
