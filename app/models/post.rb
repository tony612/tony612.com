class Post < ActiveRecord::Base
  #attr_accessible :content, :title, :created_at, :category, :markdown_html

  validates_presence_of :title, :content

  scope :order_by_time, order("created_at DESC")
  scope :life, where(category: "life").order_by_time
  scope :tech, where(category: "tech").order_by_time

  include Markdown

  def to_param
    "#{id}-#{title.gsub(/\s/, '-').gsub(/\./, '-')}"
  end

  before_save :generate_markdown_html
  def generate_markdown_html
    self.markdown_html = markdown(self.content)
  end
end
