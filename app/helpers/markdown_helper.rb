module MarkdownHelper
  def markdown(text)
    unless @markdown
      renderer = Redcarpet::Render::HTML.new
      @markdown = Redcarpet::Markdown.new(renderer)
    end
    if text.present?
      @markdown.render(text).html_safe
    else
      @markdown.render("").html_safe
    end
  end
end
