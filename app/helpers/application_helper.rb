module ApplicationHelper
	def coderay(text)
  	text.gsub(/\<code( lang="(.+?)")?\>(.+?)\<\/code\>/m) do
    	content_tag("notextile", CodeRay.scan($3, $2).div(:css => :class))
  	end
	end
=begin
  def markdown(text)
  	renderer = Redcarpet::Render::HTML.new(
      no_links: true, hard_wrap: true, filter_html: true, autolink: true,  
      no_intraemphasis: true, fenced_code: true, gh_blockcode: true)
		markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
    markdown.render(text)
  end

  class HTMLwithCodeRay < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language).div(:tab_width=>2)
    end
  end
=end


class CodeRayify < Redcarpet::Render::HTML
  def block_code(code, language)
    CodeRay.scan(code, language).div
  end
end

def markdown(text)
  coderayified = CodeRayify.new(:filter_html => true, :escape_html => true,
                                :hard_wrap => true)
  options = {
    :fenced_code_blocks => true,
    :no_intra_emphasis => true,
    :autolink => true,
    :strikethrough => true,
    :lax_html_blocks => true,
    :superscript => true
  }
  markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
  markdown_to_html.render(text).html_safe
end

end
