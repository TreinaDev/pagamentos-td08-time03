json.client do
  json.registration_number @client.registration_number
  json.name @client.name
  json.balance_rubi @client.balance_rubi
  json.balance_brl @client.balance_brl
end