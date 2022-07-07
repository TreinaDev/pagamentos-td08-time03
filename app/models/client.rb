class Client < ApplicationRecord
  validate :cpf_cnpj
  validates :name, :registration_number, presence: true

  belongs_to :client_category
  has_many :credits
  has_many :bonus_credits
  has_many :debits

  before_validation :associate_default_category

  def balance_rubi
    credits.where(status: :approved).pluck(:rubi_amount).sum - debits.where(account_type: :checking_account).pluck(:rubi_amount).sum
  end

  def balance_brl
    credits.where(status: :approved).pluck(:real_amount).sum - debits.where(account_type: :checking_account).pluck(:real_amount).sum
  end

  def balance_bonus(type = nil)
    expire_bonus_credits
    bonus_value = bonus_credits.where(status: :active).reduce(0) do |acc, v|
      if type == 'rubi'
        acc + v.amount
      else
        acc + (v.credit.exchange_rate.real * v.amount)
      end
    end
    bonus_value - debits.where(account_type: :bonus_account).pluck(:real_amount).sum
  end

  def expire_bonus_credits
    to_be_expired_bonus_credits = bonus_credits.where('expiration_date < ?', DateTime.now.to_date)
    to_be_expired_bonus_credits.each(&:expired!)
  end

  def transactions_extract(max: 10)
    # max, por padrão retorna as 10 últimas transações de um determinado cliente
    transactions_extract = credits.where(status: 5) | debits
    transactions_extract.sort_by(&:created_at).reverse.first(max)
  end

  def full_description
    "#{registration_number} - #{name}"
  end

  private

  def cpf_cnpj
    cpf_reg = /\A\d{3}\.\d{3}\.\d{3}-\d\d\z/
    cnpj_reg = %r{\A\d\d\.\d{3}\.\d{3}/\d{4}-\d\d\z}
    return if registration_number && (registration_number.match(cpf_reg) || registration_number.match(cnpj_reg))

    errors.add(:registration_number, :invalid_format)
  end

  def associate_default_category
    self.client_category ||= ClientCategory.find_by(name: 'BASIC')
  end
end
