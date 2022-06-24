class AddStatusToBonusConversions < ActiveRecord::Migration[7.0]
  def change
    add_column :bonus_conversions, :status, :integer, default: 10
  end
end
