class ExchangeRate < ApplicationRecord
  validates :real, presence: true
  validates :real, numericality: true
end
