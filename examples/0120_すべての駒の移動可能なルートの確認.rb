# すべての駒の移動可能なルートの確認
require "./example_helper"

mediator = Mediator.new
player = mediator.player_at(:black)
Piece.each do |piece|
  player.soldiers_create("５五#{piece.name}", from_piece: false)
  player.board["５五"].movable_infos.each do |v|
    soldier = player.board[v[:point]]
    draw = false
    if false
      draw = !soldier
    else
      if soldier
        soldier.abone
      end
      draw = true
    end
    if draw
      # 歩だと二歩になるので
      player.soldiers_create("#{v[:point]}#{v[:promoted] ? '成' : ''}銀", from_piece: false)
    end
  end
  puts mediator.board
  player.board.abone_all
end
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|一
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|二
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|三
# >> | ・ ・ ・ ・ 銀 ・ ・ ・ ・|四
# >> | ・ ・ ・ ・ 歩 ・ ・ ・ ・|五
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|六
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|七
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|八
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|九
# >> +---------------------------+
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> | 全 ・ ・ ・ ・ ・ ・ ・ 全|一
# >> | ・ 全 ・ ・ ・ ・ ・ 全 ・|二
# >> | ・ ・ 全 ・ ・ ・ 全 ・ ・|三
# >> | ・ ・ ・ 銀 ・ 銀 ・ ・ ・|四
# >> | ・ ・ ・ ・ 角 ・ ・ ・ ・|五
# >> | ・ ・ ・ 銀 ・ 銀 ・ ・ ・|六
# >> | ・ ・ 銀 ・ ・ ・ 銀 ・ ・|七
# >> | ・ 銀 ・ ・ ・ ・ ・ 銀 ・|八
# >> | 銀 ・ ・ ・ ・ ・ ・ ・ 銀|九
# >> +---------------------------+
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> | ・ ・ ・ ・ 全 ・ ・ ・ ・|一
# >> | ・ ・ ・ ・ 全 ・ ・ ・ ・|二
# >> | ・ ・ ・ ・ 全 ・ ・ ・ ・|三
# >> | ・ ・ ・ ・ 銀 ・ ・ ・ ・|四
# >> | 銀 銀 銀 銀 飛 銀 銀 銀 銀|五
# >> | ・ ・ ・ ・ 銀 ・ ・ ・ ・|六
# >> | ・ ・ ・ ・ 銀 ・ ・ ・ ・|七
# >> | ・ ・ ・ ・ 銀 ・ ・ ・ ・|八
# >> | ・ ・ ・ ・ 銀 ・ ・ ・ ・|九
# >> +---------------------------+
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> | ・ ・ ・ ・ 全 ・ ・ ・ ・|一
# >> | ・ ・ ・ ・ 全 ・ ・ ・ ・|二
# >> | ・ ・ ・ ・ 全 ・ ・ ・ ・|三
# >> | ・ ・ ・ ・ 銀 ・ ・ ・ ・|四
# >> | ・ ・ ・ ・ 香 ・ ・ ・ ・|五
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|六
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|七
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|八
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|九
# >> +---------------------------+
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|一
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|二
# >> | ・ ・ ・ 全 ・ 全 ・ ・ ・|三
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|四
# >> | ・ ・ ・ ・ 桂 ・ ・ ・ ・|五
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|六
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|七
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|八
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|九
# >> +---------------------------+
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|一
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|二
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|三
# >> | ・ ・ ・ 銀 銀 銀 ・ ・ ・|四
# >> | ・ ・ ・ ・ 銀 ・ ・ ・ ・|五
# >> | ・ ・ ・ 銀 ・ 銀 ・ ・ ・|六
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|七
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|八
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|九
# >> +---------------------------+
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|一
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|二
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|三
# >> | ・ ・ ・ 銀 銀 銀 ・ ・ ・|四
# >> | ・ ・ ・ 銀 金 銀 ・ ・ ・|五
# >> | ・ ・ ・ ・ 銀 ・ ・ ・ ・|六
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|七
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|八
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|九
# >> +---------------------------+
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|一
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|二
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|三
# >> | ・ ・ ・ 銀 銀 銀 ・ ・ ・|四
# >> | ・ ・ ・ 銀 玉 銀 ・ ・ ・|五
# >> | ・ ・ ・ 銀 銀 銀 ・ ・ ・|六
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|七
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|八
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|九
# >> +---------------------------+
