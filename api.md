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
### Exemplo de Resposta
```json
{
  "exchange_rate": {
    "value": 100.00
  }
}
```
