class CreateBonusConversions < ActiveRecord::Migration[7.0]
  def change
    create_table :bonus_conversions do |t|
      t.date :start_date
      t.date :end_date
      t.decimal :bonus_percentage
      t.integer :deadline

      t.timestamps
    end
  end
end
