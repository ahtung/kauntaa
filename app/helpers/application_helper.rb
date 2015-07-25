# ApplicationHelper
module ApplicationHelper
  def colored_link_to(options = {})
    link_to(options[:link_text], options[:link], class: options[:class], style: "color: #{options[:palette].text_color}", id: options[:id], remote: options[:remote])
  end
end