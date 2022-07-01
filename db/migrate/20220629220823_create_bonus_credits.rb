class CreateBonusCredits < ActiveRecord::Migration[7.0]
  def change
    create_table :bonus_credits do |t|
      t.integer :status, default: 0
      t.date :expiration_date
      t.decimal :amount
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
