require "./example_helper"

info = Parser.parse(<<~EOT, double_pawn_case: :skip)
開始日時：2001/10/04
棋戦：朝日オープン
戦型：中飛車
備考：反則　二歩▲中飛車穴熊５筋位取り
先手：日浦市郎
後手：田中寅彦

場所：東京「将棋会館」
持ち時間：3時間
*棋戦詳細：第20回朝日オープン将棋選手権本戦1回戦
*「日浦市郎七段」vs「田中寅彦九段」
▲７六歩    △８四歩    ▲５六歩    △３四歩    ▲５五歩    △６二銀
▲７七角    △４二玉    ▲６八銀    △３二玉    ▲５八飛    △４二銀
▲４八玉    △１四歩    ▲３八玉    △１五歩    ▲５七銀    △５二金右
▲２八玉    △４四歩    ▲５六銀    △４三銀    ▲１八香    △８五歩
▲１九玉    △３三角    ▲２八銀    △２四角    ▲６八金    △３三桂
▲５七金    △５四歩    ▲同　歩    △同　銀    ▲４六金    △８六歩
▲同　歩    △４二金上  ▲３六歩    △４三銀    ▲３五歩    △同　歩
▲３六歩    △同　歩    ▲３五歩    △８五歩    ▲同　歩    △同　飛
▲８六歩    △３五飛    ▲同　金    △同　角    ▲８五飛    △７九角成
▲８一飛成  △５一歩    ▲５五銀    △３五馬    ▲４六銀    △同　馬
▲同　歩    △４七金    ▲５二飛成  △同　金    ▲６五角    △３七歩成
▲同　桂    △同　金    ▲同　銀    △３五飛    ▲３四歩    △３七飛成
▲３三歩成  △同　玉    ▲３八金    △３六桂    ▲２九金    △６七龍
▲２五桂    △２四玉    ▲８五龍    △３四銀打  ▲２六金    △３五銀打
▲同　金    △同　銀    ▲４七桂    △５五歩
*二歩の反則
まで88手で先手の反則勝ち
EOT

a = info.to_kif
puts a

b = Parser.parse(info.to_kif).to_kif
a == b                   # => true
# >> 開始日時：2001/10/04
# >> 棋戦：朝日オープン
# >> 戦型：中飛車
# >> 備考：反則　二歩▲中飛車穴熊５筋位取り
# >> 先手：日浦市郎
# >> 後手：田中寅彦
# >> 場所：東京「将棋会館」
# >> 持ち時間：3時間
# >> 手合割：平手
# >> 手数----指手---------消費時間--
# >>    1 ７六歩(77)   (00:00/00:00:00)
# >>    2 ８四歩(83)   (00:00/00:00:00)
# >>    3 ５六歩(57)   (00:00/00:00:00)
# >>    4 ３四歩(33)   (00:00/00:00:00)
# >>    5 ５五歩(56)   (00:00/00:00:00)
# >>    6 ６二銀(71)   (00:00/00:00:00)
# >>    7 ７七角(88)   (00:00/00:00:00)
# >>    8 ４二玉(51)   (00:00/00:00:00)
# >>    9 ６八銀(79)   (00:00/00:00:00)
# >>   10 ３二玉(42)   (00:00/00:00:00)
# >>   11 ５八飛(28)   (00:00/00:00:00)
# >>   12 ４二銀(31)   (00:00/00:00:00)
# >>   13 ４八玉(59)   (00:00/00:00:00)
# >>   14 １四歩(13)   (00:00/00:00:00)
# >>   15 ３八玉(48)   (00:00/00:00:00)
# >>   16 １五歩(14)   (00:00/00:00:00)
# >>   17 ５七銀(68)   (00:00/00:00:00)
# >>   18 ５二金(61)   (00:00/00:00:00)
# >>   19 ２八玉(38)   (00:00/00:00:00)
# >>   20 ４四歩(43)   (00:00/00:00:00)
# >>   21 ５六銀(57)   (00:00/00:00:00)
# >>   22 ４三銀(42)   (00:00/00:00:00)
# >>   23 １八香(19)   (00:00/00:00:00)
# >>   24 ８五歩(84)   (00:00/00:00:00)
# >>   25 １九玉(28)   (00:00/00:00:00)
# >>   26 ３三角(22)   (00:00/00:00:00)
# >>   27 ２八銀(39)   (00:00/00:00:00)
# >>   28 ２四角(33)   (00:00/00:00:00)
# >>   29 ６八金(69)   (00:00/00:00:00)
# >>   30 ３三桂(21)   (00:00/00:00:00)
# >>   31 ５七金(68)   (00:00/00:00:00)
# >>   32 ５四歩(53)   (00:00/00:00:00)
# >>   33 ５四歩(55)   (00:00/00:00:00)
# >>   34 ５四銀(43)   (00:00/00:00:00)
# >>   35 ４六金(57)   (00:00/00:00:00)
# >>   36 ８六歩(85)   (00:00/00:00:00)
# >>   37 ８六歩(87)   (00:00/00:00:00)
# >>   38 ４二金(41)   (00:00/00:00:00)
# >>   39 ３六歩(37)   (00:00/00:00:00)
# >>   40 ４三銀(54)   (00:00/00:00:00)
# >>   41 ３五歩(36)   (00:00/00:00:00)
# >>   42 ３五歩(34)   (00:00/00:00:00)
# >>   43 ３六歩打     (00:00/00:00:00)
# >>   44 ３六歩(35)   (00:00/00:00:00)
# >>   45 ３五歩打     (00:00/00:00:00)
# >>   46 ８五歩打     (00:00/00:00:00)
# >>   47 ８五歩(86)   (00:00/00:00:00)
# >>   48 ８五飛(82)   (00:00/00:00:00)
# >>   49 ８六歩打     (00:00/00:00:00)
# >>   50 ３五飛(85)   (00:00/00:00:00)
# >>   51 ３五金(46)   (00:00/00:00:00)
# >>   52 ３五角(24)   (00:00/00:00:00)
# >>   53 ８五飛打     (00:00/00:00:00)
# >>   54 ７九角成(35) (00:00/00:00:00)
# >>   55 ８一飛成(85) (00:00/00:00:00)
# >>   56 ５一歩打     (00:00/00:00:00)
# >>   57 ５五銀(56)   (00:00/00:00:00)
# >>   58 ３五馬(79)   (00:00/00:00:00)
# >>   59 ４六銀(55)   (00:00/00:00:00)
# >>   60 ４六馬(35)   (00:00/00:00:00)
# >>   61 ４六歩(47)   (00:00/00:00:00)
# >>   62 ４七金打     (00:00/00:00:00)
# >>   63 ５二飛成(58) (00:00/00:00:00)
# >>   64 ５二金(42)   (00:00/00:00:00)
# >>   65 ６五角打     (00:00/00:00:00)
# >>   66 ３七歩成(36) (00:00/00:00:00)
# >>   67 ３七桂(29)   (00:00/00:00:00)
# >>   68 ３七金(47)   (00:00/00:00:00)
# >>   69 ３七銀(28)   (00:00/00:00:00)
# >>   70 ３五飛打     (00:00/00:00:00)
# >>   71 ３四歩打     (00:00/00:00:00)
# >>   72 ３七飛成(35) (00:00/00:00:00)
# >>   73 ３三歩成(34) (00:00/00:00:00)
# >>   74 ３三玉(32)   (00:00/00:00:00)
# >>   75 ３八金(49)   (00:00/00:00:00)
# >>   76 ３六桂打     (00:00/00:00:00)
# >>   77 ２九金打     (00:00/00:00:00)
# >>   78 ６七龍(37)   (00:00/00:00:00)
# >>   79 ２五桂打     (00:00/00:00:00)
# >>   80 ２四玉(33)   (00:00/00:00:00)
# >>   81 ８五龍(81)   (00:00/00:00:00)
# >>   82 ３四銀打     (00:00/00:00:00)
# >>   83 ２六金打     (00:00/00:00:00)
# >>   84 ３五銀打     (00:00/00:00:00)
# >>   85 ３五金(26)   (00:00/00:00:00)
# >>   86 ３五銀(34)   (00:00/00:00:00)
# >>   87 ４七桂打     (00:00/00:00:00)
# >>   88 投了
