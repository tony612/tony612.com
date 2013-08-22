atom_feed do |feed|
  feed.title("Tony612 Blog")
  feed.updated(@posts[0].created_at) if @posts.length > 0

  @posts.each do |post|
    feed.entry post do |entry|
      entry.title(post.title)
      entry.content(post.markdown_html, type: 'html')

      entry.author do |author|
        author.name("Tony Han")
      end
    end
  end
end
