require "./example_helper"

info = Parser.parse(<<~EOT)
後手：羽生善治
後手の持駒：飛　角　金　銀　桂　香　歩四　
  ９ ８ ７ ６ ５ ４ ３ ２ １
+---------------------------+
|v香v桂 ・ ・ ・ ・ ・ ・ ・|一
| ・ ・ ・ 馬 ・ ・ 龍 ・ ・|二
| ・ ・v玉 ・v歩 ・ ・ ・ ・|三
|v歩 ・ ・ ・v金 ・ ・ ・ ・|四
| ・ ・v銀 ・ ・ ・v歩 ・ ・|五
| ・ ・ ・ ・ 玉 ・ ・ ・ ・|六
| 歩 歩 ・ 歩 歩v歩 歩 ・ 歩|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|八
| 香 桂v金 ・v金 ・ ・ 桂 香|九
+---------------------------+
先手：谷川浩司
先手の持駒：銀二　歩四　
手数＝171  ▲６二角成  まで
*第44期王位戦第4局

後手番
EOT
puts info.to_bod
# >> 後手：羽生善治
# >> 後手の持駒：飛 角 金 銀 桂 香 歩四
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> |v香v桂 ・ ・ ・ ・ ・ ・ ・|一
# >> | ・ ・ ・ 馬 ・ ・ 龍 ・ ・|二
# >> | ・ ・v玉 ・v歩 ・ ・ ・ ・|三
# >> |v歩 ・ ・ ・v金 ・ ・ ・ ・|四
# >> | ・ ・v銀 ・ ・ ・v歩 ・ ・|五
# >> | ・ ・ ・ ・ 玉 ・ ・ ・ ・|六
# >> | 歩 歩 ・ 歩 歩v歩 歩 ・ 歩|七
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|八
# >> | 香 桂v金 ・v金 ・ ・ 桂 香|九
# >> +---------------------------+
# >> 先手：谷川浩司
# >> 先手の持駒：銀二 歩四
# >> 手数＝171  ▲６二角成  まで
# >> *第44期王位戦第4局
# >> 
# >> 後手番
# >> 
# >> 後手の持駒：飛 角 金 銀 桂 香 歩四
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> |v香v桂 ・ ・ ・ ・ ・ ・ ・|一
# >> | ・ ・ ・ 馬 ・ ・ 龍 ・ ・|二
# >> | ・ ・v玉 ・v歩 ・ ・ ・ ・|三
# >> |v歩 ・ ・ ・v金 ・ ・ ・ ・|四
# >> | ・ ・v銀 ・ ・ ・v歩 ・ ・|五
# >> | ・ ・ ・ ・ 玉 ・ ・ ・ ・|六
# >> | 歩 歩 ・ 歩 歩v歩 歩 ・ 歩|七
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|八
# >> | 香 桂v金 ・v金 ・ ・ 桂 香|九
# >> +---------------------------+
# >> 先手の持駒：銀二 歩四
# >> 手数＝171 まで
# >> 
# >> 後手番
