Palette.delete_all
[
  ['#F9F8E6', '#FF8C8B', '#FBFAEF'],
  ['#62BFAD', '#F9F7E8', '#62BFAD'],
  ['#FFFFFF', '#62BFAD', '#FFFFFF'],
  ['#FFFFFF', '#E54B4B', '#FFFFFF'],
  ['#FFFFFF', '#177C80', '#FFFFFF'],

  ['#F03F35', '#B7E3E4', '#F03F35'],
  ['#FF4552', '#EFE8D8', '#FF4552'],
  ['#E13334', '#005397', '#E13334'],
  ['#FFFFFF', '#33B67A', '#FFFFFF'],
  ['#000000', '#FACAC0', '#FFFFFF'],
].each do |palette|
  Palette.create(foreground_color: palette[0], background_color: palette[1], text_color: palette[2])
end
Counter.all.map { |c|
  c.palette = Palette.all.sample
  c.save
}