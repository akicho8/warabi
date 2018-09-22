require "./example_helper"

mediator = Mediator.start
loop do
  hand = mediator.current_player.brain.normal_all_hands.to_a.sample
  mediator.execute(hand)
  captured_soldier = mediator.opponent_player.executor.captured_soldier
  if captured_soldier && captured_soldier.piece.key == :king
    break
  end
end
puts mediator.to_s
puts mediator.to_kif_a.group_by.with_index{|v, i|i / 8}.values.collect{|v|v.join(" ")}
puts mediator.to_ki2_a.group_by.with_index{|v, i|i / 8}.values.collect{|v|v.join(" ")}
# >> 後手の持駒：玉
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> | ・ ・ 杏 金 ・ ・ 圭 ・ ・|一
# >> |v銀v歩 ・ ・ ・ 歩 馬 と ・|二
# >> | 金 ・ ・v飛 全 ・ ・ ・ 圭|三
# >> | 金 ・v歩v玉 ・v歩 歩 ・ 歩|四
# >> | ・ 歩 ・ ・v歩 ・ ・ 歩 香|五
# >> | 飛 ・ 歩 ・ 歩 ・v歩 ・ ・|六
# >> | 桂 ・ ・ 角 ・ ・ ・ 銀 ・|七
# >> | 香 ・ ・ ・ ・ ・ ・vと ・|八
# >> | 歩v金v全v圭 ・ ・ ・ ・ ・|九
# >> +---------------------------+
# >> 先手の持駒：香 歩三
# >> 手数＝278 △３六歩(35) まで
# >> 
# >> 先手番
# >> ８六歩(87) ６二銀(71) ７八銀(79) ４二金(41) １六歩(17) ７一金(61) １五歩(16) ６一玉(51)
# >> ６八金(69) ５二金(42) １六香(19) ５一玉(61) ４八玉(59) ９二飛(82) ６九金(68) ３二銀(31)
# >> ５九金(49) １二香(11) ７九金(69) ７二飛(92) ６九金(59) ４四歩(43) ６六歩(67) １四歩(13)
# >> ２六歩(27) ７四歩(73) ３八飛(28) ５四歩(53) ６七銀(78) １一角(22) ２五歩(26) ８二金(71)
# >> ５八銀(67) ６一玉(51) ８五歩(86) ２二角(11) ４六歩(47) ４二金(52) ６七銀(58) ７一飛(72)
# >> ７六銀(67) ６四歩(63) １七桂(29) ９四歩(93) ２八銀(39) ４三金(42) ３九飛(38) ７三銀(62)
# >> ５八玉(48) １一角(22) ４八玉(58) ９二金(82) ７八金(69) ４一銀(32) ５九飛(39) ９五歩(94)
# >> ８七銀(76) ４二金(43) ７六歩(77) ３四歩(33) ６八金(79) ８二銀(73) ５八玉(48) ３二銀(41)
# >> ６七金(78) ３五歩(34) ４八玉(58) ７三桂(81) ７八金(68) ８四歩(83) ６八金(78) ５五歩(54)
# >> ８六銀(87) ５一玉(61) ７九飛(59) ７五歩(74) ５九玉(48) １三桂(21) ７八飛(79) ３三金(42)
# >> ３六歩(37) ４五歩(44) ４八玉(59) ２五桂(13) ２五桂(17) ９三金(92) ４七玉(48) ４二玉(51)
# >> ７九角(88) ４三玉(42) ４四桂打 ５二玉(43) ７七金(68) ８五桂(73) ３七玉(47) ７二飛(71)
# >> １三桂成(25) ３四金(33) ６八飛(78) ８三金(93) ３二桂成(44) ６三玉(52) ５三銀打 ７四金(83)
# >> ３八飛(68) ９二香(91) ７五銀(86) ７五金(74) １四歩(15) ２四歩(23) ４一圭(32) ７一銀(82)
# >> ４五歩(46) ９三香(92) ８八飛(38) ５六銀打 ８七歩打 ６七銀成(56) ６五歩(66) １九金打
# >> ２七玉(37) ５四玉(63) ９八香(99) ３六歩(35) ５二銀成(53) １七歩打 ３二歩打 ４四金(34)
# >> １九銀(28) ９四香(93) ９二金打 ２五歩(24) ２六歩打 ３三角(11) ７八飛(88) ８六金(75)
# >> ６四歩(65) ６二銀(71) １八飛(78) ２二角(33) ５一全(52) ６六全(67) ８二金(92) ９七桂成(85)
# >> ２八飛(18) ５六全(66) ７一金(82) ３三角(22) ９七角(79) ５三銀(62) ６三桂打 ７四歩打
# >> ７九角(97) ６七全(56) ８八角(79) ４五金(44) ４二歩打 ８七金(86) ６一金(71) ８八金(87)
# >> ２五歩(26) ６四玉(54) ８六金(77) ２二角(33) ６八歩打 ８二角打 ７一桂成(63) １一角(22)
# >> ３六玉(27) ７五玉(64) ９五金(86) １八歩成(17) ２六玉(36) ７八金(88) ３八飛(28) ３一歩打
# >> ７二圭(71) ６二銀(53) ８六飛打 ７一銀(62) ８三歩打 １五歩打 ９六飛(86) ６五玉(75)
# >> ８二歩成(83) ７七金(78) ８一と(82) ３三角(11) １五玉(26) ２八歩打 ３四角打 ７二銀(71)
# >> ８二と(81) ５六桂打 ３一歩成(32) ４三歩打 ３九飛(38) １七と(18) ９一と(82) ３五歩打
# >> ４五角(34) ６八金(77) １二角成(45) ９二歩打 ９三金打 ８一銀(72) ２二馬(12) ２七と(17)
# >> ８三香打 ６六玉(65) ２一と(31) ８五歩(84) ３一馬(22) ４四歩(43) ９二と(91) ２九歩成(28)
# >> ３四歩打 ３九と(29) ８二香成(83) ４三飛打 ８八歩打 ３八と(39) ８三杏(82) ３九と(38)
# >> ３二馬(31) ２八と(27) ２二と(21) ７九金(68) ９九歩打 ３八と(39) ９七桂(89) ９二銀(81)
# >> ８七歩(88) ３九と(38) ２六玉(15) ３八と(39) ８六歩(87) １五角(33) １五香(16) １八と(28)
# >> ７二杏(83) ６八桂成(56) ７一杏(72) ６九圭(68) ７八角打 ７五玉(66) ８五金(95) ８二歩打
# >> ２三馬(32) ８九金(79) ８四金(85) ５八全(67) ５六歩(57) ６八全(58) ８五歩(86) ３七と(38)
# >> １八銀(19) ３三飛(43) ３一圭(41) ３八と(37) ５二全(51) ８三飛(33) ５三全(52) ７三飛(83)
# >> ２七銀(18) ３七と(38) ２一圭(31) ２八と(37) ６七角(78) ７九全(68) ９四金(84) ６三飛(73)
# >> ３一圭(21) ６五玉(75) ３六玉(26) ６四玉(65) ３二馬(23) ３六歩(35)
# >> ▲８六歩 △６二銀 ▲７八銀 △４二金 ▲１六歩 △７一金 ▲１五歩 △６一玉
# >> ▲６八金 △５二金 ▲１六香 △５一玉 ▲４八玉 △９二飛 ▲６九金 △３二銀
# >> ▲５九金右 △１二香 ▲７九金 △７二飛 ▲６九金右 △４四歩 ▲６六歩 △１四歩
# >> ▲２六歩 △７四歩 ▲３八飛 △５四歩 ▲６七銀 △１一角 ▲２五歩 △８二金
# >> ▲５八銀 △６一玉 ▲８五歩 △２二角 ▲４六歩 △４二金 ▲６七銀 △７一飛
# >> ▲７六銀 △６四歩 ▲１七桂 △９四歩 ▲２八銀 △４三金 ▲３九飛 △７三銀
# >> ▲５八玉 △１一角 ▲４八玉 △９二金 ▲７八金右 △４一銀 ▲５九飛 △９五歩
# >> ▲８七銀 △４二金 ▲７六歩 △３四歩 ▲６八金上 △８二銀 ▲５八玉 △３二銀
# >> ▲６七金左 △３五歩 ▲４八玉 △７三桂 ▲７八金 △８四歩 ▲６八金寄 △５五歩
# >> ▲８六銀 △５一玉 ▲７九飛 △７五歩 ▲５九玉 △１三桂 ▲７八飛 △３三金
# >> ▲３六歩 △４五歩 ▲４八玉 △２五桂 ▲同桂 △９三金 ▲４七玉 △４二玉
# >> ▲７九角 △４三玉 ▲４四桂 △５二玉 ▲７七金上 △８五桂 ▲３七玉 △７二飛
# >> ▲１三桂成 △３四金 ▲６八飛 △８三金 ▲３二桂成 △６三玉 ▲５三銀 △７四金
# >> ▲３八飛 △９二香 ▲７五銀 △同金 ▲１四歩 △２四歩 ▲４一圭 △７一銀
# >> ▲４五歩 △９三香 ▲８八飛 △５六銀 ▲８七歩 △６七銀成 ▲６五歩 △１九金
# >> ▲２七玉 △５四玉 ▲９八香 △３六歩 ▲５二銀成 △１七歩 ▲３二歩 △４四金
# >> ▲１九銀 △９四香 ▲９二金 △２五歩 ▲２六歩 △３三角 ▲７八飛 △８六金
# >> ▲６四歩 △６二銀 ▲１八飛 △２二角 ▲５一全 △６六全 ▲８二金 △９七桂成
# >> ▲２八飛 △５六全 ▲７一金 △３三角 ▲９七角 △５三銀 ▲６三桂 △７四歩
# >> ▲７九角 △６七全 ▲８八角 △４五金 ▲４二歩 △８七金 ▲６一金 △８八金
# >> ▲２五歩 △６四玉 ▲８六金 △２二角 ▲６八歩 △８二角 ▲７一桂成 △１一角
# >> ▲３六玉 △７五玉 ▲９五金 △１八歩成 ▲２六玉 △７八金 ▲３八飛 △３一歩
# >> ▲７二圭 △６二銀 ▲８六飛 △７一銀 ▲８三歩 △１五歩 ▲９六飛 △６五玉
# >> ▲８二歩成 △７七金 ▲８一と △３三角 ▲１五玉 △２八歩 ▲３四角 △７二銀
# >> ▲８二と △５六桂 ▲３一歩成 △４三歩 ▲３九飛 △１七と ▲９一と △３五歩
# >> ▲４五角 △６八金 ▲１二角成 △９二歩 ▲９三金 △８一銀 ▲２二馬 △２七と
# >> ▲８三香 △６六玉 ▲２一と △８五歩 ▲３一馬 △４四歩 ▲９二と △２九歩成
# >> ▲３四歩 △３九と ▲８二香成 △４三飛 ▲８八歩 △３八と引 ▲８三杏 △３九と
# >> ▲３二馬 △２八と ▲２二と △７九金 ▲９九歩 △３八と引 ▲９七桂 △９二銀
# >> ▲８七歩 △３九と直 ▲２六玉 △３八と引 ▲８六歩 △１五角 ▲同香 △１八と
# >> ▲７二杏 △６八桂成 ▲７一杏 △６九圭 ▲７八角 △７五玉 ▲８五金 △８二歩
# >> ▲２三馬 △８九金 ▲８四金 △５八全 ▲５六歩 △６八全 ▲８五歩 △３七と
# >> ▲１八銀 △３三飛 ▲３一圭 △３八と ▲５二全 △８三飛 ▲５三全 △７三飛
# >> ▲２七銀 △３七と ▲２一圭 △２八と ▲６七角 △７九全 ▲９四金寄 △６三飛
# >> ▲３一圭 △６五玉 ▲３六玉 △６四玉 ▲３二馬 △３六歩
