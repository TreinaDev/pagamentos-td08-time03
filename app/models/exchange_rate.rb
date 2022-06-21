class ExchangeRate < ApplicationRecord
  validates :real, presence: true
  validates :real, numericality: { greater_than: 0 }

  def self.fluctuation
    former, latter = ExchangeRate.last(2)
    (((latter.real / former.real) - 1) * 100).round(2) if latter
  end
end
