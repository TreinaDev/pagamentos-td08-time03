# Endpoints
## POST /api/v1/clients/credit
Adiciona créditos à conta de um cliente
### Exemplo de requisição
```json
{
  "client": {
    "name": "João Almeida",
    "registration_number": "123.456.789-00"
  },
  "company": {
    "name": "Razão Social da Empresa",
    "registration_number": "12.345.678/0001-99"
  },
  "real_amount": 1500.00
}
```
### Exemplo de resposta (Requisição bem-sucedida)
```json
{
  "credit": {
    "status": "pending",
    "real_amount": 1500.00,
    "rubi_amount": 150.00
  },
  "client": {
    "name": "João Almeida",
    "registration_number": "12.345.678/0001-99"
  }
}
```
### Exemplo de resposta (Erro na requisição)
```json
{
  "errors": ["Nome do cliente não pode ficar em branco", "CPF não pode ficar em branco"]
}
```
## GET /api/v1/exchange_rates/current
Retorna a taxa de câmbio atual (RUBI -> REAIS)
### Exemplo de resposta (Requisição bem-sucedida)
```json
{
  "exchange_rate": {
    "value": 100.00
  }
}
```
## POST /api/v1/clients/balance
Retorna informações referentes ao saldo do cliente
### Exemplo de requisição
```json
{
  "client": {
    "registration_number": "123.456.789-00"
  }
}
```
### Exemplo de resposta
```json
{
  "client": {
    "registration_number": "123.456.789-00",
    "name": "João Almeida",
    "balance_rubi": 150.00,
    "balance_brl": 1500.00
  }
}
```
## POST /api/v1/orders
Cria um pedido para um cliente
### Exemplo de requisição
```json
{
  "order_code": "ABCDEDFFKAS1245",
  "client": {
    "name": "João Almeida",
    "registration_number": "123.456.789-00"
  },
  "rate_used": 10.0,
  "transaction_total_value": 1500.0
}
```
### Exemplo de resposta (Requisição bem-sucedida)
```json
{
  "order": {
    "order_code": "QUINZCARACTERES",
    "id": 1,
    "status": "pending",
    "client": {
    "name": "João Almeida",
    "registration_number": "123.456.789-00"
    }
  }
}
```
### Exemplo de resposta (Erro na requisição)
```json
{
  "errors": ["Taxa de câmbio utilizada não está atualizada"]
}
