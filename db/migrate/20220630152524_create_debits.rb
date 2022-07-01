class CreateDebits < ActiveRecord::Migration[7.0]
  def change
    create_table :debits do |t|
      t.decimal :real_amount
      t.decimal :rubi_amount
      t.references :exchange_rate, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
