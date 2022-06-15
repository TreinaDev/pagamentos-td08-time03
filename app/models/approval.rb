class Approval < ApplicationRecord
  belongs_to :admin
  before_create :update_admin_status

  validates :super_admin_email, :admin, presence: true
  validate :existence_of_super_admin_email


  private

  def update_admin_status
    if self.admin.half_approved?
      admin.approved!
    else
      self.admin.half_approved!
    end
  end

  def existence_of_super_admin_email
    admin = Admin.find_by(email: self.super_admin_email)
    if admin.nil?
      self.errors.add(:super_admin_email, "deve pertencer a algum Admin cadastrado")
    end
  end

end

