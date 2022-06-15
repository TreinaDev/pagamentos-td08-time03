class Approval < ApplicationRecord
  belongs_to :admin
  before_create :update_admin_status

  private

  def update_admin_status
    if self.admin.half_approved?
      admin.approved!
    else
      self.admin.half_approved!
    end
  end
end

