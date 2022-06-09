class CreateExchangeRates < ActiveRecord::Migration[7.0]
  def change
    create_table :exchange_rates do |t|
      t.decimal :real, precision: 10, scale: 2

      t.timestamps
    end
  end
end
