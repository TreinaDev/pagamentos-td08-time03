class ClientCategory < ApplicationRecord
  validates :name, :discount, presence: true
  validates :discount, numericality: { greater_than_or_equal_to: 0 }
  validates :discount, numericality: { less_than: 99 }
  validates :name, uniqueness: { case_sensitive: false }, length: { maximum: 15 }
  has_many :bonus_conversions
  has_many :clients
  enum status: { inactive: 0, active: 10 }
end
