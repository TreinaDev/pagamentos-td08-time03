class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :registration_number
      t.string :corporate_name

      t.timestamps
    end
  end
end
