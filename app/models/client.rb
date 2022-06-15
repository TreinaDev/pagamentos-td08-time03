class Client < ApplicationRecord
  validates :name, :registration_number, presence: true
  has_many :credits
end
