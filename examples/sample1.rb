# -*- coding: utf-8 -*-
#
# 移動する駒の推測
#

begin
  require_relative "../lib/bushido"
rescue LoadError
  require File.expand_path(File.join(File.dirname(__FILE__), "../lib/bushido"))
end

include Bushido

board = Board.new
players = []
players << Player.create2(:black, board)
players << Player.create2(:white, board)
players.each(&:piece_plot)
players[0].execute("7六歩")
players[1].execute("3四歩")
players[0].execute("2二角成")
players[0].pieces.collect(&:name) # => ["角"]
puts board
# >> +------+------+------+------+------+------+------+------+------+----+
# >> |    9 |    8 |    7 |    6 |    5 |    4 |    3 |    2 |    1 |    |
# >> +------+------+------+------+------+------+------+------+------+----+
# >> | 香↓ | 桂↓ | 銀↓ | 金↓ | 玉↓ | 金↓ | 銀↓ | 桂↓ | 香↓ | 一 |
# >> |      | 飛↓ |      |      |      |      |      | 馬   |      | 二 |
# >> | 歩↓ | 歩↓ | 歩↓ | 歩↓ | 歩↓ | 歩↓ |      | 歩↓ | 歩↓ | 三 |
# >> |      |      |      |      |      |      | 歩↓ |      |      | 四 |
# >> |      |      |      |      |      |      |      |      |      | 五 |
# >> |      |      | 歩   |      |      |      |      |      |      | 六 |
# >> | 歩   | 歩   |      | 歩   | 歩   | 歩   | 歩   | 歩   | 歩   | 七 |
# >> |      |      |      |      |      |      |      | 飛   |      | 八 |
# >> | 香   | 桂   | 銀   | 金   | 玉   | 金   | 銀   | 桂   | 香   | 九 |
# >> +------+------+------+------+------+------+------+------+------+----+
