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

require 'helper'

describe Post do
  context 'validations' do
    it 'must has title' do
      post = build(:post, title: nil)
      expect(post).not_to be_valid
    end
    it 'must has content' do
      post = build(:post, content: nil)
      expect(post).not_to be_valid
    end
  end

  context 'scope' do
    before(:each) {
      @post1 = create(:post, category: "tech")
      @post2 = create(:post, category: "life")
    }
    it 'scopes order_by_time by DESC' do
      expect(Post.order_by_time.to_a).to eql([@post2, @post1])
    end
    it 'scopes categories' do
      expect(Post.life.to_a).to eql([@post2])
      expect(Post.tech.to_a).to eql([@post1])
    end
  end

  describe '#to_param' do
    it 'returns string like 123-this-is-a-blog' do
      post = create(:post, title: "This is a blog")
      expect(post.to_param).to eql("1-this-is-a-blog")
    end
  end

  describe '#title_url' do
    it "changes title to pretty URL" do
      post = create(:post, title: "This is a blog")
      expect(post.title).to receive(:parameterize)
      post.title_url
    end
  end

  describe '#generate_markdown_html' do
    it 'generates html from markdown' do
      post = create(:post, content: "Content", excerpt: "Excerpt")
      expect(post).to receive(:markdown).with("Content")
      expect(post).to receive(:markdown).with("Excerpt")
      post.generate_markdown_html
    end
  end

  describe 'hooks' do
    it 'calls generate_markdown_html before saving' do
      post = create(:post, content: "Content", excerpt: "Excerpt")
      expect(post).to receive(:generate_markdown_html)
      post.save
    end
  end
end
