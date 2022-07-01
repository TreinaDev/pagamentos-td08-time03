json.credit do
  json.status @credit.status
  json.real_amount @credit.real_amount
  json.rubi_amount @credit.rubi_amount
end

json.client do
  json.name @credit.client.name
  json.registration_number @credit.client.registration_number
end

if @bonus_credit
  json.bonus_credit do
    json.amount @bonus_credit.amount
  end
end
