class ExchangeRate < ApplicationRecord
  validates :real, presence: true
  validates :real, numericality: true
  has_many :exchange_rate_approvals
  belongs_to :admin
  enum status: { not_approved: 0, approved: 10 }

  def self.fluctuation
    former, latter = ExchangeRate.last(2)
    (((latter.real / former.real) - 1) * 100).round(2) if latter
  end
end
