class Post < ActiveRecord::Base
  #attr_accessible :content, :title, :created_at, :category

  validates_presence_of :title, :content

  scope :order_by_time, order("created_at DESC")
  scope :life, where(category: "life").order_by_time
  scope :tech, where(category: "tech").order_by_time

  def to_param
    "#{id}-#{title.gsub(/\s/, '-').gsub(/\./, '-')}"
  end
end
