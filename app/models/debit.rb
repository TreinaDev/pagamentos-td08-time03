class Debit < ApplicationRecord
  belongs_to :exchange_rate
  belongs_to :client
  belongs_to :order
  before_validation :rubi_value
  before_create :client_category_discount
  validates :rubi_amount, :real_amount, presence: true
  validates :real_amount, :rubi_amount, numericality: { greater_than: 0 }

  private

  def rubi_value
    self.rubi_amount = real_amount / exchange_rate.real if real_amount
  end

  def client_category_discount
    return unless client.client_category.active?

    self.real_amount = real_amount * (1 - client.client_category.discount / 100)
    self.rubi_amount = rubi_amount * (1 - client.client_category.discount / 100)
  end
end
