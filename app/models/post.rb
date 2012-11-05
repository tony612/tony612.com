class Post < ActiveRecord::Base
  attr_accessible :content, :title, :created_at, :category

  validates_presence_of :title, :content

  def to_param
    "#{id}-#{title.gsub(/\s/, '-')}"
  end
end
