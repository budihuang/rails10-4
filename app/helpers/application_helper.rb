
module ApplicationHelper

   def markdown(str, options = {})
      # XXX: the renderer instance should be a class variable

      options[:hard_wrap] ||= false
      options[:class] ||= ''
      assembler = Redcarpet::Render::HTML.new(:hard_wrap => options[:hard_wrap]) # auto <br> in <p>

      renderer = Redcarpet::Markdown.new(assembler, {
        :autolink => true,
        :fenced_code_blocks => true
      })
      content_tag(:div, raw($markdown.render(str)), :class => options[:class])
    end
  end
