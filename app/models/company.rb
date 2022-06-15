class Company < ApplicationRecord
  validates :corporate_name, :registration_number, presence: true

  has_many :credits
end
