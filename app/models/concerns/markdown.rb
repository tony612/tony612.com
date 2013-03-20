module Markdown
  extend ActiveSupport::Concern

  def markdown(text, index = false)
    pygments_style = HTMLwithPygments.new(:filter_html => true, :hard_wrap => true, :gh_blockcode => true)
    options = {
      :autolink => true,
      #:space_after_headers => true,
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :strikethrough =>true,
      :lax_html_blocks => true,
      :superscript => true
    }
    options[:fenced_code_blocks] = false if index
    #markdown = Redcarpet::Markdown.new(coderayified,options)
    markdown = Redcarpet::Markdown.new(pygments_style, options)
    markdown.render(text).html_safe
  end

  class HTMLwithPygments < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
    def block_code(code ,language)
      Pygments.highlight(code, :lexer => language || "ruby", :options => {:encoding => 'utf-8'})
    end
  end
end
