require "./example_helper"

mediator = Mediator.start
begin
  mediator.execute("▲76歩")
  mediator.execute("△34歩")
  mediator.execute("▲11角成")
rescue => error
  puts error.mediator
  error.mediator.turn_info.turn_max  # => 2
  error.mediator.win_player.location # => <white>
end

# >> 後手の持駒：なし
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> |v香v桂v銀v金v玉v金v銀v桂v香|一
# >> | ・v飛 ・ ・ ・ ・ ・v角 ・|二
# >> |v歩v歩v歩v歩v歩v歩 ・v歩v歩|三
# >> | ・ ・ ・ ・ ・ ・v歩 ・ ・|四
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|五
# >> | ・ ・ 歩 ・ ・ ・ ・ ・ ・|六
# >> | 歩 歩 ・ 歩 歩 歩 歩 歩 歩|七
# >> | ・ 角 ・ ・ ・ ・ ・ 飛 ・|八
# >> | 香 桂 銀 金 玉 金 銀 桂 香|九
# >> +---------------------------+
# >> 先手の持駒：なし
# >> 手数＝2 △３四歩(33) まで
# >> 
# >> 先手番
