class AddCpfToAdmins < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :cpf, :string
  end
end
