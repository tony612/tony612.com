# == Schema Information
#
# Table name: posts
#
#  id               :integer          not null, primary key
#  title            :string(255)      not null
#  content          :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  category         :string(255)
#  excerpt          :text
#  excerpt_markdown :text
#  markdown_html    :text
#

class Post < ActiveRecord::Base

  validates_presence_of :title, :content

  scope :order_by_time, -> { order("created_at DESC") }
  scope :life, -> { where(category: "life").order_by_time }
  scope :tech, -> { where(category: "tech").order_by_time }

  include Markdown

  def to_param
    "#{id}-#{title_url}"
  end

  def title_url
    title.parameterize
  end

  before_save :generate_markdown_html
  def generate_markdown_html
    self.markdown_html = markdown(content || "")
    self.excerpt_markdown = markdown(excerpt || "")
  end
end
