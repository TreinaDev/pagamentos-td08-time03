class AddStatusToClientCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :client_categories, :status, :integer, default: 10
  end
end
