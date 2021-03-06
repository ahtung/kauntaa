Palette.delete_all
[
  ['#F9F8E6', '#FF8C8B', '#FBFAEF'],
  ['#62BFAD', '#F9F7E8', '#62BFAD'],
  ['#FFFFFF', '#62BFAD', '#FFFFFF'],
  ['#FFFFFF', '#E54B4B', '#FFFFFF'],
  ['#FFFFFF', '#177C80', '#FFFFFF'], # 5

  ['#F03F35', '#B7E3E4', '#F03F35'],
  ['#FF4552', '#EFE8D8', '#FF4552'],
  ['#E13334', '#005397', '#E13334'],
  ['#FFFFFF', '#33B67A', '#FFFFFF'],
  ['#000000', '#FACAC0', '#FFFFFF'], # 10

  ['#CEECF8', '#F4C9DD', '#FBFAEF'],
  ['#E5625E', '#0BBCD6', '#FBFAEF'],
  ['#FFFFFF', '#BFB5D7', '#FBFAEF'],
  ['#2D1FE8', '#BEA1A5', '#FBFAEF'],
  ['#EBE8E1', '#F0CE60', '#FBFAEF'], # 15

  ['#FFFFFF', '#0E38B2', '#FBFAEF'],
  ['#0B0C11', '#A6CFE3', '#FBFAEF'],
  ['#BBAB9A', '#371722', '#FBFAEF'],
  ['#018E8F', '#C7C6C4', '#FBFAEF'],
  ['#CF2F89', '#D3B5A9', '#262F88'], # 20

  ['#19227D', '#F1C2B8', '#FBFAEF'],
  ['#96CBD1', '#EE3E49', '#FCD7C3'],
  ['#FD677B', '#C0C2CE', '#072E65'],
  ['#162BF4', '#EEC0DC', '#FBFAEF'],
  ['#BF2A1A', '#B6CAC1', '#FBFAEF'], # 25

  ['#B22A48', '#C5BEAA', '#182C76'],
  ['#D31C33', '#FDF06E', '#FBFAEF'],
  ['#BEDFD4', '#EDB6BC', '#FBFAEF'],
  ['#FFFFFF', '#17C27B', '#FBFAEF'],
  ['#14A19B', '#293571', '#FBFAEF'], # 30

  ['#E91921', '#1B1D1C', '#FBFAEF'],
  ['#181A27', '#E88564', '#FBFAEF'],
  ['#1FC8A9', '#FFEFE5', '#FBFAEF'],
  ['#008FD3', '#F4C7EE', '#FBFAEF'],
  ['#28292B', '#78EEE0', '#FBFAEF'],  # 35

  ['#28292B', '#E57166', '#FBFAEF'],
  ['#28292B', '#EFD974', '#FBFAEF'],
  ['#0B64C0', '#FBFE57', '#FBFAEF'],
  ['#C886A2', '#A7BBC2', '#FBFAEF'],
  ['#E8E7D1', '#3D495F', '#FBFAEF'], # 40

  ['#E6E6E6', '#055A5C', '#FBFAEF'],
  ['#FDE4C8', '#178D96', '#FBFAEF'],
  ['#E44A66', '#D3E8E1', '#FBFAEF'],
  ['#FAE397', '#CBA0AA', '#FBFAEF'],
  ['#F9BDBD', '#9C9BDE', '#FBFAEF'], # 45

  ['#FEC8BE', '#20AD66', '#FBFAEF'],
  ['#58B89D', '#E75152', '#FBFAEF'],
  ['#E75152', '#4F3A4B', '#FBFAEF'],
  ['#FBECCF', '#112379', '#FBFAEF'],
  ['#FDEEB3', '#CF3440', '#FBFAEF'], # 50

  ['#FFFFFF', '#FDDCCB', '#FBFAEF'],
  ['#EDC3C7', '#00B18C', '#FBFAEF'],
  ['#040507', '#9257A9', '#FBFAEF'],
  ['#FF5035', '#C6D7C7', '#FBFAEF'],
  ['#FF5035', '#B2FCEB', '#FBFAEF'], # 55

  ['#BB828B', '#BEF6E9', '#FBFAEF'],
  ['#CC9AB5', '#776EA7', '#FBFAEF'],
  ['#ABCEE2', '#EAEAEA', '#FBFAEF'],
  ['#471C19', '#EF303A', '#FBFAEF'],
  ['#FFFFFF', '#000015', '#FBFAEF'], # 60

  ['#199BA3', '#FFFDE7', '#EB0817'],
  ['#1538CF', '#F1D3D3', '#FBFAEF'],
  ['#F3BFA9', '#D2E8E3', '#FBFAEF'],
  ['#F3E836', '#F1EBDF', '#FBFAEF'],
  ['#F2CB6C', '#3A745E', '#FBFAEF'], # 65

  ['#84CFBB', '#CE7082', '#FBFAEF'],
  ['#9B8FFF', '#340A0B', '#FBFAEF'],
  ['#0B3833', '#F7EBED', '#4A4A4A'],
  ['#E2B7C1', '#FF9A66', '#FBFAEF'],
  ['#CDFFCC', '#002FEB', '#FBFAEF'], # 70

  ['#FFFFFF', '#F5623A', '#1E3265'],
  ['#2B47B2', '#FDC862', '#F49A20'],
  ['#0B57CA', '#94C9DB', '#122959']  # 73
].each do |palette|
  Palette.create(foreground_color: palette[0], background_color: palette[1], text_color: palette[2])
end

Counter.all.map do |c|
  c.palette = Palette.all.sample
  c.save
end