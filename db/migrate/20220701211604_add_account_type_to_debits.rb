class AddAccountTypeToDebits < ActiveRecord::Migration[7.0]
  def change
    add_column :debits, :account_type, :integer, default: 0
  end
end
