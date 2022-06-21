class CreateDailyCreditLimits < ActiveRecord::Migration[7.0]
  def change
    create_table :daily_credit_limits do |t|
      t.decimal :value

      t.timestamps
    end
  end
end
