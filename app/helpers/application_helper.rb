# ApplicationHelper
module ApplicationHelper
  # returns row and col count given n
  def height_for(n)
    row = Math.sqrt(n + 1).to_i
    col = row
    col_or_row = true
    loop do
      break if col * row > n
      col += 1 if col_or_row
      row += 1 unless col_or_row
      col_or_row = !col_or_row
    end
    100 / row.to_f
  end

  # https://robots.thoughtbot.com/organized-workflow-for-svg
  def embedded_svg(filename, options = {})
    assets = Rails.application.assets
    file = assets.find_asset(filename).body.force_encoding('UTF-8')
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    svg['class'] = options[:class] if options[:class].present?
    raw doc
  end
end
