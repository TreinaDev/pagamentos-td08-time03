class CreateCredits < ActiveRecord::Migration[7.0]
  def change
    create_table :credits do |t|
      t.decimal :real_amount, precision: 10, scale: 2
      t.decimal :rubi_amount, precision: 10, scale: 2
      t.references :exchange_rate, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
