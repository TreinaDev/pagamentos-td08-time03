class AddFullNameToAdmins < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :full_name, :string
  end
end
