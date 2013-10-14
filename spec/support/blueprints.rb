require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

User.blueprint do
  username { sn }
  email { "email#{sn}@email.com" }
  password { "123123123" }
end

News.blueprint do
  user { User.make! }
  title { 'Notícia de teste' }
  link { 'http://lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html' }
  text { 'Apenas um conteúdo de testes mesmo' }
end

Comment.blueprint do
  user { User.make! }
  text { 'Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem
    ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor
    sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet ' }
end

Vote.blueprint do
  user { User.make! }
  news { News.make! }
  is_up { true }
  ip { "127.0.0.1" }
end
