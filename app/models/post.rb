class Post < ActiveRecord::Base
  attr_accessible :content, :title, :created_at

  validates_presence_of :title, :content, :created_at, :updated_at
end
