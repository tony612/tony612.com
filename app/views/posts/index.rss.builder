xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Tony612 Blog"
    xml.description "Blog of Tony Han"
    xml.link posts_url

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description post.markdown_html
        xml.pubDate post.created_at
        xml.link post_url(post)
        xml.guid post_url(post)
      end
    end
  end
end
