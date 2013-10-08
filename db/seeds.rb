# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


if Rails.env.development?
  10.times do |i| 
    User.create!([
      username: "username_teste_#{i}",
      email: "email#{i}@email.com",
      password: "123123123"
    ])
  end

  100.times do |i|
    10.times do |j|
      News.create!([
        user: User.find(j+1),
        title: "Notícia de teste #{i}#{j}",
        link: 'http://lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html',
        text: 'Apenas um conteúdo de testes mesmo'
      ])
    end
  end
end