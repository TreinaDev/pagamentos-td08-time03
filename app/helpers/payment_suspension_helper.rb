module PaymentSuspensionHelper
  def suspend_payment_processing
    return render status: 503, json: { errors: 'Sistema de pagamentos suspenso' } if ExchangeRate.last.created_at < DateTime.now.days_ago(3)
  end
end