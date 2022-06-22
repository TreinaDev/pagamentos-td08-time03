class CreateExchangeRateApprovals < ActiveRecord::Migration[7.0]
  def change
    create_table :exchange_rate_approvals do |t|
      t.references :admin, null: false, foreign_key: true
      t.references :exchange_rate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
