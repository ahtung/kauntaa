# ApplicationHelper
module ApplicationHelper
  def colored_link_to(link_text, link, options = {})
    link_to link_text, link, class: options[:class], style: "color: #{options[:palette][:text_color]}; background: #{options[:palette][:foreground_color]};", id: options[:id], remote: options[:remote]
  end
end
