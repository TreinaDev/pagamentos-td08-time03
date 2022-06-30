json.order do
  json.order_code @order.order_code
  json.id @order.id
  json.status @order.status
  json.client do
      json.name @order.client.name
      json.registration_number @order.client.registration_number
  end
end
