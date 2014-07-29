# Startup News

[![Build Status](https://travis-ci.org/codelandev/startup_news.png?branch=master)](https://travis-ci.org/codelandev/startup_news)
[![Code Climate](https://codeclimate.com/github/codelandev/startup_news.png)](https://codeclimate.com/github/codelandev/startup_news)
[![Dependency Status](https://gemnasium.com/codelandev/startup_news.png)](https://gemnasium.com/codelandev/startup_news)
[![Coverage Status](https://coveralls.io/repos/codelandev/startup_news/badge.png?branch=master)](https://coveralls.io/r/codelandev/startup_news?branch=master)

## Então, o que é isso?
Startup News é uma aplicação web que visa centralizar as informações sobre Startups no brasil. As notícias são postadas POR usuários PARA usuários, e qualquer um pode postar o que achar interessante.

## Quem fez isso?
A aplicação foi feita pelo time da [CODELAND](http://www.codeland.com.br), uma empresa de desenvolvimento web focada em projetos de Startups e que identificou a falta de centralização das notícias sobre esse mundo fascinante das Startups.

São eles:

- [Bruno Pazzim](http://github.com/bpazzim)
- [Patrick Müller](http://github.com/mpatrick)
- [Sérgio Schnorr](http://github.com/ssjr)
- [Gabriel Carpenedo](http://github.com/cbgabe)

## Requirimentos e instalação:
- Ruby 2.1.2
- Rails 4.1.4
- PostgreSQL
- `gem install bundler`
- `bundle`
- `rake db:create db:migrate`
- `rails server`

Se você quiser usar o Google Analytics em produção, você precisa colocar a variável de ambiente no heroku (ENV["GOOGLE_ANALYTICS_TRACKER"])

`heroku config:set GOOGLE_ANALYTICS_TRACKER="your-key-go-here"`

Se você tem seu próprio servidor, basta rodar:

`export GOOGLE_ANALYTICS_TRACKER="your-key-go-here"`

## Ok, então, como eu rodo os testes?
Fácil, basta rodar o comando:

`rspec .`

## Agora eu quero ajudar, como eu posso fazer isso?
##### Ah, bem simples fazer isso, basta seguir os passos abaixo:

1) Crie uma issue no github propondo a implementação de uma nova feature (em inglês)

2) Depois de discutida e aprovada a nova feature, nós cadastraremos ela no pivotal ([https://www.pivotaltracker.com/s/projects/927766](https://www.pivotaltracker.com/s/projects/927766))

3) Dê um fork no projeto, e suba um PR com as modificações

4) Abra um PR

5) Quando aprovado, nós daremos finish na tarefa do Pivotal e subiremos suas modificações

6) Enjoy!

## Licença
Licensed under the [GPL License](http://www.gnu.org/copyleft/gpl.html).
