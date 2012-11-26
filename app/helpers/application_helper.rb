module ApplicationHelper

  def markdown(text, index = false)
    #coderayified = HTMLwithCodeRay.new(:filter_html => true, :hard_wrap => true)
    albinoified = HTMLwithAlbino.new(:filter_html => true, :hard_wrap => true, :gh_blockcode => true)
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
    markdown = Redcarpet::Markdown.new(albinoified, options)
    markdown.render(text).html_safe
  end

  class HTMLwithCodeRay < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
    def block_code(code, language)
      CodeRay.scan(code, language).div(:tab_width=>2)
    end
  end

  class HTMLwithAlbino < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
    def block_code(code ,language)
      Albino.colorize(code, language)
    end
  end

end
