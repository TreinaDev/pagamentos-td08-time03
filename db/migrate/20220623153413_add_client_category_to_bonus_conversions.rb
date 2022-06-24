class AddClientCategoryToBonusConversions < ActiveRecord::Migration[7.0]
  def change
    add_reference :bonus_conversions, :client_category, null: false, foreign_key: true
  end
end
