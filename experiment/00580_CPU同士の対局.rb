# CPU同士の対局
require "./example_helper"

mediator = Mediator.start
mediator.piece_plot
loop do
  hand = mediator.current_player.brain.all_hands.sample
  mediator.execute(hand)
  last_captured_piece = mediator.reverse_player.last_captured_piece
  if last_captured_piece && last_captured_piece.key == :king
    break
  end
end
puts mediator.to_s
puts mediator.kif_hand_logs.group_by.with_index{|v, i|i / 8}.values.collect{|v|v.join(" ")}
puts mediator.ki2_hand_logs.group_by.with_index{|v, i|i / 8}.values.collect{|v|v.join(" ")}
# >> 108手目: ▽後手番
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> | とv桂v銀 ・v香v飛v角 ・ ・|一
# >> | と ・ ・ ・ ・ ・v銀 ・ ・|二
# >> | 香 ・ ・ ・v金 ・v桂 ・v香|三
# >> | ・ ・ ・v歩v金v歩 ・v歩 ・|四
# >> |v歩 ・v歩 ・ ・ ・v歩 ・ ・|五
# >> | 歩v歩 歩 ・v歩 ・ ・ ・v歩|六
# >> | ・ ・ 桂 歩 ・ ・ 歩v馬 銀|七
# >> | 銀 ・ 金 ・ ・ 金 飛 ・ 香|八
# >> | ・ ・ ・ ・ 玉 ・ ・ 桂 歩|九
# >> +---------------------------+
# >> ▲先手の持駒:玉
# >> ▽後手の持駒:歩二
# >> ▲６八金(69) ▽４二飛(82) ▲１八飛(28) ▽５二玉(51) ▲２六歩(27) ▽３四歩(33) ▲４八金(49) ▽６二玉(52)
# >> ▲３八飛(18) ▽４四歩(43) ▲１八香(19) ▽４三飛(42) ▲２五歩(26) ▽５二金(41) ▲９六歩(97) ▽５一金(52)
# >> ▲７八銀(79) ▽３二銀(31) ▲８六歩(87) ▽７四歩(73) ▲５六歩(57) ▽２四歩(23) ▲７六歩(77) ▽５四歩(53)
# >> ▲９五歩(96) ▽４一飛(43) ▲９七香(99) ▽６四歩(63) ▲６九金(68) ▽８四歩(83) ▲７七角(88) ▽５二金(61)
# >> ▲８五歩(86) ▽３五歩(34) ▲１六歩(17) ▽３三桂(21) ▲５五歩(56) ▽７二玉(62) ▲２八銀(39) ▽６一金(51)
# >> ▲６八金(69) ▽４三飛(41) ▲８六角(77) ▽４二飛(43) ▲７七金(68) ▽５一金(61) ▲１五歩(16) ▽４五歩(44)
# >> ▲１七銀(28) ▽１四歩(13) ▲２八飛(38) ▽６二金(52) ▲９四歩(95) ▽９二香(91) ▲８七銀(78) ▽８二玉(72)
# >> ▲６九玉(59) ▽４四飛(42) ▲９五角(86) ▽４一飛(44) ▲４六歩(47) ▽３一角(22) ▲４七金(48) ▽１三香(11)
# >> ▲９三歩(94) ▽５三金(62) ▲５四歩(55) ▽８五歩(84) ▲９二歩成(93) ▽５六歩打 ▲８六角(95) ▽１五歩(14)
# >> ▲８三歩打 ▽５二金(51) ▲３四香打 ▽９一玉(82) ▲５九玉(69) ▽８六歩(85) ▲２四歩(25) ▽２五角打
# >> ▲７八金(77) ▽３四角(25) ▲３八飛(28) ▽５一香打 ▲１六歩打 ▽１六歩(15) ▲４五歩(46) ▽６三金(52)
# >> ▲７七桂(89) ▽２二歩打 ▲９三香(97) ▽４五角(34) ▲９六歩打 ▽４四歩打 ▲５七金(47) ▽５四金(63)
# >> ▲４七金(57) ▽２三歩(22) ▲１九歩打 ▽７五歩(74) ▲８二歩成(83) ▽２七角成(45) ▲４八金(47) ▽２四歩(23)
# >> ▲９八銀(87) ▽９五歩打 ▲９一と(82)
# >> ▲６八金 ▽４二飛 ▲１八飛 ▽５二玉 ▲２六歩 ▽３四歩 ▲４八金 ▽６二玉
# >> ▲３八飛 ▽４四歩 ▲１八香 ▽４三飛 ▲２五歩 ▽５二金 ▲９六歩 ▽５一金
# >> ▲７八銀 ▽３二銀 ▲８六歩 ▽７四歩 ▲５六歩 ▽２四歩 ▲７六歩 ▽５四歩
# >> ▲９五歩 ▽４一飛 ▲９七香 ▽６四歩 ▲６九金 ▽８四歩 ▲７七角 ▽５二金
# >> ▲８五歩 ▽３五歩 ▲１六歩 ▽３三桂 ▲５五歩 ▽７二玉 ▲２八銀 ▽６一金
# >> ▲６八金 ▽４三飛 ▲８六角 ▽４二飛 ▲７七金 ▽５一金 ▲１五歩 ▽４五歩
# >> ▲１七銀 ▽１四歩 ▲２八飛 ▽６二金 ▲９四歩 ▽９二香 ▲８七銀 ▽８二玉
# >> ▲６九玉 ▽４四飛 ▲９五角 ▽４一飛 ▲４六歩 ▽３一角 ▲４七金 ▽１三香
# >> ▲９三歩不成 ▽５三金 ▲５四歩 ▽８五歩 ▲９二歩成 ▽５六歩打 ▲８六角 ▽１五歩
# >> ▲８三歩打 ▽５二金 ▲３四香打 ▽９一玉 ▲５九玉 ▽８六歩 ▲２四歩 ▽２五角打
# >> ▲７八金 ▽３四角 ▲３八飛 ▽５一香打 ▲１六歩打 ▽同歩 ▲４五歩 ▽６三金
# >> ▲７七桂 ▽２二歩打 ▲９三香不成 ▽４五角 ▲９六歩打 ▽４四歩打 ▲５七金 ▽５四金
# >> ▲４七金 ▽２三歩 ▲１九歩打 ▽７五歩 ▲８二歩成 ▽２七角成 ▲４八金 ▽２四歩
# >> ▲９八銀 ▽９五歩打 ▲９一と
