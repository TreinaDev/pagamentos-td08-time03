class ExchangeRate < ApplicationRecord
  validates :real, presence: true
  validates :real, numericality: { greater_than: 0 }
  has_many :exchange_rate_approvals
  belongs_to :admin
  enum status: { pending: 0, approved: 10 }

  def self.fluctuation(exchange_rate = nil)
    if exchange_rate
      latter = ExchangeRate.where(status: 10).last
      latter ? (((exchange_rate.real / latter.real) - 1) * 100) : 0
    else
      former, latter = ExchangeRate.where(status: 10).last(2)
      (((latter.real / former.real) - 1) * 100) if latter
    end
  end

  def self.actual
    ExchangeRate.where(status: 10).last
  end

  def self.all_approved
    ExchangeRate.where(status: 10).order(created_at: :desc)
  end
end
