# KIFファイルの読み込み
require "./example_helper"

info = Parser.parse(Pathname("ryuou20101214.kif"))
tp info.header.to_h

mediator = Mediator.start
info.move_infos.each{|info|
  mediator.execute(info[:input])
}
puts mediator
tp mediator.to_kif_a
tp mediator.to_ki2_a

puts mediator.to_kif_a.group_by.with_index{|v, i|i / 8}.values.collect{|v|v.join(" ")}
puts mediator.to_ki2_a.group_by.with_index{|v, i|i / 8}.values.collect{|v|v.join(" ")}
# >> |----------+----------------------------------|
# >> |   対局ID | 333                              |
# >> | 開始日時 | 2010/12/14 09:00:00              |
# >> | 終了日時 | 2010/12/15 19:13:00              |
# >> |     表題 | 竜王戦                           |
# >> |     棋戦 | 第23期竜王戦七番勝負第6局        |
# >> | 持ち時間 | 各8時間                          |
# >> | 消費時間 | 146▲479△471                    |
# >> |     場所 | 岐阜・ホテルアソシア高山リゾート |
# >> |   手合割 | 平手                             |
# >> |     先手 | 羽生善治                         |
# >> |     後手 | 渡辺 明                          |
# >> |----------+----------------------------------|
# >> 後手の持駒：金二 銀 歩三
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> | ・v桂 ・ ・ 馬 ・ ・v桂v香|一
# >> |v飛 ・ ・ ・ ・ と ・ ・ ・|二
# >> | ・ ・ ・ 全v歩 ・v玉 ・ ・|三
# >> | ・ ・ ・ ・ ・ ・v桂 ・v金|四
# >> | ・v歩 ・ ・ ・ 銀v歩v歩v歩|五
# >> |v歩 ・ 歩v角 ・ ・ ・ ・ ・|六
# >> | ・ 歩 銀v歩vと ・ ・ ・ ・|七
# >> | 歩 ・ 玉 香 ・ ・ ・ ・ 香|八
# >> | 香 桂 ・ ・ ・ ・ 飛 ・ ・|九
# >> +---------------------------+
# >> 先手の持駒：金 歩三
# >> 手数＝146 △３三玉(23) まで
# >> |--------------|
# >> | ７六歩(77)   |
# >> | ８四歩(83)   |
# >> | ７八金(69)   |
# >> | ３二金(41)   |
# >> | ２六歩(27)   |
# >> | ８五歩(84)   |
# >> | ７七角(88)   |
# >> | ３四歩(33)   |
# >> | ８八銀(79)   |
# >> | ７七角成(22) |
# >> | ７七銀(88)   |
# >> | ４二銀(31)   |
# >> | ３八銀(39)   |
# >> | ７二銀(71)   |
# >> | ９六歩(97)   |
# >> | ９四歩(93)   |
# >> | ４六歩(47)   |
# >> | ６四歩(63)   |
# >> | ４七銀(38)   |
# >> | ６三銀(72)   |
# >> | ６八玉(59)   |
# >> | ３三銀(42)   |
# >> | ５八金(49)   |
# >> | ５四銀(63)   |
# >> | ３六歩(37)   |
# >> | ４二玉(51)   |
# >> | ７九玉(68)   |
# >> | ６五歩(64)   |
# >> | ５六銀(47)   |
# >> | ５二金(61)   |
# >> | １六歩(17)   |
# >> | １四歩(13)   |
# >> | ３七桂(29)   |
# >> | ３一玉(42)   |
# >> | ４七金(58)   |
# >> | ４四歩(43)   |
# >> | ２五歩(26)   |
# >> | ４三金(52)   |
# >> | ８八玉(79)   |
# >> | ２二玉(31)   |
# >> | ４八金(47)   |
# >> | ４二金(43)   |
# >> | ２九飛(28)   |
# >> | ４三金(42)   |
# >> | １八香(19)   |
# >> | ９二香(91)   |
# >> | ２八飛(29)   |
# >> | ４二金(43)   |
# >> | ２六飛(28)   |
# >> | ５二金(42)   |
# >> | ２九飛(26)   |
# >> | ４三金(52)   |
# >> | ２八飛(29)   |
# >> | ４二金(43)   |
# >> | ２七飛(28)   |
# >> | ５二金(42)   |
# >> | ４五歩(46)   |
# >> | ４三金(52)   |
# >> | ４四歩(45)   |
# >> | ４四金(43)   |
# >> | ２九飛(27)   |
# >> | ４三金(44)   |
# >> | ４六角打     |
# >> | ９三香(92)   |
# >> | ４五歩打     |
# >> | ４二金(43)   |
# >> | ４七銀(56)   |
# >> | ９二飛(82)   |
# >> | ３五歩(36)   |
# >> | ３五歩(34)   |
# >> | ３五角(46)   |
# >> | ６四角打     |
# >> | ５六歩(57)   |
# >> | ９五歩(94)   |
# >> | ９五歩(96)   |
# >> | ９六歩打     |
# >> | ５七角(35)   |
# >> | ９五香(93)   |
# >> | ９八歩打     |
# >> | ３四歩打     |
# >> | ３六銀(47)   |
# >> | ７四歩(73)   |
# >> | １五歩(16)   |
# >> | １五歩(14)   |
# >> | ２四歩(25)   |
# >> | ２四銀(33)   |
# >> | ２五銀(36)   |
# >> | ４六歩打     |
# >> | ２四銀(25)   |
# >> | ２四歩(23)   |
# >> | ８三銀打     |
# >> | ５二飛(92)   |
# >> | ７四銀成(83) |
# >> | ９一角(64)   |
# >> | ２四飛(29)   |
# >> | ２三金(32)   |
# >> | ２六飛(24)   |
# >> | ２五歩打     |
# >> | ２五桂(37)   |
# >> | ２四歩打     |
# >> | １二歩打     |
# >> | １二玉(22)   |
# >> | ８四角(57)   |
# >> | ４七歩成(46) |
# >> | ４七金(48)   |
# >> | １四金(23)   |
# >> | ９五角(84)   |
# >> | ２五歩(24)   |
# >> | ３六飛(26)   |
# >> | ２三玉(12)   |
# >> | ５五歩(56)   |
# >> | ４五銀(54)   |
# >> | ３九飛(36)   |
# >> | ４六歩打     |
# >> | ３六金(47)   |
# >> | ３六銀(45)   |
# >> | ３六飛(39)   |
# >> | ４七歩成(46) |
# >> | ６三全(74)   |
# >> | ９二飛(52)   |
# >> | ５一角成(95) |
# >> | ６九銀打     |
# >> | ４五銀打     |
# >> | ２二桂打     |
# >> | ４三歩打     |
# >> | ３三金(42)   |
# >> | ３五歩打     |
# >> | ３五歩(34)   |
# >> | ３九飛(36)   |
# >> | ７八銀成(69) |
# >> | ７八玉(88)   |
# >> | ５五角(91)   |
# >> | ３四歩打     |
# >> | ３四桂(22)   |
# >> | ４二歩成(43) |
# >> | ５七と(47)   |
# >> | ６九香打     |
# >> | ６六歩(65)   |
# >> | ６六歩(67)   |
# >> | ６八歩打     |
# >> | ６八香(69)   |
# >> | ６七歩打     |
# >> | ４四銀打     |
# >> | ６六角(55)   |
# >> | ３三銀成(44) |
# >> | ３三玉(23)   |
# >> |--------------|
# >> |------------|
# >> | ▲７六歩   |
# >> | △８四歩   |
# >> | ▲７八金   |
# >> | △３二金   |
# >> | ▲２六歩   |
# >> | △８五歩   |
# >> | ▲７七角   |
# >> | △３四歩   |
# >> | ▲８八銀   |
# >> | △７七角成 |
# >> | ▲同銀     |
# >> | △４二銀   |
# >> | ▲３八銀   |
# >> | △７二銀   |
# >> | ▲９六歩   |
# >> | △９四歩   |
# >> | ▲４六歩   |
# >> | △６四歩   |
# >> | ▲４七銀   |
# >> | △６三銀   |
# >> | ▲６八玉   |
# >> | △３三銀   |
# >> | ▲５八金   |
# >> | △５四銀   |
# >> | ▲３六歩   |
# >> | △４二玉   |
# >> | ▲７九玉   |
# >> | △６五歩   |
# >> | ▲５六銀   |
# >> | △５二金   |
# >> | ▲１六歩   |
# >> | △１四歩   |
# >> | ▲３七桂   |
# >> | △３一玉   |
# >> | ▲４七金   |
# >> | △４四歩   |
# >> | ▲２五歩   |
# >> | △４三金右 |
# >> | ▲８八玉   |
# >> | △２二玉   |
# >> | ▲４八金   |
# >> | △４二金引 |
# >> | ▲２九飛   |
# >> | △４三金直 |
# >> | ▲１八香   |
# >> | △９二香   |
# >> | ▲２八飛   |
# >> | △４二金引 |
# >> | ▲２六飛   |
# >> | △５二金   |
# >> | ▲２九飛   |
# >> | △４三金右 |
# >> | ▲２八飛   |
# >> | △４二金引 |
# >> | ▲２七飛   |
# >> | △５二金   |
# >> | ▲４五歩   |
# >> | △４三金右 |
# >> | ▲４四歩   |
# >> | △同金     |
# >> | ▲２九飛   |
# >> | △４三金引 |
# >> | ▲４六角   |
# >> | △９三香   |
# >> | ▲４五歩   |
# >> | △４二金引 |
# >> | ▲４七銀   |
# >> | △９二飛   |
# >> | ▲３五歩   |
# >> | △同歩     |
# >> | ▲同角     |
# >> | △６四角   |
# >> | ▲５六歩   |
# >> | △９五歩   |
# >> | ▲同歩     |
# >> | △９六歩   |
# >> | ▲５七角   |
# >> | △９五香   |
# >> | ▲９八歩   |
# >> | △３四歩   |
# >> | ▲３六銀   |
# >> | △７四歩   |
# >> | ▲１五歩   |
# >> | △同歩     |
# >> | ▲２四歩   |
# >> | △同銀     |
# >> | ▲２五銀   |
# >> | △４六歩   |
# >> | ▲２四銀   |
# >> | △同歩     |
# >> | ▲８三銀   |
# >> | △５二飛   |
# >> | ▲７四銀成 |
# >> | △９一角   |
# >> | ▲２四飛   |
# >> | △２三金   |
# >> | ▲２六飛   |
# >> | △２五歩   |
# >> | ▲同桂     |
# >> | △２四歩   |
# >> | ▲１二歩   |
# >> | △同玉     |
# >> | ▲８四角   |
# >> | △４七歩成 |
# >> | ▲同金     |
# >> | △１四金   |
# >> | ▲９五角   |
# >> | △２五歩   |
# >> | ▲３六飛   |
# >> | △２三玉   |
# >> | ▲５五歩   |
# >> | △４五銀   |
# >> | ▲３九飛   |
# >> | △４六歩   |
# >> | ▲３六金   |
# >> | △同銀     |
# >> | ▲同飛     |
# >> | △４七歩成 |
# >> | ▲６三全   |
# >> | △９二飛   |
# >> | ▲５一角成 |
# >> | △６九銀   |
# >> | ▲４五銀   |
# >> | △２二桂   |
# >> | ▲４三歩   |
# >> | △３三金   |
# >> | ▲３五歩   |
# >> | △同歩     |
# >> | ▲３九飛   |
# >> | △７八銀成 |
# >> | ▲同玉     |
# >> | △５五角   |
# >> | ▲３四歩   |
# >> | △同桂     |
# >> | ▲４二歩成 |
# >> | △５七と   |
# >> | ▲６九香   |
# >> | △６六歩   |
# >> | ▲同歩     |
# >> | △６八歩   |
# >> | ▲同香     |
# >> | △６七歩   |
# >> | ▲４四銀打 |
# >> | △６六角   |
# >> | ▲３三銀成 |
# >> | △同玉     |
# >> |------------|
# >> ７六歩(77) ８四歩(83) ７八金(69) ３二金(41) ２六歩(27) ８五歩(84) ７七角(88) ３四歩(33)
# >> ８八銀(79) ７七角成(22) ７七銀(88) ４二銀(31) ３八銀(39) ７二銀(71) ９六歩(97) ９四歩(93)
# >> ４六歩(47) ６四歩(63) ４七銀(38) ６三銀(72) ６八玉(59) ３三銀(42) ５八金(49) ５四銀(63)
# >> ３六歩(37) ４二玉(51) ７九玉(68) ６五歩(64) ５六銀(47) ５二金(61) １六歩(17) １四歩(13)
# >> ３七桂(29) ３一玉(42) ４七金(58) ４四歩(43) ２五歩(26) ４三金(52) ８八玉(79) ２二玉(31)
# >> ４八金(47) ４二金(43) ２九飛(28) ４三金(42) １八香(19) ９二香(91) ２八飛(29) ４二金(43)
# >> ２六飛(28) ５二金(42) ２九飛(26) ４三金(52) ２八飛(29) ４二金(43) ２七飛(28) ５二金(42)
# >> ４五歩(46) ４三金(52) ４四歩(45) ４四金(43) ２九飛(27) ４三金(44) ４六角打 ９三香(92)
# >> ４五歩打 ４二金(43) ４七銀(56) ９二飛(82) ３五歩(36) ３五歩(34) ３五角(46) ６四角打
# >> ５六歩(57) ９五歩(94) ９五歩(96) ９六歩打 ５七角(35) ９五香(93) ９八歩打 ３四歩打
# >> ３六銀(47) ７四歩(73) １五歩(16) １五歩(14) ２四歩(25) ２四銀(33) ２五銀(36) ４六歩打
# >> ２四銀(25) ２四歩(23) ８三銀打 ５二飛(92) ７四銀成(83) ９一角(64) ２四飛(29) ２三金(32)
# >> ２六飛(24) ２五歩打 ２五桂(37) ２四歩打 １二歩打 １二玉(22) ８四角(57) ４七歩成(46)
# >> ４七金(48) １四金(23) ９五角(84) ２五歩(24) ３六飛(26) ２三玉(12) ５五歩(56) ４五銀(54)
# >> ３九飛(36) ４六歩打 ３六金(47) ３六銀(45) ３六飛(39) ４七歩成(46) ６三全(74) ９二飛(52)
# >> ５一角成(95) ６九銀打 ４五銀打 ２二桂打 ４三歩打 ３三金(42) ３五歩打 ３五歩(34)
# >> ３九飛(36) ７八銀成(69) ７八玉(88) ５五角(91) ３四歩打 ３四桂(22) ４二歩成(43) ５七と(47)
# >> ６九香打 ６六歩(65) ６六歩(67) ６八歩打 ６八香(69) ６七歩打 ４四銀打 ６六角(55)
# >> ３三銀成(44) ３三玉(23)
# >> ▲７六歩 △８四歩 ▲７八金 △３二金 ▲２六歩 △８五歩 ▲７七角 △３四歩
# >> ▲８八銀 △７七角成 ▲同銀 △４二銀 ▲３八銀 △７二銀 ▲９六歩 △９四歩
# >> ▲４六歩 △６四歩 ▲４七銀 △６三銀 ▲６八玉 △３三銀 ▲５八金 △５四銀
# >> ▲３六歩 △４二玉 ▲７九玉 △６五歩 ▲５六銀 △５二金 ▲１六歩 △１四歩
# >> ▲３七桂 △３一玉 ▲４七金 △４四歩 ▲２五歩 △４三金右 ▲８八玉 △２二玉
# >> ▲４八金 △４二金引 ▲２九飛 △４三金直 ▲１八香 △９二香 ▲２八飛 △４二金引
# >> ▲２六飛 △５二金 ▲２九飛 △４三金右 ▲２八飛 △４二金引 ▲２七飛 △５二金
# >> ▲４五歩 △４三金右 ▲４四歩 △同金 ▲２九飛 △４三金引 ▲４六角 △９三香
# >> ▲４五歩 △４二金引 ▲４七銀 △９二飛 ▲３五歩 △同歩 ▲同角 △６四角
# >> ▲５六歩 △９五歩 ▲同歩 △９六歩 ▲５七角 △９五香 ▲９八歩 △３四歩
# >> ▲３六銀 △７四歩 ▲１五歩 △同歩 ▲２四歩 △同銀 ▲２五銀 △４六歩
# >> ▲２四銀 △同歩 ▲８三銀 △５二飛 ▲７四銀成 △９一角 ▲２四飛 △２三金
# >> ▲２六飛 △２五歩 ▲同桂 △２四歩 ▲１二歩 △同玉 ▲８四角 △４七歩成
# >> ▲同金 △１四金 ▲９五角 △２五歩 ▲３六飛 △２三玉 ▲５五歩 △４五銀
# >> ▲３九飛 △４六歩 ▲３六金 △同銀 ▲同飛 △４七歩成 ▲６三全 △９二飛
# >> ▲５一角成 △６九銀 ▲４五銀 △２二桂 ▲４三歩 △３三金 ▲３五歩 △同歩
# >> ▲３九飛 △７八銀成 ▲同玉 △５五角 ▲３四歩 △同桂 ▲４二歩成 △５七と
# >> ▲６九香 △６六歩 ▲同歩 △６八歩 ▲同香 △６七歩 ▲４四銀打 △６六角
# >> ▲３三銀成 △同玉
