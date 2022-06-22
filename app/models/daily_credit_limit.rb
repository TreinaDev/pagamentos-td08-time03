class DailyCreditLimit < ApplicationRecord
  validates :value, presence: true
  validates :value, numericality: { greater_than: 0 }
end
