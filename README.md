# MochilaApp

Mochila é um sistema de auxílio a gestão escolar alocando Alunos e Professores
em Turmas.

## Depedências do Projeto

1. Ruby 2.5.9
2. Ruby on Rails 5.1.7
3. Bootstrap 5.1
4. SQLite3

## Configuração

1. Instale o ruby (aconselhamos a utilização de rvm ou asdf)

~~~shell
asdf install ruby 2.5.9 # caso utilize asdf
rvm  install ruby-2.5.9 # caso utilize rvm	 
~~~

2. Instale a gem bundler e utilize a mesma para instalar as demais dependências
ruby.

~~~shell
gem install bunlder && bundler install
~~~

3. Prepare o banco de dados

~~~shell
rails db:setup
rails db:seed
~~~

4. Instale o redis-server, segue o link: https://redis.io/download

5. Para executar a aplicação execute os seguintes comandos:
~~~shell
bundle exec sidekiq
rails s
~~~
