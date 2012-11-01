module ApplicationHelper
  
  def markdown(text)
    coderayified = HTMLwithCodeRay.new(:filter_html => true, :hard_wrap => true)
    options = {   
      :autolink => true, 
      #:space_after_headers => true,
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :strikethrough =>true,
      
      :lax_html_blocks => true,
      :superscript => true
    }
    #markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,options)
    markdown = Redcarpet::Markdown.new(coderayified,options)
    markdown.render(text).html_safe
  end

  class HTMLwithCodeRay < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
    def block_code(code, language)
      CodeRay.scan(code, language).div(:tab_width=>2, :line_numbers => :table)
    end
  end

end
