module PaymentSuspension
  def suspend_payment_processing
    last_exchange_rate = ExchangeRate.where(status: 'approved').last
    time_range = (DateTime.now.days_ago(3).midnight)..DateTime.now
    return if last_exchange_rate && time_range.cover?(last_exchange_rate.created_at)

    render status: 503, json: { errors: 'Sistema de pagamentos suspenso' }
  end
end
