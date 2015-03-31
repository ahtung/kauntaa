[
  ['#F9F8E6', '#FF8C8B', '#FF8B8B'],
  ['#62BFAD', '#F9F7E8', '#FF8B8B'],
  ['#FFFFFF', '#62BFAD', '#FF8B8B'],
  ['#FFFFFF', '#E54B4B', '#FF8B8B'],
  ['#FFFFFF', '#177C80', '#FF8B8B'],
].each do |palette|
  Palette.create(foreground_color: palette[0], background_color: palette[1], text_color: palette[2])
end