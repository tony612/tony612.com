class AddMarkdownHtmlToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :markdown_html, :text

    Post.all.each do |p|
      markdown_html = p.markdown(p.content)
      p.update_attributes({:markdown_html => markdown_html})
    end
  end

  def down
    remove_column :posts, :markdown_html
  end
end
