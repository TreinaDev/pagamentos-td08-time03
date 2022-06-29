class BonusConversion < ApplicationRecord
  belongs_to :client_category
  validates :start_date, :end_date, :bonus_percentage, :deadline, presence: true
  validates :bonus_percentage, numericality: { greater_than: 0 }
  validates :start_date, comparison: { less_than: :end_date, message: 'deve ser menor que a data final' }
  validates :deadline, numericality: { greater_than: 0 }
  validate :unique_period_and_category, on: :create
  enum status: { inactive: 0, active: 10 }
end

private

def range_validator(ranges, attr_value)
  ranges.detect do |s, e|
    (s..e).include?(attr_value)
  end
end

def unique_period_and_category
  return unless client_category

  date_ranges = BonusConversion.where(client_category: client_category).pluck(:start_date, :end_date)
  start_date_valid = range_validator(date_ranges, start_date)
  end_date_valid = range_validator(date_ranges, end_date)
  return unless start_date_valid or end_date_valid

  errors.add(:base, :unique_period_and_category)
end