class BonusConversion < ApplicationRecord
  belongs_to :client_category
  validates :start_date, :end_date, :bonus_percentage, :deadline, presence: true
  validates :bonus_percentage, numericality: { greater_than: 0 }
  validates :bonus_percentage, numericality: { less_than: 99 }
  validates :start_date, comparison: { less_than: :end_date, message: 'deve ser menor que a data final' }
  validates :deadline, numericality: { greater_than: 0}
  enum status: { inactive: 0, active: 10 }
end
