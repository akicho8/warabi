# 戦況の一次退避

require_relative "example_helper"

mediator = Mediator.start
mediator.piece_plot
mediator.execute(["７六歩", "３四歩", "２二角成"])
p mediator
mediator.stack_push
mediator.execute("８四歩")
p mediator
mediator.stack_pop
mediator.execute("同銀")
p mediator
# >> 4手目: ▽後手番
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> |v香v桂v銀v金v玉v金v銀v桂v香|一
# >> | ・v飛 ・ ・ ・ ・ ・ 馬 ・|二
# >> |v歩v歩v歩v歩v歩v歩 ・v歩v歩|三
# >> | ・ ・ ・ ・ ・ ・v歩 ・ ・|四
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|五
# >> | ・ ・ 歩 ・ ・ ・ ・ ・ ・|六
# >> | 歩 歩 ・ 歩 歩 歩 歩 歩 歩|七
# >> | ・ ・ ・ ・ ・ ・ ・ 飛 ・|八
# >> | 香 桂 銀 金 玉 金 銀 桂 香|九
# >> +---------------------------+
# >> ▲先手の持駒:角
# >> ▽後手の持駒:
# >>
# >> 5手目: ▲先手番
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> |v香v桂v銀v金v玉v金v銀v桂v香|一
# >> | ・v飛 ・ ・ ・ ・ ・ 馬 ・|二
# >> |v歩 ・v歩v歩v歩v歩 ・v歩v歩|三
# >> | ・v歩 ・ ・ ・ ・v歩 ・ ・|四
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|五
# >> | ・ ・ 歩 ・ ・ ・ ・ ・ ・|六
# >> | 歩 歩 ・ 歩 歩 歩 歩 歩 歩|七
# >> | ・ ・ ・ ・ ・ ・ ・ 飛 ・|八
# >> | 香 桂 銀 金 玉 金 銀 桂 香|九
# >> +---------------------------+
# >> ▲先手の持駒:角
# >> ▽後手の持駒:
# >>
# >> 5手目: ▲先手番
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> |v香v桂v銀v金v玉v金 ・v桂v香|一
# >> | ・v飛 ・ ・ ・ ・ ・v銀 ・|二
# >> |v歩v歩v歩v歩v歩v歩 ・v歩v歩|三
# >> | ・ ・ ・ ・ ・ ・v歩 ・ ・|四
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|五
# >> | ・ ・ 歩 ・ ・ ・ ・ ・ ・|六
# >> | 歩 歩 ・ 歩 歩 歩 歩 歩 歩|七
# >> | ・ ・ ・ ・ ・ ・ ・ 飛 ・|八
# >> | 香 桂 銀 金 玉 金 銀 桂 香|九
# >> +---------------------------+
# >> ▲先手の持駒:角
# >> ▽後手の持駒:角
# >>
