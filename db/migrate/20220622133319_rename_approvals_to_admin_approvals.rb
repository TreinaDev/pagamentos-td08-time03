class RenameApprovalsToAdminApprovals < ActiveRecord::Migration[7.0]
  def up
    rename_table :approvals, :admin_approvals
  end

  def down
    rename_table :admin_approvals, :approvals
  end
end
