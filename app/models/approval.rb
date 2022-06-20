class Approval < ApplicationRecord
  belongs_to :admin
  after_save :update_admin_status

  validates :super_admin_email, :admin, presence: true

  private

  def update_admin_status
    if admin.half_approved?
      admin.approved!
    else
      admin.half_approved!
    end
  end
end