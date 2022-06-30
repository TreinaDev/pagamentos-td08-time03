class Client < ApplicationRecord
  validate :cpf_cnpj
  validates :name, :registration_number, presence: true

  has_many :credits
  belongs_to :client_category

  before_validation :associate_default_category
  
  def balance_rubi
    credits.pluck(:rubi_amount).sum
  end
  
  def balance_brl
    credits.pluck(:real_amount).sum
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
