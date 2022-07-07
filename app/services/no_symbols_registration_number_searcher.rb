class NoSymbolsRegistrationNumberSearcher
  attr_reader :reg_number

  def initialize(reg_number)
    @reg_number = reg_number
  end

  def search
    cpf_reg = /\A\d{3}\.\d{3}\.\d{3}-\d\d\z/
    cnpj_reg = %r{\A\d\d\.\d{3}\.\d{3}/\d{4}-\d\d\z}
    if reg_number.match?(cpf_reg) || reg_number.match?(cnpj_reg)
      Client.find_by(registration_number: reg_number)
    elsif reg_number.length == 11 && reg_number.to_i.to_s == reg_number
      reg_numb_with_symbols = reg_number.insert(3, '.').insert(7, '.').insert(11, '-')
      Client.find_by(registration_number: reg_numb_with_symbols)
    elsif reg_number.length == 14 && reg_number.to_i.to_s == reg_number
      reg_numb_with_symbols = reg_number.insert(2, '.').insert(6, '.').insert(10, '/').insert(15, '-')
      Client.find_by(registration_number: reg_numb_with_symbols)
    end
  end
end
