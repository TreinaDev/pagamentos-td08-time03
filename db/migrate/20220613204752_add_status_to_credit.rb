class AddStatusToCredit < ActiveRecord::Migration[7.0]
  def change
    add_column :credits, :status, :integer, default: 5
  end
end
