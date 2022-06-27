class ClientBalancesController < ApplicationController
  def index
    if params[:registration_number].present?
      reg_numb = params[:registration_number]
      @client = NoSymbolsRegistrationNumberSearcher.new(reg_numb).search
      @flag_search = true
    end
  end
end