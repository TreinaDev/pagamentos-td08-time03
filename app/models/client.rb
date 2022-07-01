class Client < ApplicationRecord
  validate :cpf_cnpj
  validates :name, :registration_number, presence: true

  has_many :credits
  has_many :debits

  def cpf_cnpj
    cpf_reg = /\A\d{3}\.\d{3}\.\d{3}-\d\d\z/
    cnpj_reg = %r{\A\d\d\.\d{3}\.\d{3}/\d{4}-\d\d\z}
    return if registration_number && (registration_number.match(cpf_reg) || registration_number.match(cnpj_reg))

    errors.add(:registration_number, :invalid_format)
  end

  def transactions_extract(max: 10)
    # max, por padrão retorna as 10 últimas transações de um determinado cliente
    transactions_extract = credits.where(status: 5) | debits
    transactions_extract.sort_by(&:created_at).reverse.first(max)
  end
end
