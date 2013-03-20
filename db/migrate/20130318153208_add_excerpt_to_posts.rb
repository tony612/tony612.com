class AddExcerptToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :excerpt, :text, :default => ""
    add_column :posts, :excerpt_markdown, :text, :default => ""
  end
end
