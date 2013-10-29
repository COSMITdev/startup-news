atom_feed do |feed|
  feed.title("Startup News")
  feed.updated(@news[0].created_at) if @news.length > 0

  @news.each do |news|
    feed.entry(news) do |entry|
      entry.title(news.title)
      entry.content(news.text, type: 'html')
    end
  end
end
