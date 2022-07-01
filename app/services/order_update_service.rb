class OrderUpdateService
  def self.update(code:, status:)
    json_data = {
      order_code: code,
      order_status: status
    }.to_json
    Faraday.patch('http://localhost:3000/api/v1/orders/update_status', json_data, content_type: 'application/json')
  end
end
