if Rails.env.development?
  10.times do |i|
    user = User.create!(
      username: "user#{i}",
      email: "email#{i}@email.com",
      password: "123123123"
    )
    100.times do |j|
      News.create!(
        user: user,
        title: "Notícia de teste #{j}#{i}",
        link: 'http://lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html',
        text: 'Apenas um conteúdo de testes mesmo'
      )
    end
  end
end
