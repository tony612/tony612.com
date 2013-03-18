class AddExcerptToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :excerpt, :text
    add_column :posts, :excerpt_markdown, :text
  end
end
