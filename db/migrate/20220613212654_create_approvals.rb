class CreateApprovals < ActiveRecord::Migration[7.0]
  def change
    create_table :approvals do |t|
      t.references :admin, null: true, foreign_key: true
      t.string :super_admin_email

      t.timestamps
    end
  end
end
