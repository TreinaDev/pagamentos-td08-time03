class CreditsController < ApplicationController
  def index
    @credits = Credit.where(status: 'pending')
  end
end
