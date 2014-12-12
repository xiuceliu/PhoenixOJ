module DiscussesHelper
	def nested_discusses(discusses)
    discusses.map do |discuss, sub_discusses|
      render(discuss) + content_tag(:div, nested_discusses(sub_discusses), :class => "nested_discusses")
    end.join.html_safe
  end
end
