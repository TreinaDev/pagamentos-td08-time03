class ChangeRealAmountTypeInDebits < ActiveRecord::Migration[7.0]
  def self.up
    change_column :debits, :real_amount, :decimal, :precision => 10, :scale => 2
  end
end
