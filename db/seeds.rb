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

  ['#CEECF8', '#F4C9DD', '#FBFAEF'],
  ['#E5625E', '#0BBCD6', '#FBFAEF'],
  ['#FFFFFF', '#BFB5D7', '#FBFAEF'],
  ['#2D1FE8', '#BEA1A5', '#FBFAEF'],
  ['#EBE8E1', '#F0CE60', '#FBFAEF'],

  ['#FFFFFF', '#0E38B2', '#FBFAEF'],
  ['#0B0C11', '#A6CFE3', '#FBFAEF'],
  ['#BBAB9A', '#371722', '#FBFAEF'],
  ['#018E8F', '#C7C6C4', '#FBFAEF'],
  ['#CF2F89', '#D3B5A9', '#262F88'],
].each do |palette|
  Palette.create(foreground_color: palette[0], background_color: palette[1], text_color: palette[2])
end
Counter.all.map { |c|
  c.palette = Palette.all.sample
  c.save
}