class ClientCategory < ApplicationRecord
  validates :name, :discount, presence: true
  validates :discount, numericality: { greater_than: 0 }
  enum status: { inactive: 0, active: 10 }

end
