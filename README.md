<h1 align="center"> 
	<img src="https://imgur.com/AaVNOIP.png"> USERUBIS - API de Pagamentos
</h1>
<p align="center">
<img src="https://img.shields.io/static/v1?label=Ruby&message=3.1.0&color=red&style=for-the-badge&logo=ruby" />
<img src="https://img.shields.io/static/v1?label=Ruby On Rails &message=7.0.3&color=red&style=for-the-badge&logo=ruby"/>
<img src="https://img.shields.io/static/v1?label=PROGRESSO&message=EM%20DESENVOLVIMENTO&color=RED&style=for-the-badge" />
</p>
<p align="center"> 
	 Projeto Final - Treinadev Turma 8
</p>

## Descrição do Projeto

USERUBIS é um sistema de pagamentos, desenvolvido durante a segunda etapa do [TreinaDev 8](https://treinadev.com.br/), que permite o gerenciamento de transações feitas por uma plataforma de [E-Commerce](https://github.com/TreinaDev/e-commerce-td08-time03).

## Requisitos:
* Ruby 3.1.0
* SQlite3 (1.4.4)
* NodeJs
* Yarn

## Gems Utilizadas
-   [Devise (4.8.1)](https://github.com/heartcombo/devise)
-   [FactoryBot Rails (6.2.1) ](https://github.com/thoughtbot/factory_bot_rails)
-   [Rubocop (1.30.1)](https://github.com/rubocop/rubocop)
-   [Rspec (5.1.2)](https://github.com/rspec/rspec-rails)
-   [Capybara (3.37.1)](https://github.com/teamcapybara/capybara)
-   [Shoulda-matchers (5.1.0)](https://github.com/thoughtbot/shoulda-matchers)
-   [Simplecov (0.21.2)](https://github.com/simplecov-ruby/simplecov)
-   [cssbundling-rails (1.1.1)](https://github.com/rails/cssbundling-rails)
-   [htmlbeautifier (1.4.2)](https://github.com/threedaymonk/htmlbeautifier)
-   [erb_lint (0.1.3)](https://github.com/Shopify/erb-lint)
-   [Faraday (2.3.0)](https://github.com/lostisland/faraday)

## Rodando o projeto

No terminal clone o projeto:

```bash
git clone git@github.com:TreinaDev/pagamentos-td08-time03.git
```

Abra o diretório:

```bash
cd pagamentos-td08-time03
```

Rode o comando bin/setup para configurar adequadamente o projeto:

```bash
bin/setup
```

Para inicializar o servidor:

```bash
rails s
```

## Desenvolvimento
Caso queira desenvolver o projeto, rode o comando abaixo ao invés do `rails s`.

```bash
bin/dev
```

## Login
Após rodar as seeds, são gerados administradores aprovados e não aprovados, o exemplo abaixo é de um administrador aprovado:

E-mail:

```
mateus@userubis.com.br
```

Senha:

```
123456
```

## Testes
Para rodar os testes da aplicação, execute o comando:

```
bundle exec rspec 
```

## API
[Documentação](api.md)
