class Client < ApplicationRecord
  validates :name, :registration_number, presence: true
end
