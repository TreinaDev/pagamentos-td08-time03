module SuspensionService
  def suspend_processing?
    time_range = (DateTime.now.days_ago(3).midnight)..DateTime.now
    last_exchange_rate = ExchangeRate.where(status: 'approved', created_at: time_range).last
    return if last_exchange_rate

    render status: 503, json: { errors: 'Sistema de pagamentos suspenso' }
  end
end
