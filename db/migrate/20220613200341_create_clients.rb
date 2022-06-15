class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :registration_number
      t.string :name

      t.timestamps
    end
  end
end