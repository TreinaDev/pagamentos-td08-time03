class AddActivationToAdmin < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :activation, :integer, default: 0
  end
end
