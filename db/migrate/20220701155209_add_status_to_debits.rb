class AddStatusToDebits < ActiveRecord::Migration[7.0]
  def change
    add_column :debits, :status, :integer, default: 0
  end
end
