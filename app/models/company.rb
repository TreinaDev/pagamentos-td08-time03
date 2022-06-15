class Company < ApplicationRecord
  validates :corporate_name, :registration_number, presence: true
  validates :registration_number, format: { with: /\A\d\d\.\d{3}\.\d{3}\/\d{4}\-\d\d\z/ }

  has_many :credits
end
