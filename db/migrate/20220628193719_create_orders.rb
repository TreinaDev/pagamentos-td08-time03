class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :order_code
      t.references :client, null: false, foreign_key: true
      t.decimal :transaction_total_value
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
