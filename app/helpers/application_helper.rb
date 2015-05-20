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
end
