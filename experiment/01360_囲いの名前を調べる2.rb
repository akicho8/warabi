require "./example_helper"

info = Parser.file_parse("yagura.kif")
info.mediator.players.each do |player|
  tp player.skill_set.to_h
end
puts info.to_kif
# >> |---------+--------------------|
# >> | defense | [:総矢倉, :菱矢倉] |
# >> |  attack | [:四手角]          |
# >> |---------+--------------------|
# >> |---------+-------------|
# >> | defense | [:雁木囲い] |
# >> |  attack | [:四手角]   |
# >> |---------+-------------|
# >> 開始日時：1981/05/15 09:00:00
# >> 棋戦：名将戦
# >> 場所：東京「将棋会館」
# >> 手合割：平手
# >> 先手：加藤一二三
# >> 後手：原田泰夫
# >> 戦型：矢倉
# >> 先手の囲い：総矢倉, 菱矢倉
# >> 後手の囲い：雁木囲い
# >> 先手の戦型：四手角
# >> 後手の戦型：四手角
# >> 手数----指手---------消費時間--
# >>    1 ７六歩(77)   (00:00/00:00:00)
# >>    2 ８四歩(83)   (00:00/00:00:00)
# >>    3 ６八銀(79)   (00:00/00:00:00)
# >>    4 ３四歩(33)   (00:00/00:00:00)
# >>    5 ７七銀(68)   (00:00/00:00:00)
# >>    6 ６二銀(71)   (00:00/00:00:00)
# >>    7 ２六歩(27)   (00:00/00:00:00)
# >>    8 ４二銀(31)   (00:00/00:00:00)
# >>    9 ４八銀(39)   (00:00/00:00:00)
# >>   10 ３二金(41)   (00:00/00:00:00)
# >>   11 ５六歩(57)   (00:00/00:00:00)
# >>   12 ４一玉(51)   (00:00/00:00:00)
# >>   13 ７八金(69)   (00:00/00:00:00)
# >>   14 ５四歩(53)   (00:00/00:00:00)
# >>   15 ６九玉(59)   (00:00/00:00:00)
# >>   16 ７四歩(73)   (00:00/00:00:00)
# >>   17 ３六歩(37)   (00:00/00:00:00)
# >>   18 ５三銀(62)   (00:00/00:00:00)
# >>   19 ５七銀(48)   (00:00/00:00:00)
# >>   20 ４四歩(43)   (00:00/00:00:00)
# >>   21 ２五歩(26)   (00:00/00:00:00)
# >>   22 ３三角(22)   (00:00/00:00:00)
# >>   23 ５八金(49)   (00:00/00:00:00)
# >>   24 ４三銀(42)   (00:00/00:00:00)
# >>   25 ７九角(88)   (00:00/00:00:00)
# >>   26 ５一角(33)   (00:00/00:00:00)
# >>   27 ６八角(79)   (00:00/00:00:00)
# >>   28 ５二金(61)   (00:00/00:00:00)
# >> *△囲い：雁木囲い
# >>   29 ７九玉(69)   (00:00/00:00:00)
# >>   30 ３一玉(41)   (00:00/00:00:00)
# >>   31 ６六歩(67)   (00:00/00:00:00)
# >>   32 ８五歩(84)   (00:00/00:00:00)
# >>   33 ６七金(58)   (00:00/00:00:00)
# >>   34 １四歩(13)   (00:00/00:00:00)
# >>   35 ８八玉(79)   (00:00/00:00:00)
# >> *▲囲い：総矢倉
# >>   36 ９四歩(93)   (00:00/00:00:00)
# >>   37 ９六歩(97)   (00:00/00:00:00)
# >>   38 １五歩(14)   (00:00/00:00:00)
# >>   39 ４六歩(47)   (00:00/00:00:00)
# >>   40 ２二玉(31)   (00:00/00:00:00)
# >>   41 ５九角(68)   (00:00/00:00:00)
# >>   42 ６四歩(63)   (00:00/00:00:00)
# >>   43 ２六角(59)   (00:00/00:00:00)
# >> *▲戦型：四手角
# >>   44 ８四角(51)   (00:00/00:00:00)
# >> *△戦型：四手角
# >>   45 ３七桂(29)   (00:00/00:00:00)
# >>   46 ３三桂(21)   (00:00/00:00:00)
# >>   47 ２九飛(28)   (00:00/00:00:00)
# >>   48 ７三桂(81)   (00:00/00:00:00)
# >>   49 １八香(19)   (00:00/00:00:00)
# >>   50 ６五歩(64)   (00:00/00:00:00)
# >>   51 １六歩(17)   (00:00/00:00:00)
# >>   52 １六歩(15)   (00:00/00:00:00)
# >>   53 １九飛(29)   (00:00/00:00:00)
# >>   54 ８一飛(82)   (00:00/00:00:00)
# >>   55 １六香(18)   (00:00/00:00:00)
# >>   56 １四歩打     (00:00/00:00:00)
# >>   57 １四香(16)   (00:00/00:00:00)
# >>   58 １四香(11)   (00:00/00:00:00)
# >>   59 １五歩打     (00:00/00:00:00)
# >>   60 １五香(14)   (00:00/00:00:00)
# >>   61 １五飛(19)   (00:00/00:00:00)
# >>   62 １四歩打     (00:00/00:00:00)
# >>   63 １九飛(15)   (00:00/00:00:00)
# >>   64 ６六歩(65)   (00:00/00:00:00)
# >>   65 ６六銀(57)   (00:00/00:00:00)
# >> *▲囲い：菱矢倉
# >>   66 ６五歩打     (00:00/00:00:00)
# >>   67 ５七銀(66)   (00:00/00:00:00)
# >>   68 ９五歩(94)   (00:00/00:00:00)
# >>   69 ９五歩(96)   (00:00/00:00:00)
# >>   70 ９五香(91)   (00:00/00:00:00)
# >>   71 ９六歩打     (00:00/00:00:00)
# >>   72 ９六香(95)   (00:00/00:00:00)
# >>   73 ９六香(99)   (00:00/00:00:00)
# >>   74 ９五歩打     (00:00/00:00:00)
# >>   75 ９五香(96)   (00:00/00:00:00)
# >>   76 ９五角(84)   (00:00/00:00:00)
# >>   77 ９九香打     (00:00/00:00:00)
# >>   78 ８四角(95)   (00:00/00:00:00)
# >>   79 ６八金(67)   (00:00/00:00:00)
# >>   80 ６六歩(65)   (00:00/00:00:00)
# >>   81 ６六銀(57)   (00:00/00:00:00)
# >>   82 ６七歩打     (00:00/00:00:00)
# >>   83 ６七金(68)   (00:00/00:00:00)
# >>   84 ６三香打     (00:00/00:00:00)
# >>   85 １三歩打     (00:00/00:00:00)
# >>   86 ６六香(63)   (00:00/00:00:00)
# >>   87 ６六金(67)   (00:00/00:00:00)
# >>   88 ６三香打     (00:00/00:00:00)
# >>   89 ６七歩打     (00:00/00:00:00)
# >>   90 ５七銀打     (00:00/00:00:00)
# >>   91 ６九香打     (00:00/00:00:00)
# >>   92 ６五桂(73)   (00:00/00:00:00)
# >>   93 ６五金(66)   (00:00/00:00:00)
# >>   94 ６五香(63)   (00:00/00:00:00)
# >>   95 ３五歩(36)   (00:00/00:00:00)
# >>   96 ５八銀(57)   (00:00/00:00:00)
# >>   97 ３四歩(35)   (00:00/00:00:00)
# >>   98 ３四銀(43)   (00:00/00:00:00)
# >>   99 ３六香打     (00:00/00:00:00)
# >>  100 ２七金打     (00:00/00:00:00)
# >>  101 １二歩成(13) (00:00/00:00:00)
# >>  102 ３一玉(22)   (00:00/00:00:00)
# >>  103 ３四香(36)   (00:00/00:00:00)
# >>  104 ２六金(27)   (00:00/00:00:00)
# >>  105 ３三香成(34) (00:00/00:00:00)
# >>  106 ３三金(32)   (00:00/00:00:00)
# >>  107 ３四歩打     (00:00/00:00:00)
# >>  108 ３二金(33)   (00:00/00:00:00)
# >>  109 ４五桂打     (00:00/00:00:00)
# >>  110 ４五歩(44)   (00:00/00:00:00)
# >>  111 ４五桂(37)   (00:00/00:00:00)
# >>  112 ４二玉(31)   (00:00/00:00:00)
# >>  113 ３三歩成(34) (00:00/00:00:00)
# >>  114 ３三金(32)   (00:00/00:00:00)
# >>  115 ３三桂成(45) (00:00/00:00:00)
# >>  116 ３三玉(42)   (00:00/00:00:00)
# >>  117 ３五銀打     (00:00/00:00:00)
# >>  118 ５七角成(84) (00:00/00:00:00)
# >>  119 ４五桂打     (00:00/00:00:00)
# >>  120 ４二玉(33)   (00:00/00:00:00)
# >>  121 ６八金打     (00:00/00:00:00)
# >>  122 ４七馬(57)   (00:00/00:00:00)
# >>  123 ３四歩打     (00:00/00:00:00)
# >>  124 ８六桂打     (00:00/00:00:00)
# >>  125 ８六歩(87)   (00:00/00:00:00)
# >>  126 ８六歩(85)   (00:00/00:00:00)
# >>  127 ８五歩打     (00:00/00:00:00)
# >>  128 ６七香成(65) (00:00/00:00:00)
# >>  129 ６七金(68)   (00:00/00:00:00)
# >>  130 ６九銀(58)   (00:00/00:00:00)
# >>  131 ８六銀(77)   (00:00/00:00:00)
# >>  132 ７八銀成(69) (00:00/00:00:00)
# >>  133 ７八玉(88)   (00:00/00:00:00)
# >>  134 ６六歩打     (00:00/00:00:00)
# >>  135 ６六金(67)   (00:00/00:00:00)
# >>  136 ６三香打     (00:00/00:00:00)
# >>  137 ３三歩成(34) (00:00/00:00:00)
# >>  138 ５一玉(42)   (00:00/00:00:00)
# >>  139 ５三桂成(45) (00:00/00:00:00)
# >>  140 ６九角打     (00:00/00:00:00)
# >>  141 ６九飛(19)   (00:00/00:00:00)
# >>  142 ６九馬(47)   (00:00/00:00:00)
# >>  143 ６九玉(78)   (00:00/00:00:00)
# >>  144 ６六香(63)   (00:00/00:00:00)
# >>  145 ６八歩打     (00:00/00:00:00)
# >>  146 ６八香成(66) (00:00/00:00:00)
# >>  147 ６八玉(69)   (00:00/00:00:00)
# >>  148 ８八飛打     (00:00/00:00:00)
# >>  149 ７八銀打     (00:00/00:00:00)
# >>  150 ６四香打     (00:00/00:00:00)
# >>  151 ６七歩打     (00:00/00:00:00)
# >>  152 ５八金打     (00:00/00:00:00)
# >>  153 ７九玉(68)   (00:00/00:00:00)
# >>  154 投了         (00:00/00:00:00)
# >> まで153手で先手の勝ち
