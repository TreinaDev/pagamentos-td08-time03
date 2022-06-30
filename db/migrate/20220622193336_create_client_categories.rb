class CreateClientCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :client_categories do |t|
      t.string :name
      t.decimal :discount

      t.timestamps
    end
  end
end
