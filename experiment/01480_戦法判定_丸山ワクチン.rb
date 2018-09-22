require "./example_helper"

info = Parser.file_parse("戦型/丸山ワクチン.kif", turn_limit: 6)
puts info.mediator
puts info.to_kif
# >> 後手の持駒：なし
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> |v香v桂v銀v金v玉v金v銀v桂v香|一
# >> | ・ ・ ・ ・v飛 ・ ・ 馬 ・|二
# >> |v歩v歩v歩v歩 ・v歩 ・v歩v歩|三
# >> | ・ ・ ・ ・v歩 ・v歩 ・ ・|四
# >> | ・ ・ ・ ・ ・ ・ ・ 歩 ・|五
# >> | ・ ・ 歩 ・ ・ ・ ・ ・ ・|六
# >> | 歩 歩 ・ 歩 歩 歩 歩 ・ 歩|七
# >> | ・ ・ ・ ・ ・ ・ ・ 飛 ・|八
# >> | 香 桂 銀 金 玉 金 銀 桂 香|九
# >> +---------------------------+
# >> 先手の持駒：角
# >> 手数＝7 ▲２二角成(88) まで
# >> 
# >> 後手番
# >> 後手の囲い：片美濃囲い
# >> 先手の戦型：丸山ワクチン
# >> 後手の戦型：ゴキゲン中飛車
# >> 手合割：平手
# >> 手数----指手---------消費時間--
# >>    1 ７六歩(77)   (00:00/00:00:00)
# >>    2 ３四歩(33)   (00:00/00:00:00)
# >>    3 ２六歩(27)   (00:00/00:00:00)
# >>    4 ５四歩(53)   (00:00/00:00:00)
# >>    5 ２五歩(26)   (00:00/00:00:00)
# >>    6 ５二飛(82)   (00:00/00:00:00)
# >> *△戦型：ゴキゲン中飛車
# >>    7 ２二角成(88) (00:00/00:00:00)
# >> *▲戦型：丸山ワクチン
# >>    8 投了
# >> まで7手で先手の勝ち
