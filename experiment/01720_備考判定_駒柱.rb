require "./example_helper"

info = Parser.parse(<<~EOT)
後手の持駒：なし
  ９ ８ ７ ６ ５ ４ ３ ２ １
+---------------------------+
|v香 ・ ・v金v玉 ・ ・v桂v香|一
| ・ ・ ・ ・v飛 ・ ・v角 ・|二
|v歩v歩 ・v歩v金v歩 ・v歩v歩|三
| ・ ・v歩v銀v歩v銀v歩 ・ ・|四
| ・ ・ ・v桂 歩 ・ ・ ・ ・|五
| ・ ・ 歩 銀 金 銀 ・ ・ ・|六
| 歩 歩 ・ 歩 ・ 歩 歩 歩 歩|七
| ・ 角 ・ 金 飛 ・ ・ ・ ・|八
| 香 桂 ・ ・ 玉 ・ ・ 桂 香|九
+---------------------------+
先手の持駒：なし
手数----指手---------消費時間--
   1 57金左
   2 14歩
   3 16歩
   4 15歩
EOT
puts info.to_kif
# >> 先手の備考：駒柱
# >> 後手の備考：駒柱
# >> 後手の持駒：なし
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> |v香 ・ ・v金v玉 ・ ・v桂v香|一
# >> | ・ ・ ・ ・v飛 ・ ・v角 ・|二
# >> |v歩v歩 ・v歩v金v歩 ・v歩v歩|三
# >> | ・ ・v歩v銀v歩v銀v歩 ・ ・|四
# >> | ・ ・ ・v桂 歩 ・ ・ ・ ・|五
# >> | ・ ・ 歩 銀 金 銀 ・ ・ ・|六
# >> | 歩 歩 ・ 歩 ・ 歩 歩 歩 歩|七
# >> | ・ 角 ・ 金 飛 ・ ・ ・ ・|八
# >> | 香 桂 ・ ・ 玉 ・ ・ 桂 香|九
# >> +---------------------------+
# >> 先手の持駒：なし
# >> 手数----指手---------消費時間--
# >>    1 ５七金(68)   (00:00/00:00:00)
# >> *▲備考：駒柱
# >>    2 １四歩(13)   (00:00/00:00:00)
# >>    3 １六歩(17)   (00:00/00:00:00)
# >>    4 １五歩(14)   (00:00/00:00:00)
# >>    5 投了
# >> まで4手で後手の勝ち
