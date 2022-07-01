class ChangeRubiAmountTypeInDebits < ActiveRecord::Migration[7.0]
  def self.up
    change_column :debits, :rubi_amount, :decimal, :precision => 10, :scale => 2
  end
end
